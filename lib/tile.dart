import 'dart:math';

import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  int value; // This is not powed!

  Tile(this.value);

  @override
  Widget build(BuildContext context) {
    String t = pow(2, value).toString();

    return Container(
      height: MediaQuery.of(context).size.width * 0.25,
      width: MediaQuery.of(context).size.width * 0.25,
      color: colorFromNumber(value),
      child: Center(
        child: Text(
          value == 0 ? "" : t,
          style: TextStyle(
            fontSize: fontSizeByTextLength(t),
          ),
        ),
      ),
    );
  }

  static Color colorFromNumber(int r) {
    switch (r) {
      case 0:
        return Colors.yellow[100];
      case 1:
        return Colors.yellow[200];
      case 2:
        return Colors.yellow[300];
      case 3:
        return Colors.yellow[400];
      case 4:
        return Colors.yellow[500];
      case 5:
        return Colors.yellow[600];
      case 6:
        return Colors.yellow[700];
      case 7:
        return Colors.yellow[800];
      case 8:
        return Colors.yellow[900];
      case 9:
        return Colors.amber[600];
      case 10:
        return Colors.amber[700];
      case 11:
        return Colors.amber[800];
      case 12:
        return Colors.amber[900];
      case 13:
        return Colors.purple[200];
      case 14:
        return Colors.purple[300];
      case 15:
        return Colors.purple[400];
      case 16:
        return Colors.purple[500];
      case 17:
        return Colors.purple[600];
      case 18:
        return Colors.purple[700];
      default:
        return Colors.white;
    }
  }

  static double fontSizeByTextLength(String t) {
    return kBottomNavigationBarHeight * (10 - t.length) / 10;
  }
}
