import 'package:flutter_test/flutter_test.dart';

import 'package:zwo_achtundvierzig/game.dart';

main() {
  test("After Reset, the score should be zero.", () {
    GameState gs = GameState();
    gs.resetGame();
    expect(gs.score, 0);
  });
}
