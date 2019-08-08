import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:zwo_achtundvierzig/game.dart';

main() {
  test("After Reset, the score should be zero.", () {
    GameState gs = GameState();
    gs.resetGame();
    expect(gs.score, 0);
  });

  test("There should be a valid number for every card until lvl. 18", () {
    for (var i = 0; i <= 18; i++) {
      expect(GameState.colorFromNumber(i) != Colors.white, true);
    }
  });

  // TODO: Test the other functions that come from `lib/game.dart`.
}
