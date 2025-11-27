import 'dart:convert';
import 'package:task_link_dev/core/database/cache/cache_helper.dart';
import 'package:task_link_dev/core/errors/exceptions.dart';
import 'package:task_link_dev/features/home/data/models/city_model.dart';

class CityLocalDataSource {
  final CacheHelper cacheHelper;
  CityLocalDataSource({required this.cacheHelper});

  static const String cachedCityKey = "CACHED_CITY";
  Future<void> cacheCity(CityModel? cityModel) async {
    if (cityModel != null) {
      await cacheHelper.saveData(
        key: cachedCityKey,
        value: json.encode(cityModel.toJson()),
      );
    } else {
      throw CacheExeption(
        errorMessage: "No Internet connection and no cached data available",
      );
    }
  }

  Future<CityModel> getCachedCity() async {
    final jsonString = await cacheHelper.getData(key: cachedCityKey);
    if (jsonString != null) {
      final jsonMap = await json.decode(jsonString);
      return CityModel.fromJson(jsonMap);
    } else {
      throw CacheExeption(
        errorMessage: "No Internet connection and no cached data available",
      );
    }
  }
}
