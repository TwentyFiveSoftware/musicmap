class DatabaseArtist {
  final String id;
  final String name;
  final String imageUrl;
  int positionX, positionY;

  DatabaseArtist(
      this.id, this.name, this.imageUrl, this.positionX, this.positionY);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'position_x': positionX,
        'position_y': positionY,
      };

  DatabaseArtist.fromDatabase(Map<String, dynamic> row)
      : id = row['id'],
        name = row['name'],
        imageUrl = row['imageUrl'],
        positionX = row['position_x'],
        positionY = row['position_y'];
}
