import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/home/data/models/city_model.dart';
import 'package:task_link_dev/features/home/domain/repos/city_repo.dart';

class GetCityUsecase {
  final CityRepo cityRepo;
  GetCityUsecase({required this.cityRepo});
  Future<Either<Failure, CityModel>> call() async {
    return await cityRepo.getCities();
  }
}
