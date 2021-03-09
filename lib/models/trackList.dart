import 'package:internship/models/track.dart';

class TrackList {
  List<Track> tracks = [];
  TrackList(this.tracks);
  TrackList.fromJson(List<dynamic> trackList) {
    //tracks = trackList['message']['body']['track_list'];
    for (int v = 0; v < trackList.length; v++) {
      tracks.add(Track.fromJson(trackList[v]['track']));
    }
  }
}
