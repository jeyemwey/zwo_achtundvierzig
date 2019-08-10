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

  test("performs move operations without adding new tiles", () {
    // Every MoveOperationTestcase is its own GameState which is reset after
    // each move. The Score in the Testcase is just the one that results from
    // moving from the start gameboard to the expected end.

    List<MoveOperationTestcase> cases = [
      MoveOperationTestcase(
        start: [
          [1, 0, 0, 0],
          [1, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ],
        direction: GameState.SWIPE_SOUTH,
        expected: [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [2, 0, 0, 0],
        ],
        newScore: 4,
      ),
      MoveOperationTestcase(
        start: [
          [0, 0, 0, 2],
          [0, 0, 0, 0],
          [0, 0, 0, 2],
          [0, 0, 0, 0],
        ],
        direction: GameState.SWIPE_SOUTH,
        expected: [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 3],
        ],
        newScore: 8,
      ),
      MoveOperationTestcase(
        start: [
          [0, 0, 0, 2],
          [0, 0, 0, 0],
          [0, 0, 0, 5],
          [0, 0, 0, 0],
        ],
        direction: GameState.SWIPE_SOUTH,
        expected: [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 2],
          [0, 0, 0, 5],
        ],
        newScore: 0,
      ),
      MoveOperationTestcase(
        start: [
          [2, 2, 2, 2],
          [0, 0, 0, 0],
          [2, 2, 2, 2],
          [0, 0, 0, 0],
        ],
        direction: GameState.SWIPE_EAST,
        expected: [
          [0, 0, 3, 3],
          [0, 0, 0, 0],
          [0, 0, 3, 3],
          [0, 0, 0, 0],
        ],
        newScore: 32,
      )
    ];

    int i = 1;
    for (var c in cases) {
      GameState gs = GameState();

      gs.gameboard = c.start;
      gs.move(c.direction);

      expect(gs.gameboard, c.expected);
      expect(gs.score, c.newScore);

      printOnFailure("Ran Test successfully: #" + (i++).toString());
    }
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

  test("adds a new tile to a board when there is space", () {
    GameState gs = GameState();
    gs.gameboard = [
      [1, 0, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1]
    ];
    bool over = gs.addNewTile();
    expect(gs.gameboard[0][1], anyOf(1, 2));
    expect(over, false);
  });

  test("flips the game to over if there is no space to add a new tile", () {
    GameState gs = GameState();
    gs.gameboard = [
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1]
    ];
    bool over = gs.addNewTile();
    expect(over, true);
  });
}

class MoveOperationTestcase {
  List<List<int>> start;
  int direction;
  List<List<int>> expected;
  int newScore;

  MoveOperationTestcase({
    this.start,
    this.direction,
    this.expected,
    this.newScore,
  });
}
