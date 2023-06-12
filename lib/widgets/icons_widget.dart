import 'package:dzero/config/config.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final double border;
  final IconData icon;

  const IconWidget({
    Key? key,
    required this.icon,
    required this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colorTerceary,
        borderRadius: BorderRadius.circular(border),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
