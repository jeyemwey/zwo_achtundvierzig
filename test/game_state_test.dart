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
}
