import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/getDatabase.dart';
import '../providers/MusicMapProvider.dart';
import '../models/ConfirmDialogInfo.dart';
import '../widgets/ConfirmDialog.dart';
import '../widgets/SelectThemeTile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SelectThemeTile(),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.delete),
                backgroundColor: Colors.transparent,
                foregroundColor: Theme.of(context).primaryColorLight,
              ),
              title: Text('Delete all data'),
              subtitle: Text('This will delete all songs, artists and links'),
              onTap: () => showDialog(
                context: context,
                builder: (_) => ConfirmDialog(
                  ConfirmDialogInfo(
                    title: 'Are you sure?',
                    content: 'Do you really want to delete all data?',
                    cancelButton: 'Cancel',
                    confirmButton: 'Delete',
                    successCallback: () async {
                      await dropDatabase();
                      await getDatabase();
                      await Provider.of<MusicMapProvider>(context,
                              listen: false)
                          .update();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
