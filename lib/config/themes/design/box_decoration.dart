import 'package:flutter/material.dart';

final decoration = BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(50),
    topRight: Radius.circular(50),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ],
);
