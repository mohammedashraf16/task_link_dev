import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_link_dev/core/connection/network_info.dart';
import 'package:task_link_dev/core/database/api/api_consumer.dart';
import 'package:task_link_dev/core/database/api/dio_consumer.dart';
import 'package:task_link_dev/core/database/cache/cache_helper.dart';
import 'package:task_link_dev/features/filter/data/data_source/filter_remote_data_source.dart';
import 'package:task_link_dev/features/filter/data/repos/filter_repo_impl.dart';
import 'package:task_link_dev/features/filter/domain/repos/filter_repo.dart';
import 'package:task_link_dev/features/filter/domain/usecases/filter_usecase.dart';
import 'package:task_link_dev/features/filter/presentation/manager/cubit/filter_cubit.dart';
import 'package:task_link_dev/features/home/data/data_sources/category_local_data_source.dart';
import 'package:task_link_dev/features/home/data/data_sources/category_remote_data_source.dart';
import 'package:task_link_dev/features/home/data/data_sources/city_local_data_source.dart';
import 'package:task_link_dev/features/home/data/data_sources/city_remote_data_source.dart';
import 'package:task_link_dev/features/home/data/repos/category_repo_impl.dart';
import 'package:task_link_dev/features/home/data/repos/city_repo_impl.dart';
import 'package:task_link_dev/features/home/domain/repos/category_repo.dart';
import 'package:task_link_dev/features/home/domain/repos/city_repo.dart';
import 'package:task_link_dev/features/home/domain/usecases/get_category_usecase.dart';
import 'package:task_link_dev/features/home/domain/usecases/get_city_usecase.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/category_cubit.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/city_cubit.dart';

// core/services/get_it_service.dart  (تعديل - إضافة التسجيلات)
final sl = GetIt.instance;
void setupServiceLocator() {
  sl.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(
    // Provide dependencies needed by your CategoryRepoImpl
    categoryRemoteDataSource: sl(),
    networkInfo: sl(), categoryLocalDataSource: CategoryLocalDataSource(cacheHelper: CacheHelper()),
  ));
  sl.registerLazySingleton<CategoryRemoteDataSource>(
          () => CategoryRemoteDataSource(apiConsumer: sl()));
  // existing registrations...
  sl.registerFactory(() => CategoryCubit(getCategoryUsecase: sl()));
  sl.registerLazySingleton(() => GetCategoryUsecase(categoryRepo: sl()));
  // ... existing category registration

  // City
  sl.registerFactory(() => CityCubit(getCityUsecase: sl()));
  sl.registerLazySingleton(() => GetCityUsecase(cityRepo: sl()));
  sl.registerLazySingleton<CityRepo>(() => CityRepoImpl(
    cityLocalDataSource: CityLocalDataSource(cacheHelper: CacheHelper()),
    cityRemoteDataSource: CityRemoteDataSource(apiConsumer: DioConsumer(dio: Dio())),
    networkInfo: NetworkInfoImpl(DataConnectionChecker()),
  ));
  sl.registerLazySingleton<CityRemoteDataSource>(() => CityRemoteDataSource(apiConsumer: sl()));
  sl.registerLazySingleton<CityLocalDataSource>(() => CityLocalDataSource(cacheHelper: sl()));

  // Filter
  sl.registerFactory(() => FilterCubit(filterUsecase: sl()));
  sl.registerLazySingleton(() => FilterUsecase(sl()));
  sl.registerLazySingleton<FilterRepo>(() => FilterRepoImpl(
    filterRemoteDataSource: sl(),
    networkInfo: sl(),
  ));
  sl.registerLazySingleton<FilterRemoteDataSource>(() => FilterRemoteDataSource(apiConsumer: sl()));

  // network, dio, cache...
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => CacheHelper());
}
