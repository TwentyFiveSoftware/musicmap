import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async =>
    openDatabase('musicmap.db', version: 1, onOpen: (Database db) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS songs(id TEXT PRIMARY KEY, name TEXT, albumName TEXT, albumImageUrl TEXT, artistIds TEXT, position_x INTEGER, position_y INTEGER)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS artists(id TEXT PRIMARY KEY, name TEXT, imageUrl TEXT, position_x INTEGER, position_y INTEGER)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS artistSongLinks(artistId TEXT NOT NULL, songId TEXT NOT NULL, PRIMARY KEY (artistId, songId))');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS links(a TEXT NOT NULL, b TEXT NOT NULL, notes TEXT, PRIMARY KEY (a, b))');
    });

Future<void> dropDatabase() async => deleteDatabase('musicmap.db');
