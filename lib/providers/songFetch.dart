import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:internship/models/lyrics.dart';
import 'package:internship/models/track.dart';
import 'package:internship/models/trackList.dart';
import 'package:internship/onDeviceStorage/dbHelper.dart';

class SongsFetch with ChangeNotifier {
  TrackList trackList;
  List<Map<String, dynamic>> bookMarkList;
  Track track;
  Lyrics lyrics;
  Future<void> fetchSongs() async {
    final Uri url = Uri.https('api.musixmatch.com', '/ws/1.1/chart.tracks.get',
        {'apikey': '98c84286abf7292faec2619050c6f750'});
    //'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=98c84286abf7292faec2619050c6f750';
    final response = await https.get(url);
    //print(json.decode(response.body));
    final extractedData = json.decode(response.body);
    trackList =
        TrackList.fromJson(extractedData['message']['body']['track_list']);
    //TrackList(extractedData);
    //print(_trackList.tracks.first.artistName);
    notifyListeners();
  }

  void fetchDetails(String trackId) {
    // final url = Uri.https('api.musixmatch.com', '/ws/1.1/track.get',
    //     {'track_id': trackId, 'apikey': '2d782bc7a52a41ba2fc1ef05b9cf40d7'});
    // final response = await https.get(url);
    // final extractedData = json.decode(response.body);
    // track=Track.fromJson(extractedData)
    //print(extractedData);
    track = trackList.tracks.firstWhere((track) {
      return track.trackId == int.parse(trackId);
    });
  }

  Future<void> fetchLyrics(String trackId) async {
    //ttps://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=TRACK_ID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7
    final url = Uri.https('api.musixmatch.com', '/ws/1.1/track.lyrics.get',
        {'track_id': trackId, 'apikey': '98c84286abf7292faec2619050c6f750'});
    final response = await https.get(url);
    final extractedData = json.decode(response.body);
    lyrics = Lyrics.fromJson(extractedData['message']['body']['lyrics']);
    notifyListeners();
    //print(lyrics.lyrics);
  }

  Future<void> insertData(String table, Map<String, dynamic> data) async {
    await DBHelper.insert(table, data);
    notifyListeners();
  }

  Future<void> getData(String table) async {
    final dataList = await DBHelper.getData(table);
    //final length = dataList.length;
    bookMarkList = dataList;
    notifyListeners();
  }
}
