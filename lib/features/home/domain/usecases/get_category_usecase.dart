import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/home/data/models/category_model.dart';
import 'package:task_link_dev/features/home/domain/repos/category_repo.dart';

class GetCategoryUsecase {
  final CategoryRepo categoryRepo;
  GetCategoryUsecase({required this.categoryRepo});
  Future<Either<Failure, CategoryModel>> call() async {
    return await categoryRepo.getCategories();
  }
}
