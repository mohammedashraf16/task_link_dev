import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/home/data/models/category_model.dart';

abstract class CategoryRepo {
  Future<Either<Failure, CategoryModel>> getCategories();
}
