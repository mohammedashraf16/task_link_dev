import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_link_dev/features/filter/data/models/filter_model.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/data_model.dart';
import 'package:task_link_dev/features/filter/domain/usecases/filter_usecase.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final FilterUsecase filterUsecase;

  FilterCubit({required this.filterUsecase}) : super(FilterInitial());

  // keep current accumulated data
  FilterModel? _accumulatedModel;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  Future<void> filterCompanies({
    required List<int> subCategories,
    required int cityId,
    required String type,
    required String searchText,
    bool loadMore = false,
  }) async {
    if (!loadMore) {
      emit(FilterLoading());
      _currentPage = 1;
      _accumulatedModel = null;
    } else {
      if (_isLoadingMore) return;
      _isLoadingMore = true;
      emit(FilterLoadingMore(model: _accumulatedModel)); // optional new state
      _currentPage += 1;
    }

    final result = await filterUsecase(
      subCategories: subCategories,
      cityId: cityId,
      type: type,
      searchText: searchText,
      page: _currentPage,
    );

    _isLoadingMore = false;

    result.fold(
          (failure) => emit(FilterFailure(failure.errorMessage)),
          (model) {
        if (loadMore && _accumulatedModel != null) {
          // append new items
          final existing = _accumulatedModel!.data?.data ?? [];
          final incoming = model.data?.data ?? [];
          final mergedList = [...existing, ...incoming];
          final mergedPagination = model.data?.pagination ?? _accumulatedModel!.data?.pagination;
          final mergedDataModel = DataModel(data: mergedList, pagination: mergedPagination);
          final mergedModel = FilterModel(data: mergedDataModel, message: model.message, status: model.status);
          _accumulatedModel = mergedModel;
          emit(FilterSuccess(mergedModel));
        } else {
          _accumulatedModel = model;
          emit(FilterSuccess(model));
        }
      },
    );
  }

  // optionally expose accumulatedModel
  FilterModel? get accumulatedModel => _accumulatedModel;
}
