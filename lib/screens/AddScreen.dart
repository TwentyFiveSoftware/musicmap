import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/insertSong.dart';
import '../providers/MusicMapProvider.dart';
import '../models/SpotifySong.dart';
import '../requests/spotifyApiRequest.dart';
import '../widgets/SquareNetworkImage.dart';
import '../config/config.dart' as config;

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
    if (searchQueryController.text.isEmpty) {
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
        songs = items
            .map((json) => SpotifySong.fromJson(json, smallAlbumImage: true))
            .toList();
      });
    } catch (_) {}
  }

  void selectSong(BuildContext context, SpotifySong song) async {
    Offset pos =
        Offset(config.MUSIC_MAP_WIDTH / 2, config.MUSIC_MAP_HEIGHT / 2);

    await insertSong(song, pos.dx.toInt(), pos.dy.toInt());

    final provider = Provider.of<MusicMapProvider>(context, listen: false);

    provider.transitionToPositionOnNextMapView = pos;
    await provider.update();

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
            hintText: 'Search for songs',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
          ),
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2.color, fontSize: 16),
          cursorColor: Theme.of(context).accentColor,
        ),
        actions: searchQueryController.text.isEmpty
            ? []
            : [
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
            leading: SquareNetworkImage(songs[index].albumImageUrl, 50),
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
