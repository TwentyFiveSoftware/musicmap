import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/NodeInfo.dart';
import '../widgets/NodeDetailsLinkSection.dart';
import '../providers/MusicMapProvider.dart';
import '../providers/SelectNodesProvider.dart';
import '../models/ConfirmDialogInfo.dart';
import '../widgets/ConfirmDialog.dart';
import '../widgets/SquareNetworkImage.dart';
import '../database/nodes.dart';

class ArtistDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ArtistNodeInfo artistNodeInfo =
        ModalRoute.of(context).settings.arguments as ArtistNodeInfo;

    final MusicMapProvider provider =
        Provider.of<MusicMapProvider>(context, listen: false);
    final List<SongNodeInfo> songs =
        provider.getSongsOfArtist(artistNodeInfo.artist);

    return Scaffold(
      appBar: AppBar(
        title: Text('Artist'),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => ConfirmDialog(ConfirmDialogInfo(
                title: 'Are you sure?',
                content: 'Do you really want to delete this artist?',
                cancelButton: 'Cancel',
                confirmButton: 'Delete',
                successCallback: () async {
                  await deleteNode(artistNodeInfo);
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
              provider.setTransitionToNode(artistNodeInfo);
            },
          ),
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () {
              Provider.of<SelectNodesProvider>(context, listen: false)
                  .startSelecting(artistNodeInfo);
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
                  SquareNetworkImage(artistNodeInfo.imageUrl, 80),
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
              if (songs.length > 0) Divider(height: 40),
              if (songs.length > 0)
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
                    leading: SquareNetworkImage(song.imageUrl, 60),
                    title: Text(song.title),
                    subtitle: Text(song.subtitle),
                  )),
              NodeDetailsLinkSection(artistNodeInfo.id),
            ],
          ),
        ),
      ),
    );
  }
}
