import 'package:flutter/material.dart';
import 'package:musicmap/models/SpotifyArtist.dart';
import 'package:musicmap/providers/MusicMapProvider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/SpotifySong.dart';
import '../requests/spotifyApiRequest.dart';
import '../database/getDatabase.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController searchQueryController = TextEditingController();
  List<SpotifySong> songs = [];

  @override
  void initState() {
    super.initState();
    searchQueryController.addListener(searchChangeListener);
  }

  @override
  void dispose() {
    searchQueryController.removeListener(searchChangeListener);
    searchQueryController.dispose();
    super.dispose();
  }

  void searchChangeListener() async {
    if (searchQueryController.text.length == 0) {
      setState(() {
        songs = [];
      });
      return;
    }

    Map<String, dynamic> response = await spotifyApiRequest(
        'search?type=track&market=DE&q=${searchQueryController.text}');

    List<dynamic> items = response['tracks']['items'];

    try {
      setState(() {
        songs = items.map((json) => SpotifySong.fromJson(json)).toList();
      });
    } catch (_) {}
  }

  void selectSong(BuildContext context, SpotifySong song) async {
    final db = await getDatabase();

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

    await Provider.of<MusicMapProvider>(context, listen: false)
        .fetchNodesFromDatabase();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchQueryController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search for Songs and Albums',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
          ),
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2.color, fontSize: 16),
          cursorColor: Theme.of(context).accentColor,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => searchQueryController.clear(),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () => selectSong(context, songs[index]),
          child: ListTile(
            leading: Image.network(songs[index].album.imageSmallUrl, width: 50),
            title: Text(songs[index].name),
            subtitle: Text(songs[index]
                .artists
                .map((artist) => artist.name)
                .toList()
                .join(', ')),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
