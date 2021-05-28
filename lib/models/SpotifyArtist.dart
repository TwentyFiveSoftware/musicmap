class SpotifyArtist {
  final String id;
  final String name;

  SpotifyArtist(this.id, this.name);

  SpotifyArtist.fromJson(dynamic json)
      : id = json['id'],
        name = json['name'];
}
