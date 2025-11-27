import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/connection/network_info.dart';
import 'package:task_link_dev/core/errors/exceptions.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/home/data/data_sources/city_local_data_source.dart';
import 'package:task_link_dev/features/home/data/data_sources/city_remote_data_source.dart';
import 'package:task_link_dev/features/home/data/models/city_model.dart';
import 'package:task_link_dev/features/home/domain/repos/city_repo.dart';

class CityRepoImpl extends CityRepo {
  final CityRemoteDataSource cityRemoteDataSource;
  final CityLocalDataSource cityLocalDataSource;
  final NetworkInfo networkInfo;
  CityRepoImpl({
    required this.cityRemoteDataSource,
    required this.cityLocalDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, CityModel>> getCities() async {
    if (await networkInfo.isConnected!) {
      try {
        final remotedata = await cityRemoteDataSource.getCities();
        cityLocalDataSource.cacheCity(remotedata);
        return Right(remotedata);
      } on ServerException catch (e) {
        return Left(Failure(errorMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        final cachedCity = await cityLocalDataSource.getCachedCity();
        return Right(cachedCity);
      } on CacheExeption catch (e) {
        return Left(Failure(errorMessage: e.errorMessage));
      }
    }
  }
}
