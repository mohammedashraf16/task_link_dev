import 'package:bloc/bloc.dart';
import 'package:task_link_dev/features/home/data/models/category_model.dart';
import 'package:task_link_dev/features/home/domain/usecases/get_category_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoryUsecase getCategoryUsecase;
  CategoryCubit({required this.getCategoryUsecase}) : super(CategoryInitial());
  Future<void> eitherFailureOrSuccess() async {
    emit(CategoryLoading());
    final eitherFailureOrSuccess = await getCategoryUsecase();
    eitherFailureOrSuccess.fold(
      (failure) {
        emit(CategoryFailure(errorMessage: failure.errorMessage));
      },
      (categoryModel) {
        emit(CategorySuccess(categoryModel: categoryModel));
      },
    );
  }
}
