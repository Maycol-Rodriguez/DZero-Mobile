import 'package:dzero/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routesProvider = StateProvider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
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
        path: '/demo',
        name: DemoDataScreen.name,
        builder: (context, state) => const DemoDataScreen(),
      ),
    ],
  );
});
