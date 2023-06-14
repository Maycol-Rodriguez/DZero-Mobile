import 'package:dzero/screens/screens.dart';
import 'package:go_router/go_router.dart';

final rutas = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      name: VPresentacionScreen.name,
      builder: (context, state) => const VPresentacionScreen(),
    ),
    GoRoute(
      path: '/login',
      name: VLoginScreen.name,
      builder: (context, state) => const VLoginScreen(),
    ),
    GoRoute(
      path: '/registro',
      name: VRegistroScreen.name,
      builder: (context, state) => const VRegistroScreen(),
    ),
    GoRoute(
      path: '/home',
      name: VHomeScreen.name,
      builder: (context, state) => const VHomeScreen(),
    ),
    GoRoute(
      path: '/generar-reporte',
      name: GenerarReporteScreen.name,
      builder: (context, state) => const GenerarReporteScreen(),
    ),
    GoRoute(
      path: '/perfil',
      name: VPerfilScreen.name,
      builder: (context, state) => const VPerfilScreen(),
    ),
    GoRoute(
      path: '/resultado',
      name: VResultadosScreen.name,
      builder: (context, state) => const VResultadosScreen(),
    ),
    GoRoute(
      path: '/casos',
      name: VCasosScreen.name,
      builder: (context, state) => const VCasosScreen(),
    ),
    GoRoute(
      path: '/reporte-detalle/:id',
      name: ReporteDetalleScreen.name,
      builder: (context, state) {
        final id = state.params['id'] ?? 'no-id';
        return ReporteDetalleScreen(reporteId: id);
      },
    ),
  ],
);
