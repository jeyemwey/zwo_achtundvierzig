import 'package:flutter_test/flutter_test.dart';
import 'package:zwo_achtundvierzig/game.dart';
import 'package:zwo_achtundvierzig/historyitem.dart';

main() {
  test("returns empty json blob if null-values are provided", () {
    expect(
      HistoryItem.save([], 0),
      '{"playedRounds":0,"score":0,"history":[]}',
    );
  });

  test("returns history after some game moves", () {
    List<HistoryItem> history = [
      HistoryItem(
        gameboard: [
          [1, 1, 1, 1],
          [1, 1, 1, 1],
          [1, 1, 1, 1],
          [1, 1, 1, 1],
        ],
        swipeDirection: GameState.SWIPE_NORTH,
      ),
      HistoryItem(
        gameboard: [
          [2, 2, 2, 2],
          [2, 2, 2, 2],
          [2, 2, 2, 2],
          [2, 2, 2, 2],
        ],
        swipeDirection: GameState.SWIPE_NORTH,
      ),
    ];

    expect(
      HistoryItem.save(history, 42),
      '{"playedRounds":2,"score":42,"history":[{"direction":0,"field":[[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]]},{"direction":0,"field":[[2,2,2,2],[2,2,2,2],[2,2,2,2],[2,2,2,2]]}]}',
    );
  });
}
