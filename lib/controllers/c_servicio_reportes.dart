import 'package:dio/dio.dart';
import 'package:dzero/config/config.dart';
import 'package:firebase_database/firebase_database.dart';

class ServicioReportes {
  final dio = Dio();
  List<Reporte> reportes = [];
  bool estaCargando = false;

  Future<List<Reporte>> obtenerReportes() async {
    final peticion = await dio.get('${Environment.baseUrl}/reports.json');
    final Map<String, dynamic> respuesta = peticion.data;

    respuesta.forEach((_, value) {
      final reporte = Reporte.fromJson(value);
      reportes.add(reporte);
    });

    return reportes.reversed.toList();
  }

  Future<void> subirReportes(Reporte reporte) async {
    final db = FirebaseDatabase.instance.ref().child('reports').push();
    await db.set(reporte.toJson());
    reportes.add(reporte);
  }
}
