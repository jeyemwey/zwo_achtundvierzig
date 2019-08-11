import 'dart:convert';

class HistoryItem {
  List<List<int>> gameboard;
  int swipeDirection;
  int score;

  HistoryItem({this.gameboard, this.swipeDirection});

  /// This method creates a JSON blob and send it to a server. You can put the
  /// json blob into https://iamjannik.me/ml-2048-visual/ and the display works
  /// out. **Watch out**: dart:print will only print the first 1024 character
  /// of the json blob which might result in an incomplete blob. Adjust it
  /// accordingly, maybe delete the last incomplete history item and close the
  /// json objects.
  static void save(List<HistoryItem> history, int score) {
    Map<String, dynamic> j = {
      'playedRounds': history.length,
      'score': score,
      'history': history.map((f) => f.toJson()).toList(),
    };

    print(jsonEncode(j));
  }

  Map<String, dynamic> toJson() {
    return {
      'direction': swipeDirection,
      'field': gameboard,
    };
  }
}
