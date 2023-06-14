import 'package:dzero/config/config.dart';
import 'package:flutter/material.dart';

class CustomDecoration {
  static BoxDecoration decoration(bool top, [bool allRadius = false, bool card = false]) {
    BorderRadius border;
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

    return BoxDecoration(
      color: Colors.white,
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
