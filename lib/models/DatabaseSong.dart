class DatabaseSong {
  final String id;
  final String name;
  final String albumName;
  final String albumImageUrl;
  final String artistIds;
  int positionX, positionY;

  DatabaseSong(this.id, this.name, this.albumName, this.albumImageUrl,
      this.artistIds, this.positionX, this.positionY);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'albumName': albumName,
        'albumImageUrl': albumImageUrl,
        'artistIds': artistIds,
        'position_x': positionX,
        'position_y': positionY,
      };

  DatabaseSong.fromDatabase(Map<String, dynamic> row)
      : id = row['id'],
        name = row['name'],
        albumName = row['albumName'],
        albumImageUrl = row['albumImageUrl'],
        artistIds = row['artistIds'],
        positionX = row['position_x'],
        positionY = row['position_y'];
}
