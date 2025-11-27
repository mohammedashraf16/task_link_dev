import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/connection/network_info.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/filter/data/data_source/filter_remote_data_source.dart';
import 'package:task_link_dev/features/filter/data/models/filter_model.dart';
import 'package:task_link_dev/features/filter/domain/repos/filter_repo.dart';

class FilterRepoImpl extends FilterRepo {
  final FilterRemoteDataSource filterRemoteDataSource;
  final NetworkInfo networkInfo;

  FilterRepoImpl({
    required this.filterRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FilterModel>> filterCompanies({
    required List<int> subCategories,
    required int cityId,
    required String type,
    required String searchText,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await filterRemoteDataSource.postCompanyFilter(
          subCategories: subCategories,
          cityId: cityId,
          type: type,
          searchText: searchText,
        );
        return Right(remoteData);
      } catch (e) {
        return Left(Failure(errorMessage: e.toString()));
      }
    } else {
      return Left(Failure(errorMessage: "No Internet Connection"));
    }
  }
}

