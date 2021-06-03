import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/SettingsProvider.dart';

class SelectThemeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsProvider settings =
        Provider.of<SettingsProvider>(context, listen: true);

    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.wb_sunny),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColorLight,
      ),
      title: Text('Theme'),
      subtitle: Text(['System', 'Light', 'Dark'][settings.themeMode.index]),
      onTap: () => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Select theme'),
          content: SizedBox(
            height: 170,
            child: Column(
              children: ThemeMode.values
                  .map((mode) => ListTile(
                        leading: Icon(
                          settings.themeMode == mode
                              ? Icons.radio_button_on
                              : Icons.radio_button_off,
                          color: Theme.of(context).accentColor,
                        ),
                        title: Text(['System', 'Light', 'Dark'][mode.index]),
                        onTap: () async {
                          await settings.changeThemeMode(mode);
                          Navigator.of(context).pop();
                        },
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
