import 'package:task_link_dev/core/database/api/api_consumer.dart';
import 'package:task_link_dev/core/database/api/end_points.dart';
import 'package:task_link_dev/features/home/data/models/category_model.dart';

class CategoryRemoteDataSource {
  final ApiConsumer apiConsumer;
  CategoryRemoteDataSource({required this.apiConsumer});
  Future<CategoryModel> getCategories() async {
    final respose = await apiConsumer.get(
      EndPoints.category,
      headers: {ApiKeys.lang: "ar"},
    );
    return CategoryModel.fromJson(respose);
  }
}
