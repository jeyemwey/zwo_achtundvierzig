import 'package:flutter_test/flutter_test.dart';

import 'package:zwo_achtundvierzig/game.dart';

main() {
  test("After Reset, the score should be zero.", () {
    GameState gs = GameState();
    gs.resetGame();
    expect(gs.score, 0);
  });

  test("The values behind the swipe directions should be unique", () {
    expect(GameState.SWIPE_NORTH != GameState.SWIPE_EAST, true);
    expect(GameState.SWIPE_NORTH != GameState.SWIPE_SOUTH, true);
    expect(GameState.SWIPE_NORTH != GameState.SWIPE_WEST, true);
    expect(GameState.SWIPE_EAST != GameState.SWIPE_NORTH, true);
    expect(GameState.SWIPE_EAST != GameState.SWIPE_SOUTH, true);
    expect(GameState.SWIPE_EAST != GameState.SWIPE_WEST, true);
    expect(GameState.SWIPE_SOUTH != GameState.SWIPE_NORTH, true);
    expect(GameState.SWIPE_SOUTH != GameState.SWIPE_EAST, true);
    expect(GameState.SWIPE_SOUTH != GameState.SWIPE_WEST, true);
    expect(GameState.SWIPE_WEST != GameState.SWIPE_NORTH, true);
    expect(GameState.SWIPE_WEST != GameState.SWIPE_EAST, true);
    expect(GameState.SWIPE_WEST != GameState.SWIPE_SOUTH, true);
  });

  test("Simple Game Move operation", () {
    GameState gs = GameState();
    gs.gameboard = [
      [1, 0, 0, 0],
      [1, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
    ];

    gs.move(GameState.SWIPE_SOUTH);

    expect(
      gs.gameboard,
      [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [2, 0, 0, 0],
      ],
    );
  });

  test("throws an Exception when a move in a unspecified direction is called",
      () {
    GameState gs = GameState();

    expect(() {
      gs.move(-1);
    }, throwsArgumentError);
  });

  test("rotates a gameboard as planned", () {
    GameState gs = GameState();
    gs.gameboard = [
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 10, 11, 12],
      [13, 14, 15, 16],
    ];

    // Here comes the thing!
    gs.rotate();

    expect(gs.gameboard, [
      [4, 8, 12, 16],
      [3, 7, 11, 15],
      [2, 6, 10, 14],
      [1, 5, 9, 13]
    ]);
  });

  test("doesn't change the board if all cards are already on the swipe side",
      () {
    GameState gs = GameState();
    gs.gameboard = [
      [1, 0, 0, 0],
      [1, 2, 0, 0],
      [1, 2, 0, 0],
      [1, 0, 0, 0],
    ];

    gs.move(GameState.SWIPE_WEST);

    expect(
      gs.gameboard,
      [
        [1, 0, 0, 0],
        [1, 2, 0, 0],
        [1, 2, 0, 0],
        [1, 0, 0, 0],
      ],
    );
  });
}
