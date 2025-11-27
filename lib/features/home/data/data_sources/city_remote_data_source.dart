import 'package:task_link_dev/core/database/api/api_consumer.dart';
import 'package:task_link_dev/core/database/api/end_points.dart';
import 'package:task_link_dev/features/home/data/models/city_model.dart';

class CityRemoteDataSource {
  final ApiConsumer apiConsumer;
  CityRemoteDataSource({required this.apiConsumer});
  Future<CityModel> getCities() async {
    final respose = await apiConsumer.get(
      EndPoints.city,
      headers: {ApiKeys.lang: "ar"},
    );
    return CityModel.fromJson(respose);
  }
}
