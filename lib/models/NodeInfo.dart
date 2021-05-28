import 'package:flutter/material.dart';
import './DatabaseSong.dart';

enum NodeType { SONG, ARTIST }

class NodeInfo {
  final String id;
  int x;
  int y;
  final String text;
  final NodeType type;
  final GlobalKey key = GlobalKey();

  NodeInfo(this.id, this.x, this.y, this.text, this.type);
}

class SongNodeInfo extends NodeInfo {
  DatabaseSong song;

  SongNodeInfo(DatabaseSong song)
      : super(
            song.id, song.positionX, song.positionY, song.name, NodeType.SONG) {
    this.song = song;
  }
}
