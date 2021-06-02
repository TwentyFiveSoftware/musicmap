import './SpotifyArtist.dart';
import './DatabaseSong.dart';

class SpotifySong {
  final String id;
  final String name;
  final List<SpotifyArtist> artists;
  final String albumName;
  final String albumImageUrl;

  SpotifySong(
      this.id, this.name, this.artists, this.albumName, this.albumImageUrl);

  SpotifySong.fromJson(Map<String, dynamic> json,
      {bool smallAlbumImage = false})
      : id = json['id'],
        name = json['name'],
        albumName = json['album']['name'],
        albumImageUrl = json['album']['images'][smallAlbumImage
            ? ((json['album']['images'] as List<dynamic>).length - 1)
            : 0]['url'],
        artists = (json['artists'] as List<dynamic>)
            .map((a) => SpotifyArtist.fromJson(a))
            .toList();

  DatabaseSong toDatabaseSong(int x, int y) => DatabaseSong(id, name, albumName,
      albumImageUrl, artists.map((artist) => artist.id).join(';'), x, y);
}
