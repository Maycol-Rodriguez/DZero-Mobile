import 'package:flutter/material.dart';

List<Widget> tutorial = [
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/phone_presentation.png',
          fit: BoxFit.cover,
          width: 250,
        ),
        const SizedBox(height: 100),
        const Text(
          'Nueva Forma de mejorar y reciclar el RCD',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
      ],
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/persons.png',
          fit: BoxFit.cover,
          width: 250,
        ),
        const SizedBox(height: 100),
        const Text(
          'Participación Ciudadana en Reciclaje',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
      ],
    ),
  ),
];
