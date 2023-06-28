import 'package:dzero/config/config.dart';
import 'package:dzero/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rutas = GoRouter(
  initialLocation: '/login',
  routes: [
    // GoRoute(
    //   path: '/',
    //   name: VPresentacionScreen.name,
    //   builder: (context, state) => const VPresentacionScreen(),
    // ),

    GoRoute(
      path: '/',
      name: VHomeScreen.name,
      builder: (context, state) => const VHomeScreen(),
      routes: [
        GoRoute(
          path: 'login',
          name: VLoginScreen.name,
          builder: (context, state) => const VLoginScreen(),
        ),
        GoRoute(
          path: 'registro',
          name: VRegistroScreen.name,
          builder: (context, state) => const VRegistroScreen(),
        ),
        GoRoute(
          path: 'generar-reporte',
          name: GenerarReporteScreen.name,
          builder: (context, state) => const GenerarReporteScreen(),
        ),
        GoRoute(
          path: 'perfil',
          name: VPerfilScreen.name,
          builder: (context, state) => const VPerfilScreen(),
        ),
        GoRoute(
          path: 'resultado',
          name: VResultadosScreen.name,
          builder: (context, state) => const VResultadosScreen(),
        ),
        GoRoute(
          path: 'casos-generales',
          name: CasosReportadosScreen.name,
          builder: (context, state) => const CasosReportadosScreen(),
        ),
        GoRoute(
          path: 'mis-casos',
          name: MisCasosScreen.name,
          builder: (context, state) => const MisCasosScreen(),
        ),
        GoRoute(
          path: 'reporte-detalle',
          name: ReporteDetalleScreen.name,
          pageBuilder: (context, state) {
            return MaterialPage(child: ReporteDetalleScreen(reporte: state.extra as Reporte));
          },
        ),
      ],
    ),
  ],
);
