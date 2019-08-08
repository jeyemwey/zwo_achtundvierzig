import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'zwo_achtundvierzig';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Force Portrait Mode
    // TODO: Modify the game board to support Landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),

        // A SingleChildScrollView implements scrolling which is not exactly
        // what I wanted. However, the test suite complained beforehand and now
        // it doesn't so thats a quick fix for that.
        body: SingleChildScrollView(
          child: Game(),
        ),
      ),
    );
  }
}
