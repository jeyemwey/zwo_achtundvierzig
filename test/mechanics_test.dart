import 'package:flutter_test/flutter_test.dart';
import 'package:zwo_achtundvierzig/mechanics.dart';

main() {
  test("The values behind the swipe directions should be unique", () {
    expect(Mechanics.SWIPE_NORTH != Mechanics.SWIPE_EAST, true);
    expect(Mechanics.SWIPE_NORTH != Mechanics.SWIPE_SOUTH, true);
    expect(Mechanics.SWIPE_NORTH != Mechanics.SWIPE_WEST, true);
    expect(Mechanics.SWIPE_EAST != Mechanics.SWIPE_NORTH, true);
    expect(Mechanics.SWIPE_EAST != Mechanics.SWIPE_SOUTH, true);
    expect(Mechanics.SWIPE_EAST != Mechanics.SWIPE_WEST, true);
    expect(Mechanics.SWIPE_SOUTH != Mechanics.SWIPE_NORTH, true);
    expect(Mechanics.SWIPE_SOUTH != Mechanics.SWIPE_EAST, true);
    expect(Mechanics.SWIPE_SOUTH != Mechanics.SWIPE_WEST, true);
    expect(Mechanics.SWIPE_WEST != Mechanics.SWIPE_NORTH, true);
    expect(Mechanics.SWIPE_WEST != Mechanics.SWIPE_EAST, true);
    expect(Mechanics.SWIPE_WEST != Mechanics.SWIPE_SOUTH, true);
  });
}
