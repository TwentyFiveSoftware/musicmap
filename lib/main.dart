import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import './screens/ArtistDetailsScreen.dart';
import './screens/SongDetailsScreen.dart';
import './screens/HomeScreen.dart';
import './screens/AddScreen.dart';
import './screens/SearchScreen.dart';
import './screens/SettingsScreen.dart';
import './screens/CreateLinkScreen.dart';
import './screens/LinkDetailsScreen.dart';
import './providers/MusicMapProvider.dart';
import './providers/SelectNodesProvider.dart';
import './providers/SettingsProvider.dart';
import './config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicMapProvider()),
        ChangeNotifierProvider(create: (_) => SelectNodesProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final SettingsProvider settings =
        Provider.of<SettingsProvider>(context, listen: true);

    return MaterialApp(
      title: 'MusicMap',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: settings.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/add': (_) => AddScreen(),
        '/search': (_) => SearchScreen(),
        '/settings': (_) => SettingsScreen(),
        '/song_details': (_) => SongDetailsScreen(),
        '/artist_details': (_) => ArtistDetailsScreen(),
        '/link_details': (_) => LinkDetailsScreen(),
        '/create_link': (_) => CreateLinkScreen(),
      },
    );
  }
}
