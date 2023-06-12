import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final String text;
  const Separator(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
