import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zwo_achtundvierzig/tile.dart';

main() {
  test("There should be a valid number for every card until lvl. 18", () {
    for (var i = 0; i <= 18; i++) {
      expect(Tile.colorFromNumber(i) != Colors.white, true);
    }
  });

  test("The tile text should not be too small.", () {
    for (var i = 0; i <= 18; i++) {
      var fontSize = Tile.fontSizeByTextLength(pow(2, i).toString());
      expect(fontSize >= 20, true);
    }
  });
}
