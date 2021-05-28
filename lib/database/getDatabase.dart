import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async =>
    openDatabase('musicmap.db', version: 1, onOpen: (Database db) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS songs(id TEXT PRIMARY KEY, name TEXT, albumId TEXT, position_x INTEGER, position_y INTEGER)');
    });
