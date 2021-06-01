import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import './screens/ArtistDetailsScreen.dart';
import './screens/SongDetailsScreen.dart';
import './screens/HomeScreen.dart';
import './screens/AddScreen.dart';
import './screens/CreateLinkScreen.dart';
import './screens/LinkDetailsScreen.dart';
import './providers/MusicMapProvider.dart';
import './providers/SelectNodesProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicMapProvider()),
        ChangeNotifierProvider(create: (_) => SelectNodesProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'MusicMap',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFFFFFFF),
        primaryColorDark: Color(0xFFF4F4F4),
        accentColor: Color(0xFFA0CE81),
        backgroundColor: Color(0xFFFFFFFF),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
          bodyText1:
              TextStyle(color: Colors.black45, fontWeight: FontWeight.normal),
        ),
        hintColor: Colors.black38,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Color(0xFFA0CE81)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF282C34),
        primaryColorDark: Color(0xFF21252B),
        accentColor: Color(0xFFA0CE81),
        backgroundColor: Color(0xFF282C34),
        scaffoldBackgroundColor: Color(0xFF282C34),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
          bodyText1:
              TextStyle(color: Colors.white60, fontWeight: FontWeight.normal),
        ),
        hintColor: Colors.white38,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: Color(0xFFA0CE81)),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/add': (_) => AddScreen(),
        '/song_details': (_) => SongDetailsScreen(),
        '/artist_details': (_) => ArtistDetailsScreen(),
        '/link_details': (_) => LinkDetailsScreen(),
        '/create_link': (_) => CreateLinkScreen(),
      },
    );
  }
}
