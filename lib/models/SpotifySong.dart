import './SpotifyArtist.dart';
import './SpotifyAlbum.dart';

class SpotifySong {
  final String id;
  final String name;
  final List<SpotifyArtist> artists;
  final SpotifyAlbum album;
  final String playUrl;

  SpotifySong(this.id, this.name, this.artists, this.album, this.playUrl);

  SpotifySong.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        playUrl = json['external_urls']['spotify'],
        album = SpotifyAlbum.fromJson(json['album']),
        artists = (json['artists'] as List<dynamic>)
            .map((a) => SpotifyArtist.fromJson(a))
            .toList();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'albumId': album.id,
        'playUrl': playUrl,
        'position_x': 0,
        'position_y': 0,
      };

  @override
  String toString() =>
      'SpotifySong(id: $id, name: $name, albumId: ${album.id}, playUrl: $playUrl)';
}
