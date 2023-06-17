import 'package:dzero/controllers/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formularioReporteProvider = StateProvider<FormularioReporte>((ref) {
  return FormularioReporte();
});
