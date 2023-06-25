import 'package:flutter/material.dart';

void mostrarSnackBar(BuildContext context, String mensaje) {
  final textStyle = Theme.of(context).textTheme.bodySmall;
  ScaffoldMessenger.of(context).clearSnackBars();
  final snackBar = SnackBar(
    content: Text(mensaje, style: textStyle!.copyWith(color: Colors.white, fontSize: 14)),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
