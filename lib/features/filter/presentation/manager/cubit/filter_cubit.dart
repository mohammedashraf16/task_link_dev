import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_link_dev/features/filter/data/models/filter_model.dart';
import 'package:task_link_dev/features/filter/domain/usecases/filter_usecase.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final FilterUsecase filterUsecase;

  FilterCubit({required this.filterUsecase}) : super(FilterInitial());

  Future<void> filterCompanies({
    required List<int> subCategories,
    required int cityId,
    required String type,
    required String searchText,
  }) async {
    emit(FilterLoading());

    final result = await filterUsecase(
      subCategories: subCategories,
      cityId: cityId,
      type: type,
      searchText: searchText,
    );

    result.fold(
      (failure) => emit(FilterFailure(failure.errorMessage)),
      (model) => emit(FilterSuccess(model)),
    );
  }
}
