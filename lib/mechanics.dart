class Mechanics {
  // Swipe directions
  static const SWIPE_NORTH = 0;
  static const SWIPE_EAST = 1;
  static const SWIPE_SOUTH = 2;
  static const SWIPE_WEST = 3;

  static List<List<int>> move(List<List<int>> gameboard, int direction) {
    switch (direction) {
      case SWIPE_NORTH:
        print("Swipe north!");
        break;
      case SWIPE_EAST:
        print("Swipe east!");
        break;
      case SWIPE_SOUTH:
        print("Swipe south!");
        break;
      case SWIPE_WEST:
        print("Swipe west!");
        break;
      default:
        throw new ArgumentError.value(direction, "move");
    }

    return gameboard;
  }
}
