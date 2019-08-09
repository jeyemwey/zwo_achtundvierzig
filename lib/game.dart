import 'package:flutter/material.dart';
import 'package:zwo_achtundvierzig/mechanics.dart';

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
    resetGame();
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    var children = <Widget>[
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
    ];

    if (isPortrait) {
      return Column(
        children: children,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      );
    } else {
      return Row(
        children: children,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );
    }
  }

  Widget generateGameBoard(List<List<int>> g) {
    return GestureDetector(
      child: Column(
        children: g
            .map(
              (c) => Row(
                children: c.map((r) => Tile(r)).toList(),
              ),
            )
            .toList(),
      ),
      onPanEnd: (details) {
        var delta = details.velocity.pixelsPerSecond;

        // Filter out invalid pans because they would result in SWIPE_NORTH.
        if (delta.dx == 0 && delta.dx == delta.dy) {
          print("no move detected");
        }

        // Initially, I wanted to catch swipes that were too small. However,
        // I don't find it useful right now. If we find reasons why the swipe
        // might be too small, we can uncomment that conditional again.

        // if (delta.distance < 60) {
        //   print("distance too small.");
        //   return;
        // }

        // Swiping near corners should be prevented - this helps catching
        // unintentional swipes or the wrong ones.
        if ((delta.dx - delta.dy).abs() < 50) {
          print("direction unclear.");
          return;
        }

        if (delta.dx.abs() > delta.dy.abs()) {
          // More Delta in X than Y direction <<<--->>>
          if (delta.dx > 0) {
            // 0|0 is in the top-left corner, dx>0 => going right
            gameboard = Mechanics.move(gameboard, Mechanics.SWIPE_EAST);
          } else {
            // Going left
            gameboard = Mechanics.move(gameboard, Mechanics.SWIPE_WEST);
          }
        } else {
          // More in Y direction
          if (delta.dy > 0) {
            // dy>0 => going down
            gameboard = Mechanics.move(gameboard, Mechanics.SWIPE_SOUTH);
          } else {
            gameboard = Mechanics.move(gameboard, Mechanics.SWIPE_NORTH);
          }
        }
      },
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
