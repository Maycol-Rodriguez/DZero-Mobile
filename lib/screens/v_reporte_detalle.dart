import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReporteDetalleScreen extends ConsumerWidget {
  static const String name = 'reporte-detalle';
  final String reporteId;
  const ReporteDetalleScreen({Key? key, required this.reporteId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalle = ref.watch(obtenerReporteIdProvider(reporteId));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Reporte',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: detalle.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Text('Error: $error'),
        data: (reporte) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: CustomDecoration.decoration(false, true),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: CustomBorder.radiusTop,
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                          image: NetworkImage(reporte.picture!),
                          height: 380,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: CustomBorder.radiusBottom,
                          color: colorSecondary,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: _UsuarioDetalle(reporte),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UsuarioDetalle extends StatelessWidget {
  final Reporte reporte;
  const _UsuarioDetalle(this.reporte, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatosReporte(icono: Icons.person, titulo: 'Usuario:', data: reporte.user.name),
        DatosReporte(icono: Icons.alternate_email_outlined, titulo: 'Correo:', data: reporte.user.email),
        DatosReporte(icono: Icons.description_outlined, titulo: 'Descripcion:', data: reporte.description!),
        DatosReporteUbicacion(reporte: reporte),
      ],
    );
  }
}

class DatosReporte extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String data;
  const DatosReporte({
    super.key,
    required this.data,
    required this.titulo,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icono),
            const SizedBox(width: 5),
            Text(
              titulo,
              style: textStyle!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(data, textAlign: TextAlign.justify, style: textStyle),
        ),
        const SizedBox(height: 15)
      ],
    );
  }
}

class DatosReporteUbicacion extends ConsumerWidget {
  final Reporte reporte;
  const DatosReporteUbicacion({
    super.key,
    required this.reporte,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => ref.read(
          launcherProvider('https://www.google.com/maps/search/?api=1&query=${reporte.location}'),
        ),
        splashFactory: InkRipple.splashFactory,
        borderRadius: CustomBorder.radiusAll,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 3),
                  Text(
                    'Ubicacion:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.open_in_new_rounded)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
