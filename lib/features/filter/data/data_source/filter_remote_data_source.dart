import 'package:task_link_dev/core/database/api/api_consumer.dart';
import 'package:task_link_dev/core/database/api/end_points.dart';
import 'package:task_link_dev/features/filter/data/models/filter_model.dart';

class FilterRemoteDataSource {
  final ApiConsumer apiConsumer;

  FilterRemoteDataSource({required this.apiConsumer});

  /// page: optional (1-based). Or provide full nextPageUrl in `overrideUrl`.
  Future<FilterModel> postCompanyFilter({
    required List<int> subCategories,
    required int cityId,
    required String type,
    required String searchText,
    int page = 1,
    String? overrideUrl,
  }) async {
    final data = {
      "sub_categories": subCategories,
      "city_id": cityId,
      "type": type,
      "search": searchText,
      "page": page,
    };

    final response = await apiConsumer.post(
      overrideUrl ?? EndPoints.filter,
      headers: {ApiKeys.lang: "ar"},
      isFormData: true,
      data: data,
    );
    return FilterModel.fromJson(response);
  }
}
