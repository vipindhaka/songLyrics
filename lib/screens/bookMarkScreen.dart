import 'package:flutter/material.dart';
import 'package:internship/onDeviceStorage/dbHelper.dart';
import 'package:internship/providers/songFetch.dart';
import 'package:internship/screens/songScreen.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    Provider.of<SongsFetch>(context, listen: false)
        .getData('songs')
        .then((value) {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final length=await DBHelper.getLength('songs');
    final dataList = Provider.of<SongsFetch>(context).bookMarkList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Songs'),
      ),
      body: _isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(dataList[index]['id']),
                  trailing: Text(dataList[index]['trackName']),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return SongScreen(dataList[index]['id']);
                    }));
                  },
                );
              },
            ),
    );
  }
}
