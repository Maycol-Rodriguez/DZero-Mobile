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
    title: 'Perfil',
    subTitle: 'Perfil de usuario',
    link: '/perfil',
    icon: Icons.person,
  ),
  ItemDrawer(
    title: 'Resultados',
    subTitle: 'Resultados de la AI',
    link: '/resultado',
    icon: Icons.density_small_outlined,
  ),
  ItemDrawer(
    title: 'Demo',
    subTitle: 'Demo de la aplicacion',
    link: '/demo',
    icon: Icons.document_scanner_outlined,
  ),
];
