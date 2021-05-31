import 'package:sqflite/sqflite.dart';
import '../models/NodeInfo.dart';
import './getDatabase.dart';

Future<void> createLink(
    NodeInfo fromNode, List<NodeInfo> toNodes, String notes) async {
  final db = await getDatabase();

  for (NodeInfo toNode in toNodes) {
    final rows = await db.query('links',
        where: '(a = ? AND b = ?) OR (a = ? AND b = ?)',
        whereArgs: [fromNode.id, toNode.id, toNode.id, fromNode.id]);

    if (rows.length > 0) continue;

    await db.insert('links', {'a': fromNode.id, 'b': toNode.id, 'notes': notes},
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }
}
