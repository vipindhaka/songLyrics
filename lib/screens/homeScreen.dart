import 'package:flutter/material.dart';
import 'package:internship/providers/songFetch.dart';
import 'package:internship/screens/bookMarkScreen.dart';
import 'package:internship/screens/songScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  @override
  void initState() {
    _isLoading = true;

    Provider.of<SongsFetch>(context, listen: false).fetchSongs().then((value) {
      _isLoading = false;
    });
    super.initState();
  }

  //@override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     _isLoading = true;
  //     Provider.of<SongsFetch>(context).fetchSongs().then((value) {
  //       _isLoading = false;
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<SongsFetch>(context).trackList;
    // final songs
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return BookmarkScreen();
                }));
              })
        ],
        title: Text('Songs'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: songData.tracks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(songData.tracks[index].trackName),
                  subtitle: Text(songData.tracks[index].artistName),
                  trailing: Text(songData.tracks[index].albumName),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => SongScreen(
                            songData.tracks[index].trackId.toString()),
                        // settings: RouteSettings(
                        //     arguments: songData.tracks[index].trackId),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
