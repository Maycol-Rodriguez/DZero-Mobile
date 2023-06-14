import 'package:dzero/config/config.dart';
import 'package:dzero/controllers/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final obtenerReportesProvider = FutureProvider<List<Reporte>>((ref) async {
  return await ServicioReportes().obtenerReportes();
});

final subirReportesProvider = FutureProvider.family<void, Reporte>((ref, data) async {
  await ServicioReportes().subirReportes(data);
});

final obtenerReporteIdProvider = FutureProvider.family<Reporte, String>((ref, id) async {
  return await ServicioReportes().obtenerReporteId(id);
});
