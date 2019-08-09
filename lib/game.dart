import 'dart:math';

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
    score = 0;
    resetConfirm = false;

    // Get a random number between 0 and 15 (inclusively, nextInt is
    // exclusively). Then, create a new 2D array of ints and fill every piece
    // with zero except for the random position.
    int i = 0;
    int randomPosition = Random().nextInt(16);
    gameboard = List<List<int>>.generate(
      4,
      (j) => List<int>.generate(
        4,
        (k) => i++ == randomPosition ? 1 : 0,
      ),
    );
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

        setState(() {
          if (delta.dx.abs() > delta.dy.abs()) {
            // More Delta in X than Y direction <<<--->>>
            if (delta.dx > 0) {
              // 0|0 is in the top-left corner, dx>0 => going right
              move(GameState.SWIPE_EAST);
            } else {
              // Going left
              move(GameState.SWIPE_WEST);
            }
          } else {
            // More in Y direction
            if (delta.dy > 0) {
              // dy>0 => going down
              move(GameState.SWIPE_SOUTH);
            } else {
              move(GameState.SWIPE_NORTH);
            }
          }
        });
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

  // Swipe directions
  static const SWIPE_NORTH = 0;
  static const SWIPE_EAST = 1;
  static const SWIPE_SOUTH = 2;
  static const SWIPE_WEST = 3;

  // This is the move function!
  void move(int direction) {
    switch (direction) {
      case SWIPE_NORTH:
        print("Swipe north!");

        rotate();
        mergeToFirstColumn();
        rotate();
        rotate();
        rotate();
        break;

      case SWIPE_EAST:
        print("Swipe east!");

        rotate();
        rotate();
        mergeToFirstColumn();
        rotate();
        rotate();
        break;

      case SWIPE_SOUTH:
        print("Swipe south!");

        rotate();
        rotate();
        rotate();
        mergeToFirstColumn();
        rotate();
        break;

      case SWIPE_WEST:
        print("Swipe west!");

        mergeToFirstColumn();
        break;

      default:
        throw new ArgumentError.value(direction, "move");
    }
    // });
  }

  void rotate() {
    gameboard = [
      [gameboard[0][3], gameboard[1][3], gameboard[2][3], gameboard[3][3]],
      [gameboard[0][2], gameboard[1][2], gameboard[2][2], gameboard[3][2]],
      [gameboard[0][1], gameboard[1][1], gameboard[2][1], gameboard[3][1]],
      [gameboard[0][0], gameboard[1][0], gameboard[2][0], gameboard[3][0]],
    ];
  }

  // This massive dumpster fire comes from my first implementation which was in
  // Python. Except that I do not do everything four times now and I'm trying
  // to wrap unit tests around it. Thus, IF something was to break I can still
  // see what is expected behaviour and what isn't.
  // You can find the old, smokey trash bin at
  // https://github.com/jeyemwey/ml-2048/blob/master/engine.py#L106
  void mergeToFirstColumn() {
    var j = 0;
    for (var i = 0; i < 4; i++) {
      if (gameboard[i][j] != 0 ||
          gameboard[i][j + 1] != 0 ||
          gameboard[i][j + 2] != 0 ||
          gameboard[i][j + 3] != 0) {
        if (gameboard[i][j] == 0) {
          while (gameboard[i][j] == 0) {
            gameboard[i][j] = gameboard[i][j + 1];
            gameboard[i][j + 1] = gameboard[i][j + 2];
            gameboard[i][j + 2] = gameboard[i][j + 3];
            gameboard[i][j + 3] = 0;
          }
        }
        if (gameboard[i][j + 1] == 0 &&
            (gameboard[i][j + 2] != 0 || gameboard[i][j + 3] != 0)) {
          while (gameboard[i][j + 1] == 0) {
            gameboard[i][j + 1] = gameboard[i][j + 2];
            gameboard[i][j + 2] = gameboard[i][j + 3];
            gameboard[i][j + 3] = 0;
          }
        }
        if (gameboard[i][j + 2] == 0 && gameboard[i][j + 3] != 0) {
          while (gameboard[i][j + 2] == 0) {
            gameboard[i][j + 2] = gameboard[i][j + 3];
            gameboard[i][j + 3] = 0;
          }
        }
      }
    }
    j = 0;
    for (var i = 0; i < 4; i++) {
      if (gameboard[i][j] == gameboard[i][j + 1]) {
        score = score + 2 * gameboard[i][j];
        gameboard[i][j] = gameboard[i][j] + gameboard[i][j + 1];
        gameboard[i][j + 1] = gameboard[i][j + 2];
        gameboard[i][j + 2] = gameboard[i][j + 3];
        gameboard[i][j + 3] = 0;
      }
      if (gameboard[i][j + 1] == gameboard[i][j + 2]) {
        score = score + 2 * gameboard[i][j + 1];
        gameboard[i][j + 1] = gameboard[i][j + 1] + gameboard[i][j + 2];
        gameboard[i][j + 2] = gameboard[i][j + 3];
        gameboard[i][j + 3] = 0;
      }
      if (gameboard[i][j + 2] == gameboard[i][j + 3]) {
        score = score + 2 * gameboard[i][j + 2];
        gameboard[i][j + 2] = gameboard[i][j + 2] + gameboard[i][j + 3];
        gameboard[i][j + 3] = 0;
      }
    }
  }
}
