import 'package:flutter/material.dart';
import '../models/NodeInfo.dart';

class ArtistCard extends StatelessWidget {
  final ArtistNodeInfo artistNodeInfo;

  ArtistCard(this.artistNodeInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: artistNodeInfo.key,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: Theme.of(context).primaryColorDark,
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
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                artistNodeInfo.title,
                style: TextStyle(fontSize: 17.0),
                // textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
