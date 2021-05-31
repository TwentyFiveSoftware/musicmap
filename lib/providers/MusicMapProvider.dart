import 'package:flutter/material.dart';
import '../models/EdgeInfo.dart';
import '../models/NodeInfo.dart';
import '../models/DatabaseSong.dart';
import '../models/DatabaseAlbum.dart';
import '../models/DatabaseArtist.dart';
import '../database/getDatabase.dart';

class MusicMapProvider with ChangeNotifier {
  List<NodeInfo> _nodes = [];
  List<EdgeInfo> _edges = [];

  List<DatabaseArtist> _artists = [];
  List<Map<String, dynamic>> _artistSongLinks = [];
  List<SongNodeInfo> _songs = [];

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

    List<DatabaseSong> songs = (await db.query('songs'))
        .map((row) => DatabaseSong.fromDatabase(row))
        .toList();
    List<DatabaseAlbum> albums = (await db.query('albums'))
        .map((row) => DatabaseAlbum.fromDatabase(row))
        .toList();

    _songs = songs
        .map((song) => SongNodeInfo(
            song, albums.firstWhere((album) => album.id == song.albumId)))
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
}
