import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FavoriteProvider with ChangeNotifier {
  List<dynamic> _favsList = [
    {
      "artist": "Imagine Dragons",
      "title": "Warriors",
      "album": "Warriors",
      "release_date": "2014-09-18",
      "song_link": "https://lis.tn/Warriors",
      "apple_music":
          "https://music.apple.com/us/album/warriors/1440831203?i=1440831624",
      "spotify": "https://open.spotify.com/track/1lgN0A2Vki2FTON5PYq42m",
      "artwork":
          "https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e"
    },
    {
      "artist": "Imagine Dragons",
      "title": "Warriors",
      "album": "Warriors",
      "release_date": "2014-09-18",
      "label": "Universal Music",
      "timecode": "02:32",
      "song_link": "https://lis.tn/Warriors",
      "apple_music":
          "https://music.apple.com/us/album/warriors/1440831203?i=1440831624",
      "spotify": "https://open.spotify.com/track/1lgN0A2Vki2FTON5PYq42m",
      "artwork":
          "https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e"
    },
    {
      "artist": "Imagine Dragons",
      "title": "Warriors",
      "album": "Warriors",
      "release_date": "2014-09-18",
      "label": "Universal Music",
      "timecode": "02:32",
      "song_link": "https://lis.tn/Warriors",
      "apple_music":
          "https://music.apple.com/us/album/warriors/1440831203?i=1440831624",
      "spotify": "https://open.spotify.com/track/1lgN0A2Vki2FTON5PYq42m",
      "artwork":
          "https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e"
    },
  ];
  List<dynamic> get getFavsList => _favsList;

  void addNewSong(dynamic songObj) {
    _favsList.add(songObj);
    notifyListeners();
  }

  void deleteSong(dynamic songObj) {
    _favsList.remove(songObj);

    notifyListeners();
  }

  Future<void> searchSong(String songPath) async {
    print("In favorite song provider: $songPath");
    File songFile = File(songPath);
    String songString = _fileConvert(songFile);
    dynamic songObject = await _sendToAPI(songString);
    print(songObject);
    dynamic songFormat = {
      "artist": songObject.artist,
      "title": songObject.title,
      "album": songObject.album,
      "release_date": songObject.album,
      "song_link": songObject.song_link,
      "apple_music": songObject.apple_music.url,
      "spotify": songObject.spotify.external_urls.spotify,
      "artwork": songObject.spotify.images.url
    };
    notifyListeners();
  }

  String _fileConvert(File file) {
    Uint8List fileBytes = file.readAsBytesSync();

    String base64String = base64Encode(fileBytes);

    return base64String;
  }

  Future<dynamic> _sendToAPI(String file) async {
    print("Sending file: $file");
    var url = Uri.parse('https://api.audd.io/');
    var response = await http.post(url, body: {
      'api_token': dotenv.env['API_KEY'],
      'return': 'apple_music,spotify,deezer',
      'audio': file,
      'method': 'recognize',
    }
        //Uri.parse('https://api.audd.io/'),
        //headers: {'Content-Type': 'multipart/form-data'},
        // body: jsonEncode(
        //<String, dynamic>{
        // 'api_token': '5288e8cdda3b260a53338276baeb8d05',
        //'return': 'apple_music,spotify',
        //  'audio': file,
        //   'method': 'recognize',
        //},
        //),
        );
    if (response.statusCode == 200) {
      //print("Success");
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("Valio verga");
      throw Exception('Failed to load json');
    }
  }
}
