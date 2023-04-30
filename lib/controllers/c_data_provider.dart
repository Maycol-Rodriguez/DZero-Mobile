import 'package:dio/dio.dart';
import 'package:dzero/config/constants/environment.dart';
import 'package:dzero/config/mappers/data_mapper_location.dart';

class CDataProvider {
  final String baseUrl = Environment.baseUrl;

  List<DataMapperLocation> dataLocation = [];
  bool isLoading = false;
  bool isSaving = false;
  // File? newImage;

  Future<List<DataMapperLocation>> obtenerReportes() async {
    isLoading = true;
    final url = Uri.https(baseUrl, 'reports.json');
    final response = await Dio().get(url.toString());
    final Map<String, dynamic> data = response.data;

    data.forEach((key, value) {
      final dataTemp = DataMapperLocation.fromJson(value);
      dataTemp.id = key;
      dataLocation.add(dataTemp);
    });
    isLoading = false;
    return dataLocation;
  }

  Future<void> subirReportes(DataMapperLocation data) async {
    final url = Uri.https(baseUrl, 'reports.json');
    final response = await Dio().post(url.toString(), data: data.toJson());
    final id = response.data['name'];

    data.id = id;
    dataLocation.add(data);
    // obtenerReportes();
  }
}
