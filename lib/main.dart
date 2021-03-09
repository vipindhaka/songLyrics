import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:internship/providers/songFetch.dart';
import 'package:internship/screens/homeScreen.dart';
//import 'package:internship/screens/songScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription connectivitySubscription;

  ConnectivityResult _previousResult;

  @override
  void initState() {
    super.initState();

    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        nav.currentState.pushReplacement(MaterialPageRoute(
            builder: (BuildContext _) => Scaffold(
                  appBar: AppBar(
                    title: Text('songs'),
                  ),
                  body: Center(
                    child: Text('No internet Connection'),
                  ),
                )));
      } else if (_previousResult == ConnectivityResult.none) {
        nav.currentState.pushReplacement(
            MaterialPageRoute(builder: (BuildContext _) => HomeScreen()));
      }

      _previousResult = connectivityResult;
    });
  }

  @override
  void dispose() {
    super.dispose();

    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => SongsFetch(),
      child: MaterialApp(
          navigatorKey: nav,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
          initialRoute: '/',
          routes: {
            // SongScreen.routeName: (ctx) => SongScreen(),
          }),
    );
  }
}
