import 'package:sqflite/sqflite.dart';
import '../models/SpotifySong.dart';
import '../models/SpotifyArtist.dart';
import '../requests/spotifyApiRequest.dart';
import './getDatabase.dart';

Future<void> insertSong(SpotifySong song) async {
  final db = await getDatabase();

  // NODES
  await db.insert('songs', song.toDatabaseSong().toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore);

  await db.insert('albums', song.album.toDatabaseAlbum().toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore);

  for (SpotifyArtist artist in song.artists) {
    final artistJson = await spotifyApiRequest('artists/${artist.id}');
    final artistMap = {
      'id': artistJson['id'],
      'name': artistJson['name'],
      'imageUrl': artistJson['images']
          [(artistJson['images'] as List<dynamic>).length - 1]['url'],
      'position_x': 0,
      'position_y': 0,
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
