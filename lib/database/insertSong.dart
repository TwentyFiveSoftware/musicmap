import 'package:sqflite/sqflite.dart';
import '../models/SpotifySong.dart';
import '../models/SpotifyArtist.dart';
import '../requests/spotifyApiRequest.dart';
import '../models/DatabaseSong.dart';
import './getDatabase.dart';

Future<void> insertSong(SpotifySong song, int x, int y) async {
  final db = await getDatabase();

  // NODES
  await db.insert('songs', song.toDatabaseSong(x, y).toMap(),
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

  // EDGES (EDGES FROM RE-ADDED ARTISTS TO SONGS AS WELL)
  final List<DatabaseSong> allSongs = (await db.query('songs'))
      .map((row) => DatabaseSong.fromDatabase(row))
      .toList();

  for (DatabaseSong s in allSongs)
    for (SpotifyArtist a in song.artists)
      if (s.artistIds.split(';').contains(a.id))
        await db.insert('artistSongLinks', {'artistId': a.id, 'songId': s.id},
            conflictAlgorithm: ConflictAlgorithm.ignore);
}
