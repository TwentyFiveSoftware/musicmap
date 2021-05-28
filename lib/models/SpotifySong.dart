import './SpotifyArtist.dart';
import './SpotifyAlbum.dart';

class SpotifySong {
  final String name;
  final List<SpotifyArtist> artists;
  final SpotifyAlbum album;
  final String playUrl;

  SpotifySong(this.name, this.artists, this.album, this.playUrl);

  SpotifySong.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        playUrl = json['external_urls']['spotify'],
        album = SpotifyAlbum.fromJson(json['album']),
        artists = (json['artists'] as List<dynamic>)
            .map((a) => SpotifyArtist.fromJson(a))
            .toList();
}
