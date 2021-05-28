import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getSpotifyToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  if ((sharedPreferences.getInt('SPOTIFY_ACCESS_TOKEN_EXPIRING') ?? 0) >
          DateTime.now().millisecondsSinceEpoch &&
      sharedPreferences.getString('SPOTIFY_ACCESS_TOKEN') != null)
    return sharedPreferences.getString('SPOTIFY_ACCESS_TOKEN');

  http.Response response = await http
      .post(Uri.parse('https://accounts.spotify.com/api/token'), body: {
    'grant_type': 'client_credentials',
    'token_type': 'bearer'
  }, headers: {
    'authorization':
        'Basic ${base64Encode(utf8.encode(FlutterConfig.get('SPOTIFY_CLIENT_ID') + ':' + FlutterConfig.get('SPOTIFY_CLIENT_SECRET')))}'
  });

  String accessToken = jsonDecode(response.body)['access_token'];

  sharedPreferences.setString('SPOTIFY_ACCESS_TOKEN', accessToken);
  sharedPreferences.setInt('SPOTIFY_ACCESS_TOKEN_EXPIRING',
      DateTime.now().millisecondsSinceEpoch + 3600000);

  return accessToken;
}
