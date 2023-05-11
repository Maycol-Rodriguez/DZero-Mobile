import 'package:flutter/material.dart';

class ItemDrawer {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const ItemDrawer({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
  });
}

const appMenuItem = <ItemDrawer>[
  ItemDrawer(
    title: 'Inicio',
    subTitle: 'Pantalla de inicio',
    link: '/home',
    icon: Icons.home,
  ),
  ItemDrawer(
    title: 'Perfil',
    subTitle: 'Perfil de usuario',
    link: '/perfil',
    icon: Icons.person,
  ),
];
