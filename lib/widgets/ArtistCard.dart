import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';

class ArtistCard extends StatelessWidget {
  final ArtistNodeInfo artistNodeInfo;
  final bool selected;

  ArtistCard(this.artistNodeInfo, this.selected);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          border: this.selected ? Border.all(color: Theme.of(context).accentColor) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              artistNodeInfo.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                artistNodeInfo.title,
                style: TextStyle(fontSize: 17),
                // textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
