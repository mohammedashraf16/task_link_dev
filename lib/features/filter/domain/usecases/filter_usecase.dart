import 'package:task_link_dev/features/filter/domain/repos/filter_repo.dart';

class FilterUsecase {
  final FilterRepo repo;
  FilterUsecase({required this.repo});

  Future call({
    required List<int> subCategories,
    required int cityId,
    required String type,
    required String searchText,
  }) async {
    return await repo.filterCompanies(
      subCategories: subCategories,
      cityId: cityId,
      type: type,
      searchText: searchText,
    );
  }
}
