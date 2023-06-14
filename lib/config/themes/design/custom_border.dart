import 'package:flutter/material.dart';

class CustomBorder {
  static const radiusTop = BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  static const radiusBottom = BorderRadius.only(
    bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
  );

  static const radiusAll = BorderRadius.all(
    Radius.circular(25),
  );

  static const radiusCard = BorderRadius.only(
    topLeft: Radius.circular(40),
    topRight: Radius.circular(40),
  );
}
