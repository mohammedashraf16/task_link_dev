import 'dart:convert';
import 'package:task_link_dev/core/database/cache/cache_helper.dart';
import 'package:task_link_dev/core/errors/exceptions.dart';
import 'package:task_link_dev/features/home/data/models/category_model.dart';

class CategoryLocalDataSource {
  final CacheHelper cacheHelper;
  CategoryLocalDataSource({required this.cacheHelper});
  final String cachedCategoryKey = 'CACHED_CATEGORY_KEY';
  final String cachedCityKey = 'CACHED_CITY_KEY';
  Future<void> cacheCategory(CategoryModel? categoryModel) async {
    if (categoryModel != null) {
      await cacheHelper.saveData(
        key: cachedCategoryKey,
        value: json.encode(categoryModel.toJson()),
      );
    } else {
      throw CacheExeption(
        errorMessage: "No Internet connection and no cached data available",
      );
    }
  }

  Future<CategoryModel> getLastCategory() async {
    final jsonString = cacheHelper.getData(key: cachedCategoryKey);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return CategoryModel.fromJson(jsonMap);
    } else {
      throw CacheExeption(
        errorMessage: "No Internet connection and no cached data available",
      );
    }
  }
}
