import 'package:task_link_dev/core/database/api/api_consumer.dart';
import 'package:task_link_dev/core/database/api/end_points.dart';
import 'package:task_link_dev/features/filter/data/models/filter_model.dart';

class FilterRemoteDataSource {
  final ApiConsumer apiConsumer;

  FilterRemoteDataSource({required this.apiConsumer});
  Future<FilterModel> postCompanyFilter({
    required List<int> subCategories,
    required int cityId,
    required String type,
    required String searchText,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.filter,
      headers: {ApiKeys.lang: "ar"},
      isFormData: true,
      data: {
        "sub_categories": subCategories,
        "city_id": cityId,
        "type": type,
        "search": searchText,
      },
    );
    return FilterModel.fromJson(response);
  }
}
