import 'package:flutter/material.dart';
import '../models/EdgeInfo.dart';
import '../models/NodeInfo.dart';
import '../models/DatabaseSong.dart';
import '../database/getDatabase.dart';

class MusicMapProvider with ChangeNotifier {
  List<NodeInfo> _nodes = [];
  List<EdgeInfo> _edges = [];

  MusicMapProvider() {
    fetchNodesFromDatabase();
  }

  Future<void> fetchNodesFromDatabase() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> songs = await db.query('songs');
    _nodes = songs
        .map((song) => SongNodeInfo(DatabaseSong.fromDatabase(song)))
        .toList();

    notifyListeners();
  }

  List<NodeInfo> get nodes => _nodes;

  List<EdgeInfo> get edges => _edges;
}
