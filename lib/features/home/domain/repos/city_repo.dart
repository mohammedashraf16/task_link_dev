import 'package:dartz/dartz.dart';
import 'package:task_link_dev/core/errors/failure.dart';
import 'package:task_link_dev/features/home/data/models/city_model.dart';

abstract class CityRepo {
  Future<Either<Failure, CityModel>> getCities();
}
