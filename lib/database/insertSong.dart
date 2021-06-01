import 'package:sqflite/sqflite.dart';
import '../models/SpotifySong.dart';
import '../models/SpotifyArtist.dart';
import '../requests/spotifyApiRequest.dart';
import './getDatabase.dart';

Future<void> insertSong(SpotifySong song, int x, int y) async {
  final db = await getDatabase();

  // NODES
  await db.insert('songs', song.toDatabaseSong(x, y).toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore);

  await db.insert('albums', song.album.toDatabaseAlbum().toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore);

  for (SpotifyArtist artist in song.artists) {
    final artistJson = await spotifyApiRequest('artists/${artist.id}');
    final artistMap = {
      'id': artistJson['id'],
      'name': artistJson['name'],
      'imageUrl': artistJson['images'][0]['url'],
      'position_x': x,
      'position_y': y,
    };

    await db.insert('artists', artistMap,
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // EDGES
  for (SpotifyArtist artist in song.artists) {
    await db.insert(
        'artistSongLinks', {'artistId': artist.id, 'songId': song.id},
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }
}
