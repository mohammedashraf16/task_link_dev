import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/filter/data/models/filter_model.dart';

abstract class FilterRepo {
  Future<Either<Failure, FilterModel>> filterCompanies({
    required List<int> subCategories,
    required int cityId,
    required String type,
    required String searchText,
    required int page,
  });
}
