import 'package:flutter/material.dart';

enum NodeType {
  SONG,
  ARTIST
}

class NodeInfo {
  final int id;
  final double x;
  final double y;
  final String text;
  final NodeType type;
  final GlobalKey key = GlobalKey();

  NodeInfo(this.id, this.x, this.y, this.text, this.type);
}