class DatabaseArtist {
  final String id;
  final String name;
  final String imageUrl;
  int positionX, positionY;

  DatabaseArtist(
      this.id, this.name, this.imageUrl, this.positionX, this.positionY);

  DatabaseArtist.fromDatabase(Map<String, dynamic> row)
      : id = row['id'],
        name = row['name'],
        imageUrl = row['imageUrl'],
        positionX = row['position_x'],
        positionY = row['position_y'];
}
