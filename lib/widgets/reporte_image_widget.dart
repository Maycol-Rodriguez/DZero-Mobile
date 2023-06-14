import 'package:dzero/config/config.dart';
import 'package:flutter/material.dart';

class ReporteImageWidget extends StatelessWidget {
  const ReporteImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: CustomDecoration.decoration(true),
        child: const ClipRRect(
          borderRadius: CustomBorder.radiusTop,
          child: FadeInImage(
            placeholder: AssetImage('assets/loaders/bottle-loader.gif'),
            image: NetworkImage('https://via.placeholder.com/400x300/green'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
