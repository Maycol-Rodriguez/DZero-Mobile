import 'package:dzero/config/config.dart';
import 'package:dzero/widgets/reporte_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GenerarReporteScreen extends ConsumerWidget {
  static const String name = 'generar-reporte';
  const GenerarReporteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                const ReporteImageWidget(),
                Positioned(
                  top: 50,
                  left: 10,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      //TODO: Camara o Galeria
                    },
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
              ],
            ),
            const _FormularioReporte(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorTerceary,
        heroTag: 1,
        icon: const Icon(Icons.send, color: Colors.white),
        label: const Text('Publicar reporte', style: TextStyle(color: Colors.white)),
        onPressed: () {},
      ),
    );
  }
}

class _FormularioReporte extends ConsumerWidget {
  const _FormularioReporte();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: CustomDecoration.decoration(false),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Nombre del usuario ',
                  prefixIcon: Icons.person,
                ),
                onChanged: (value) {},
                onFieldSubmitted: (usuario) {},
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Descripcion',
                  hintText: 'Descripcion del reporte ',
                  prefixIcon: Icons.description,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
