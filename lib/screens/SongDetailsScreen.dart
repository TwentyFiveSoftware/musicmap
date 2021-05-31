import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/NodeInfo.dart';
import '../models/DatabaseArtist.dart';
import '../providers/MusicMapProvider.dart';

class SongDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SongNodeInfo songNodeInfo =
        ModalRoute.of(context).settings.arguments as SongNodeInfo;

    final MusicMapProvider provider =
        Provider.of<MusicMapProvider>(context, listen: false);
    final List<DatabaseArtist> artists =
        provider.getArtistsOfSong(songNodeInfo.song);

    // TEMP
    int random = Random().nextInt(provider.nodes.length - 3);
    final List<NodeInfo> links =
        provider.nodes.getRange(random, random + 3).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Song'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {},
          ),
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
                    songNodeInfo.imageUrl,
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
                            songNodeInfo.title,
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            songNodeInfo.subtitle,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).textTheme.bodyText1.color,
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
                'ARTIST' + (artists.length > 1 ? 'S' : ''),
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              ...artists.map((artist) => ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    leading: Image.network(
                      artist.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(artist.name),
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
