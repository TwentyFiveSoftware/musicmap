import '../models/NodeInfo.dart';
import './getDatabase.dart';

Future<void> updateNode(NodeInfo nodeInfo) async {
  final db = await getDatabase();

  if (nodeInfo is SongNodeInfo) {
    await db.update('songs', nodeInfo.song.toMap(),
        where: 'id = ?', whereArgs: [nodeInfo.song.id]);
    return;
  }

  if (nodeInfo is ArtistNodeInfo) {
    await db.update('artists', nodeInfo.artist.toMap(),
        where: 'id = ?', whereArgs: [nodeInfo.artist.id]);
    return;
  }
}
