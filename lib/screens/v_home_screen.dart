import 'package:dzero/config/config.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VHomeScreen extends ConsumerWidget {
  static const String name = 'home_screen';
  const VHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
    final data = ref.watch(obtenerReportesProvider);

    return Scaffold(
      appBar: AppBar(),
      key: drawerKey,
      drawer: DrawerWidget(drawerKey),
      body: SafeArea(
        child: data.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (value) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContenedorHeader(value.length, value.length),
                ContenedorFooter(data, value),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ContenedorHeader extends StatelessWidget {
  final int misCasos;
  final int ultimosCasos;
  const ContenedorHeader(
    this.misCasos,
    this.ultimosCasos, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 5),
            const Separator('Bienvenido'),
            const DetallesDeUsuariosWidget(),
            const SizedBox(height: 20),
            const Separator('Tus casos'),
            Expanded(child: CasosDeUsuariosWidget(misCasos, ultimosCasos))
          ],
        ),
      ),
    );
  }
}

class ContenedorFooter extends ConsumerWidget {
  final AsyncValue<List<Reporte>> asyncReporte;
  final List<Reporte> reportes;

  const ContenedorFooter(
    this.asyncReporte,
    this.reportes, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.4,
          ),
          Positioned(
            width: size.width,
            bottom: 0,
            child: GestureDetector(
              onTap: () => context.push('/reporte-detalle/${reportes[0].id}'),
              child: Container(
                width: double.infinity,
                height: size.height * 0.28,
                decoration: CustomDecoration.decoration(true, false, true),
                child: asyncReporte.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Error: $error')),
                  data: (value) {
                    return Padding(
                      padding: const EdgeInsets.all(25),
                      child: UltimoCasoWidget(ultimoReporte: reportes[0]),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 0,
            child: FloatingActionButton(
              onPressed: () => context.pushNamed(GenerarReporteScreen.name),
              heroTag: 1,
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
