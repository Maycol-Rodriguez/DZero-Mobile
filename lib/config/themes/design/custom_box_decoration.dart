import 'package:dzero/config/config.dart';
import 'package:flutter/material.dart';

class CustomDecoration {
  static BoxDecoration decoration(
    bool top, [
    bool allRadius = false,
    bool card = false,
    bool color = false,
    bool colorImage = false,
  ]) {
    BorderRadius border;
    Color colorS;
    if (top) {
      border = CustomBorder.radiusTop;
    } else {
      border = CustomBorder.radiusBottom;
    }
    if (allRadius) {
      border = CustomBorder.radiusAll;
    }
    if (card) {
      border = CustomBorder.radiusCard;
    }

    if (color) {
      colorS = colorSecondary;
    } else {
      colorS = Colors.white;
    }
    if (colorImage) {
      colorS = Colors.black;
    }

    return BoxDecoration(
      color: colorS,
      borderRadius: border,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}
