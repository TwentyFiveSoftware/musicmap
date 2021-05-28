class DatabaseSong {
  final String id;
  final String name;
  final String albumId;
  int positionX, positionY;

  DatabaseSong(
      this.id, this.name, this.albumId, this.positionX, this.positionY);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'albumId': albumId,
        'position_x': positionX,
        'position_y': positionY,
      };

  DatabaseSong.fromDatabase(Map<String, dynamic> row)
      : id = row['id'],
        name = row['name'],
        albumId = row['albumId'],
        positionX = row['position_x'],
        positionY = row['position_y'];
}
