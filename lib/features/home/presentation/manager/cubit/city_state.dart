part of 'city_cubit.dart';

sealed class CityState {
  const CityState();
}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CitySuccess extends CityState {
  final CityModel cityModel;
  const CitySuccess({required this.cityModel});
}

final class CityFailure extends CityState {
  final String errorMessage;
  const CityFailure({required this.errorMessage});
}
