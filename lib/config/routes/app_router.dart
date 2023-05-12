import 'package:dzero/screens/screens.dart';
import 'package:dzero/screens/v_registro_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routesProvider = StateProvider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
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
        builder: (context, state) => const VLoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: VHomeScreen.name,
        builder: (context, state) => const VHomeScreen(),
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
        name: VDemoDataScreen.name,
        builder: (context, state) => const VDemoDataScreen(),
      ),
    ],
  );
});
