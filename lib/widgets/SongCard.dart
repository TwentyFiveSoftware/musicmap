import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';

class SongCard extends StatelessWidget {
  final SongNodeInfo songNodeInfo;

  SongCard(this.songNodeInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: songNodeInfo.key,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Theme.of(context).primaryColorDark,
        child: Row(
          children: [
            Image.network(
              songNodeInfo.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songNodeInfo.title,
                    style: TextStyle(fontSize: 17.5),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    songNodeInfo.subtitle,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
