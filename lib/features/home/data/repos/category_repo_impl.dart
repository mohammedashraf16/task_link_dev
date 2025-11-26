import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/connection/network_info.dart';
import 'package:task_link_dev/core/errors/exceptions.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/home/data/data_sources/category_local_data_source.dart';
import 'package:task_link_dev/features/home/data/data_sources/category_remote_data_source.dart';
import 'package:task_link_dev/features/home/data/models/category_model.dart';
import 'package:task_link_dev/features/home/domain/repos/category_repo.dart';

class CategoryRepoImpl extends CategoryRepo {
  final CategoryRemoteDataSource categoryRemoteDataSource;
  final CategoryLocalDataSource categoryLocalDataSource;
  final NetworkInfo networkInfo;
  CategoryRepoImpl({
    required this.categoryRemoteDataSource,
    required this.categoryLocalDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, CategoryModel>> getCategories() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteCategory = await categoryRemoteDataSource.getCategories();
        categoryLocalDataSource.cacheCategory(remoteCategory);
        return Right(remoteCategory);
      } on ServerException catch (e) {
        return Left(Failure(errorMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        final localCategory = await categoryLocalDataSource.getLastCategory();
        return Right(localCategory);
      } on CacheException catch (e) {
        return Left(Failure(errorMessage: e.errorMessage));
      }
    }
  }
}
