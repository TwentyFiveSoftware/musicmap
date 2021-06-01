import './DatabaseSong.dart';
import './DatabaseAlbum.dart';
import './DatabaseArtist.dart';

enum NodeType { SONG, ARTIST }

class NodeInfo {
  final String id;
  final int x, y;
  final String title;
  final String subtitle;
  final String imageUrl;
  final NodeType type;

  NodeInfo(this.id, this.x, this.y, this.title, this.subtitle, this.imageUrl,
      this.type);

  void updatePosition(int x, int y) {}
}

class SongNodeInfo extends NodeInfo {
  DatabaseSong song;

  SongNodeInfo(DatabaseSong song, DatabaseAlbum album)
      : super('song:${song.id}', song.positionX, song.positionY, song.name,
            album.name, album.imageUrl, NodeType.SONG) {
    this.song = song;
  }

  @override
  void updatePosition(int x, int y) {
    song.positionX = x;
    song.positionY = y;
  }
}

class ArtistNodeInfo extends NodeInfo {
  DatabaseArtist artist;

  ArtistNodeInfo(DatabaseArtist artist)
      : super('artist:${artist.id}', artist.positionX, artist.positionY,
            artist.name, '', artist.imageUrl, NodeType.ARTIST) {
    this.artist = artist;
  }

  @override
  void updatePosition(int x, int y) {
    artist.positionX = x;
    artist.positionY = y;
  }
}
