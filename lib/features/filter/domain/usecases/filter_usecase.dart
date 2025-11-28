import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/filter/data/models/filter_model.dart';
import 'package:task_link_dev/features/filter/domain/repos/filter_repo.dart';

class FilterUsecase {
  final FilterRepo repo;

  FilterUsecase(this.repo);

  Future<Either<Failure, FilterModel>> call({
    required List<int> subCategories,
    required int cityId,
    required String type,
    required String searchText,
    required int page,
  }) async {
    return await repo.filterCompanies(
      subCategories: subCategories,
      cityId: cityId,
      type: type,
      searchText: searchText,
      page: page,
    );
  }
}
