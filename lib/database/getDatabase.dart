import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async =>
    openDatabase('musicmap.db', version: 1, onCreate: (Database db, _) async {
      await db.execute(
          'CREATE TABLE songs(id TEXT PRIMARY KEY, name TEXT, albumId TEXT, playUrl TEXT, position_x INTEGER, position_y INTEGER)');
    });
