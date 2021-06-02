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

Future<void> deleteNode(NodeInfo nodeInfo) async {
  final db = await getDatabase();

  await db.delete('links',
      where: 'a = ? OR b = ?', whereArgs: [nodeInfo.id, nodeInfo.id]);

  if (nodeInfo is SongNodeInfo) {
    await db.delete('artistSongLinks',
        where: 'songId = ?', whereArgs: [nodeInfo.song.id]);
    await db.delete('songs', where: 'id = ?', whereArgs: [nodeInfo.song.id]);
    return;
  }
  if (nodeInfo is ArtistNodeInfo) {
    await db.delete('artistSongLinks',
        where: 'artistId = ?', whereArgs: [nodeInfo.artist.id]);
    await db.delete('artists', where: 'id = ?', whereArgs: [nodeInfo.artist.id]);
    return;
  }
}
