import 'package:flutter/material.dart';
import 'package:dzero/config/config.dart';

class UltimoCasoWidget extends StatelessWidget {
  final DataMapperLocation ultimoReporte;

  const UltimoCasoWidget({
    super.key,
    required this.ultimoReporte,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: colorTerceary,
          child: Icon(
            Icons.location_on,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Ultimo Caso Reportado',
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 15),
        Text(
          ultimoReporte.user.name,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          ultimoReporte.description ?? 'descripcion',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}