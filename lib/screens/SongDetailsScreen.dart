import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/NodeInfo.dart';
import '../models/DatabaseArtist.dart';
import '../providers/MusicMapProvider.dart';
import '../providers/SelectNodesProvider.dart';
import '../widgets/NodeDetailsLinkSection.dart';
import '../models/ConfirmDialogInfo.dart';
import '../widgets/ConfirmDialog.dart';
import '../widgets/SquareNetworkImage.dart';
import '../database/nodes.dart';

class SongDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SongNodeInfo songNodeInfo =
        ModalRoute.of(context).settings.arguments as SongNodeInfo;

    final MusicMapProvider provider =
        Provider.of<MusicMapProvider>(context, listen: false);
    final List<DatabaseArtist> artists =
        provider.getArtistsOfSong(songNodeInfo.song);

    return Scaffold(
      appBar: AppBar(
        title: Text('Song'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () => launch(
                'https://open.spotify.com/track/${songNodeInfo.song.id}'),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => ConfirmDialog(ConfirmDialogInfo(
                title: 'Are you sure?',
                content: 'Do you really want to delete this song?',
                cancelButton: 'Cancel',
                confirmButton: 'Delete',
                successCallback: () async {
                  await deleteNode(songNodeInfo);
                  await Provider.of<MusicMapProvider>(context, listen: false)
                      .update();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )),
            ),
          ),
          IconButton(
            icon: Icon(Icons.location_pin),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              provider.setTransitionToNode(songNodeInfo);
            },
          ),
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () {
              Provider.of<SelectNodesProvider>(context, listen: false)
                  .startSelecting(songNodeInfo);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
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
                  SquareNetworkImage(songNodeInfo.imageUrl, 80),
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
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (artists.length > 0) Divider(height: 40),
              if (artists.length > 0)
                Text(
                  'ARTIST' + (artists.length > 1 ? 'S' : ''),
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                ),
              ...artists.map((artist) => ListTile(
                    onTap: () => Navigator.of(context).pushNamed(
                        '/artist_details',
                        arguments: provider.getNodeInfo('artist:${artist.id}')),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    leading: SquareNetworkImage(artist.imageUrl, 60),
                    title: Text(artist.name),
                  )),
              NodeDetailsLinkSection(songNodeInfo.id),
            ],
          ),
        ),
      ),
    );
  }
}
