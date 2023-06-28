import 'package:dzero/controllers/c_ubicacion_usuario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final ubicacionProvider = FutureProvider.autoDispose<Position>((ref) async {
  return Ubicacion.obtenerUbicacion();
});
