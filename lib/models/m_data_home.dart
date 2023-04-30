import 'package:dzero/config/mappers/data_mapper_location.dart';
import 'package:dzero/controllers/c_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final obtenerReportesProvider =
    StateProvider<Future<List<DataMapperLocation>>>((ref) async {
  return await CDataProvider().obtenerReportes();
});

final subirReportesProvider =
    FutureProvider.family<void, DataMapperLocation>((ref, data) async {
  await CDataProvider().subirReportes(data);
});
