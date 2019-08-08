import 'package:flutter/material.dart';

import 'package:zwo_achtundvierzig/tile.dart';

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameState();
  }
}

class GameState extends State<Game> {
  List<List<int>> gameboard;
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
    //  MediaQuery.of(context).orientation == Orientation.portrait
    return Column(
      children: <Widget>[
        generateGameBoard(gameboard),
        Center(
          child: Column(
            children: <Widget>[
              Text(
                "Score: " + score.toString(),
                style: Theme.of(context).primaryTextTheme.display1,
              ),
              resetButtons(),
            ],
          ),
        )
      ],
    );
  }

  Widget generateGameBoard(List<List<int>> g) {
    return Column(
      children: g
          .map(
            (c) => Row(
              children: c.map((r) => Tile(r)).toList(),
            ),
          )
          .toList(),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: btns,
    );
  }
}
