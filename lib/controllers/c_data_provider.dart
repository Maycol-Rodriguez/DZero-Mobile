import 'package:dio/dio.dart';
import 'package:dzero/config/constants/environment.dart';
import 'package:dzero/config/mappers/data_mapper_location.dart';

class CDataProvider {
  final dio = Dio();
  bool isSaving = false;
  final String baseUrl = Environment.baseUrl;
  List<DataMapperLocation> dataLocation = [];
  // File? newImage;

  Future<List<DataMapperLocation>> obtenerReportes() async {
    final response = await dio.get('$baseUrl/reports.json');
    final Map<String, dynamic> data = response.data;

    data.forEach((key, value) {
      final dataTemp = DataMapperLocation.fromJson(value);
      dataLocation.add(dataTemp);
    });

    return dataLocation;
  }

  Future<void> subirReportes(DataMapperLocation data) async {
    isSaving = true;
    await dio.post('$baseUrl/reports.json', data: data.toJson());
    isSaving = false;
    dataLocation.add(data);
  }
}
