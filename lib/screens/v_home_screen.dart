import 'package:dzero/config/mappers/type_reportes.dart';
import 'package:dzero/config/themes/design/custom_box_decoration.dart';
import 'package:dzero/models/models.dart';
import 'package:dzero/screens/screens.dart';
import 'package:dzero/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VHomeScreen extends ConsumerStatefulWidget {
  static const String name = 'home_screen';
  const VHomeScreen({Key? key}) : super(key: key);

  @override
  VHomeScreenState createState() => VHomeScreenState();
}

class VHomeScreenState extends ConsumerState<VHomeScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // mostrarSnackBar(context, 'Usuario autenticado correctamente');
      } else {
        mostrarSnackBar(context, 'Sesion cerrada correctamente');
        context.go('/login');
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
    final data = ref.watch(obtenerReportesProvider);
    final usuario = ref.watch(usuarioAutenticado);

    return Scaffold(
      appBar: AppBar(),
      key: drawerKey,
      drawer: MyDrawer(usuario: usuario),
      body: SafeArea(
        child: data.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (value) {
            final misCasos =
                value.where((element) => element.id == FirebaseAuth.instance.currentUser?.uid).length;
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContenedorHeader(misCasos, value.length),
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
              onTap: () => context.push('/login/home/reporte-detalle', extra: reportes[0]),
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
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}