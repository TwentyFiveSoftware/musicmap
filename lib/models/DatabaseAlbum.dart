class DatabaseAlbum {
  final String id;
  final String name;
  final String imageUrl;

  DatabaseAlbum(this.id, this.name, this.imageUrl);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
      };

  DatabaseAlbum.fromDatabase(Map<String, dynamic> row)
      : id = row['id'],
        name = row['name'],
        imageUrl = row['imageUrl'];
}
