import 'package:musicmap/models/DatabaseSong.dart';

import './SpotifyArtist.dart';
import './SpotifyAlbum.dart';

class SpotifySong {
  final String id;
  final String name;
  final List<SpotifyArtist> artists;
  final SpotifyAlbum album;

  SpotifySong(this.id, this.name, this.artists, this.album);

  SpotifySong.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        album = SpotifyAlbum.fromJson(json['album']),
        artists = (json['artists'] as List<dynamic>)
            .map((a) => SpotifyArtist.fromJson(a))
            .toList();

  DatabaseSong toDatabaseSong() => DatabaseSong(id, name, album.id, 0, 0);
}
