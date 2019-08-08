import 'dart:math';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameState();
  }
}

class GameState extends State<Game> {
  List<List<int>> gameboard =
      List<List<int>>.generate(4, (i) => List<int>.generate(4, (j) => 0));
  int score = 0;
  bool resetConfirm = false;

  void resetGame() {
    int r = 0;
    gameboard =
        List<List<int>>.generate(4, (i) => List<int>.generate(4, (j) => r++));
    score = 0;
    resetConfirm = false;
  }

  @override
  void initState() {
    super.initState();
    // resetGame();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        generateGameBoard(gameboard),
        Center(
            child: Column(
          children: <Widget>[
            Text("Score: " + score.toString(),
                style: Theme.of(context).primaryTextTheme.display1),
            resetButtons(),
          ],
        ))
      ],
    );
  }

  Widget resetButtons() {
    var btns = [
      RaisedButton(
        child: Text("Restart"),
        onPressed: () {
          setState(() {
            resetConfirm = true;
          });
        },
      ),
    ];

    if (resetConfirm) {
      btns.add(
        RaisedButton(
          child: Text("Confirm"),
          onPressed: () {
            setState(() {
              print("Restart Confirmed!");
              resetGame();
            });
          },
        ),
      );
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, children: btns);
  }

  Widget generateGameBoard(List<List<int>> g) {
    return Column(
        children: g
            .map((c) => Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: c.map((r) => generateContainer(r)).toList(),
                ))
            .toList());
  }

  Widget generateContainer(int r) {
    String t = pow(2, r).toString();

    return Container(
      height: MediaQuery.of(context).size.width * 0.25,
      width: MediaQuery.of(context).size.width * 0.25,
      color: colorFromNumber(r),
      child: Center(
        child: Text(
          r == 0 ? "" : t,
          style: TextStyle(
            fontSize: fontSizeByTextLength(t),
          ),
        ),
      ),
    );
  }

  static Color colorFromNumber(int r) {
    switch (r) {
      case 0:
        return Colors.yellow[100];
      case 1:
        return Colors.yellow[200];
      case 2:
        return Colors.yellow[300];
      case 3:
        return Colors.yellow[400];
      case 4:
        return Colors.yellow[500];
      case 5:
        return Colors.yellow[600];
      case 6:
        return Colors.yellow[700];
      case 7:
        return Colors.yellow[800];
      case 8:
        return Colors.yellow[900];
      case 9:
        return Colors.amber[600];
      case 10:
        return Colors.amber[700];
      case 11:
        return Colors.amber[800];
      case 12:
        return Colors.amber[900];
      case 13:
        return Colors.purple[200];
      case 14:
        return Colors.purple[300];
      case 15:
        return Colors.purple[400];
      case 16:
        return Colors.purple[500];
      case 17:
        return Colors.purple[600];
      case 18:
        return Colors.purple[700];
      default:
        return Colors.white;
    }
  }

  static double fontSizeByTextLength(String t) {
    return kBottomNavigationBarHeight * (10 - t.length) / 10;
  }
}
