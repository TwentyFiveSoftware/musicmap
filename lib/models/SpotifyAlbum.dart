import './SpotifyArtist.dart';

class SpotifyAlbum {
  final String name;
  final List<SpotifyArtist> artists;
  final String releaseDate;
  final String imageLargeUrl;
  final String imageSmallUrl;

  SpotifyAlbum(this.name, this.artists, this.releaseDate, this.imageLargeUrl,
      this.imageSmallUrl);

  SpotifyAlbum.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        releaseDate = json['releaseDate'],
        imageLargeUrl = json['images'][0]['url'],
        imageSmallUrl = json['images'][(json['images'] as List<dynamic>).length - 1]['url'],
        artists = (json['artists'] as List<dynamic>)
            .map((a) => SpotifyArtist.fromJson(a))
            .toList();
}
