import 'package:dio/dio.dart';
import 'package:dzero/config/constants/environment.dart';
import 'package:dzero/config/mappers/data_mapper_location.dart';

class CDataProvider {
  final String baseUrl = Environment.baseUrl;
  final dio = Dio();

  List<DataMapperLocation> dataLocation = [];
  bool isLoading = false;
  bool isSaving = false;
  // File? newImage;

  Future<List<DataMapperLocation>> obtenerReportes() async {
    isLoading = true;
    final url = Uri.https(baseUrl, 'reports.json');
    final response = await dio.get(url.toString());
    final Map<String, dynamic> data = response.data;

    data.forEach((key, value) {
      final dataTemp = DataMapperLocation.fromJson(value);
      dataLocation.add(dataTemp);
    });
    isLoading = false;
    return dataLocation;
  }

  Future<void> subirReportes(DataMapperLocation data) async {
    isSaving = true;
    final url = Uri.https(baseUrl, 'reports.json');
    await dio.post(url.toString(), data: data.toJson());
    isSaving = false;
    dataLocation.add(data);
  }
}
