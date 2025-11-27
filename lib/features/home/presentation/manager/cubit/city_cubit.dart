import 'package:bloc/bloc.dart';
import 'package:task_link_dev/features/home/data/models/city_model.dart';
import 'package:task_link_dev/features/home/domain/usecases/get_city_usecase.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final GetCityUsecase getCityUsecase;
  CityCubit({required this.getCityUsecase}) : super(CityInitial());

  Future<void> eitherFailureOrSuccess() async {
    emit(CityLoading());

    final eitherFailureOrSuccess = await getCityUsecase();
    eitherFailureOrSuccess.fold(
      (failure) {
        emit(CityFailure(errorMessage: failure.errorMessage));
      },
      (cityModel) {
        emit(CitySuccess(cityModel: cityModel));
      },
    );
  }
}
