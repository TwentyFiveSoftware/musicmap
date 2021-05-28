import 'package:flutter/material.dart';
import '../models/SpotifySong.dart';
import '../requests/spotifyApiRequest.dart';

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

    (() async {
      searchQueryController.addListener(() async {
        if (searchQueryController.text.length == 0) {
          setState(() {
            songs = [];
          });
          return;
        }

        Map<String, dynamic> response = await spotifyApiRequest(
            'search?type=track&market=DE&q=${searchQueryController.text}');

        List<dynamic> items = response['tracks']['items'];

        setState(() {
          songs = items.map((json) => SpotifySong.fromJson(json)).toList();
        });
      });
    })();
  }

  @override
  void dispose() {
    searchQueryController.dispose();
    super.dispose();
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
        itemBuilder: (BuildContext context, int index) => ListTile(
          leading: Image.network(songs[index].album.imageSmallUrl, width: 50),
          title: Text(songs[index].name),
          subtitle: Text(songs[index]
              .artists
              .map((artist) => artist.name)
              .toList()
              .join(', ')),
          tileColor: Theme.of(context).backgroundColor,
        ),
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
