import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_link_dev/core/connection/network_info.dart';
import 'package:task_link_dev/core/database/api/api_consumer.dart';
import 'package:task_link_dev/core/database/api/dio_consumer.dart';
import 'package:task_link_dev/core/database/cache/cache_helper.dart';
import 'package:task_link_dev/features/home/data/data_sources/category_local_data_source.dart';
import 'package:task_link_dev/features/home/data/data_sources/category_remote_data_source.dart';
import 'package:task_link_dev/features/home/data/repos/category_repo_impl.dart';
import 'package:task_link_dev/features/home/domain/repos/category_repo.dart';
import 'package:task_link_dev/features/home/domain/usecases/get_category_usecase.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/category_cubit.dart';

final sl = GetIt.instance;
void setupServiceLocator() {
  sl.registerFactory(() => CategoryCubit(getCategoryUsecase: sl()));
  sl.registerLazySingleton(() => GetCategoryUsecase(categoryRepo: sl()));
  sl.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImpl(
      categoryRemoteDataSource: sl(),
      categoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSource(apiConsumer: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSource(cacheHelper: sl()),
  );
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => CacheHelper());
}
