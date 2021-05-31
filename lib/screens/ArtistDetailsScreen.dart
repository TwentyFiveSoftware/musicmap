import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/NodeInfo.dart';
import '../providers/MusicMapProvider.dart';

class ArtistDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ArtistNodeInfo artistNodeInfo =
        ModalRoute.of(context).settings.arguments as ArtistNodeInfo;

    final MusicMapProvider provider =
        Provider.of<MusicMapProvider>(context, listen: false);
    final List<SongNodeInfo> songs =
        provider.getSongsOfArtist(artistNodeInfo.artist);

    // TEMP
    int random = Random().nextInt(provider.nodes.length - 3);
    final List<NodeInfo> links =
        provider.nodes.getRange(random, random + 3).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Artist'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.location_pin),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    artistNodeInfo.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            artistNodeInfo.title,
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 40),
              Text(
                'SONG' + (songs.length > 1 ? 'S' : ''),
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              ...songs.map((song) => ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed('/song_details', arguments: song),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                    leading: Image.network(
                      song.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(song.title),
                    subtitle: Text(song.subtitle),
                  )),
              Divider(height: 40),
              Text(
                'LINKS',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              ...links.map((link) => ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                    leading: Image.network(
                      link.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(link.title),
                    subtitle: Text('xxx xxx xxx'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
