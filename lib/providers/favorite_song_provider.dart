import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

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
}
