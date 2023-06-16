import 'package:dzero/config/config.dart';
import 'package:flutter/material.dart';

class UltimoCasoWidget extends StatelessWidget {
  final Reporte ultimoReporte;

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
            Icons.location_on_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Ultimo Caso Reportado',
        ),
        const SizedBox(height: 15),
        Text(
          ultimoReporte.user.name,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          ultimoReporte.description ?? 'descripcion',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
