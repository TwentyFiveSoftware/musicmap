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

  MusicMapProvider() {
    fetchNodesFromDatabase();
  }

  Future<void> fetchNodesFromDatabase() async {
    _nodes.clear();

    final db = await getDatabase();

    List<DatabaseArtist> artists = (await db.query('artists'))
        .map((row) => DatabaseArtist.fromDatabase(row))
        .toList();
    _nodes.addAll(artists.map((artist) => ArtistNodeInfo(artist)));

    List<DatabaseSong> songs = (await db.query('songs'))
        .map((row) => DatabaseSong.fromDatabase(row))
        .toList();
    List<DatabaseAlbum> albums = (await db.query('albums'))
        .map((row) => DatabaseAlbum.fromDatabase(row))
        .toList();

    _nodes.addAll(songs.map((song) => SongNodeInfo(
        song, albums.firstWhere((album) => album.id == song.albumId))));

    notifyListeners();
  }

  List<NodeInfo> get nodes => _nodes;

  List<EdgeInfo> get edges => _edges;
}
