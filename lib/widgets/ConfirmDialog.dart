import 'package:flutter/material.dart';
import '../models/ConfirmDialogInfo.dart';

class ConfirmDialog extends StatelessWidget {
  final ConfirmDialogInfo info;

  ConfirmDialog(this.info);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(info.title),
      content: Text(info.content),
      actions: <Widget>[
        TextButton(
          child: Text(info.cancelButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(info.confirmButton),
          onPressed: () {
            Navigator.of(context).pop();
            info.successCallback();
          },
        ),
      ],
    );
  }
}
