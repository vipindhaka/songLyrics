import 'package:flutter/material.dart';
import 'package:internship/onDeviceStorage/dbHelper.dart';
import 'package:internship/providers/songFetch.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatefulWidget {
  final trackId;

  SongScreen(this.trackId);

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  bool _isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    _isloading = true;
    Provider.of<SongsFetch>(context, listen: false)
        .fetchLyrics(widget.trackId)
        .then((value) {
      _isloading = false;
    });

    //isloading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final trackId = ModalRoute.of(context).settings.arguments.toString();
    final lyrics = Provider.of<SongsFetch>(context).lyrics;

    //Provider.of<SongsFetch>(context).fetchLyrics(widget.trackId);
    Provider.of<SongsFetch>(context, listen: false)
        .fetchDetails(widget.trackId);
    final track = Provider.of<SongsFetch>(context, listen: false).track;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                DBHelper.insert('songs', {
                  'id': track.trackId.toString(),
                  'trackName': track.trackName
                });
              })
        ],
        //centerTitle: true,
        title: Text('TrackDetails'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(track.trackName),
              Text(
                'Artist',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(track.artistName),
              Text(
                'Album Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(track.albumName),
              Text(
                'Explicit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(track.explicit.toString()),
              Text(
                'Rating',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(track.rating.toString()),
              Text(
                'Lyrics',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _isloading ? CircularProgressIndicator() : Text(lyrics.lyrics),
            ],
          ),
        ),
      ),
    );
  }
}
