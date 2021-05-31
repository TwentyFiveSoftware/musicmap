import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';

class SongCard extends StatelessWidget {
  final SongNodeInfo songNodeInfo;
  final bool selected;

  SongCard(this.songNodeInfo, this.selected);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: songNodeInfo.key,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          border: this.selected ? Border.all(color: Theme.of(context).accentColor) : null,
        ),
        child: Row(
          children: [
            Image.network(
              songNodeInfo.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songNodeInfo.title,
                    style: TextStyle(fontSize: 17.5),
                  ),
                  SizedBox(height: 2),
                  Text(
                    songNodeInfo.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
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
