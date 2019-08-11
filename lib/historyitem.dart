class HistoryItem {
  List<List<int>> gameboard;
  int swipeDirection;

  HistoryItem({this.gameboard, this.swipeDirection});

  /// This method creates a JSON blob and send it to a server.
  static void save(List<HistoryItem> history, int score) {}
}
