import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async =>
    openDatabase('musicmap.db', version: 1, onOpen: (Database db) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS songs(id TEXT PRIMARY KEY, name TEXT, albumId TEXT, position_x INTEGER, position_y INTEGER)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS albums(id TEXT PRIMARY KEY, name TEXT, imageUrl TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS artists(id TEXT PRIMARY KEY, name TEXT, imageUrl TEXT, position_x INTEGER, position_y INTEGER)');
    });
