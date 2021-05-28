import 'package:flutter/material.dart';
import './DatabaseSong.dart';
import './DatabaseAlbum.dart';

enum NodeType { SONG, ARTIST }

class NodeInfo {
  final String id;
  int x, y;
  final String title;
  final String subtitle;
  final String imageUrl;
  final NodeType type;
  final GlobalKey key = GlobalKey();

  NodeInfo(this.id, this.x, this.y, this.title, this.subtitle, this.imageUrl,
      this.type);
}

class SongNodeInfo extends NodeInfo {
  DatabaseSong song;

  SongNodeInfo(DatabaseSong song, DatabaseAlbum album)
      : super(song.id, song.positionX, song.positionY, song.name, album.name,
            album.imageUrl, NodeType.SONG) {
    this.song = song;
  }
}
