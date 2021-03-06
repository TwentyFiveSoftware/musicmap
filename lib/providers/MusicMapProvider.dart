import 'package:flutter/material.dart';
import '../models/EdgeInfo.dart';
import '../models/NodeInfo.dart';
import '../models/DatabaseSong.dart';
import '../models/DatabaseArtist.dart';
import '../database/getDatabase.dart';

class MusicMapProvider with ChangeNotifier {
  List<NodeInfo> _nodes = [];
  List<EdgeInfo> _edges = [];

  List<DatabaseArtist> _artists = [];
  List<Map<String, dynamic>> _artistSongLinks = [];
  List<SongNodeInfo> _songs = [];
  List<LinkInfo> _links = [];

  Offset transitionToPositionOnNextMapView;

  MusicMapProvider() {
    update();
  }

  Future<void> update() async {
    await _fetchNodesFromDatabase();
    await _fetchEdgesFromDatabase();
    notifyListeners();
  }

  Future<void> _fetchNodesFromDatabase() async {
    List<NodeInfo> newNodes = [];

    final db = await getDatabase();

    _artists = (await db.query('artists'))
        .map((row) => DatabaseArtist.fromDatabase(row))
        .toList();
    newNodes.addAll(_artists.map((artist) => ArtistNodeInfo(artist)));

    _songs = (await db.query('songs'))
        .map((row) => DatabaseSong.fromDatabase(row))
        .map((song) => SongNodeInfo(song))
        .toList();

    newNodes.addAll(_songs);

    _nodes = newNodes;
  }

  Future<void> _fetchEdgesFromDatabase() async {
    List<EdgeInfo> newEdges = [];

    final db = await getDatabase();

    _artistSongLinks = await db.query('artistSongLinks');
    newEdges.addAll(_artistSongLinks.map((row) =>
        EdgeInfo('artist:${row['artistId']}', 'song:${row['songId']}')));

    _links = (await db.query('links'))
        .map((row) => LinkInfo(row['a'], row['b'], row['notes']))
        .toList();
    newEdges.addAll(_links);

    _edges = newEdges;
  }

  List<NodeInfo> get nodes => _nodes;

  List<EdgeInfo> get edges => _edges;

  Map<String, NodeInfo> get nodeMap =>
      Map.fromIterable(_nodes, key: (n) => n.id, value: (n) => n);

  List<DatabaseArtist> getArtistsOfSong(DatabaseSong song) {
    List<dynamic> artistIds = _artistSongLinks
        .where((link) => link['songId'] == song.id)
        .map((link) => link['artistId'])
        .toList();
    return _artists.where((artist) => artistIds.contains(artist.id)).toList();
  }

  List<SongNodeInfo> getSongsOfArtist(DatabaseArtist artist) {
    List<dynamic> songIds = _artistSongLinks
        .where((link) => link['artistId'] == artist.id)
        .map((link) => link['songId'])
        .toList();

    return _songs
        .where((songInfo) => songIds.contains(songInfo.song.id))
        .toList();
  }

  NodeInfo getNodeInfo(String id) => _nodes.firstWhere((node) => node.id == id);

  List<LinkInfo> getLinksOfNode(String nodeId) => _links
      .where((link) => link.nodeA == nodeId || link.nodeB == nodeId)
      .toList();

  void setTransitionToNode(NodeInfo node) {
    transitionToPositionOnNextMapView = Offset(node.x * 1.0, node.y * 1.0);
  }
}
