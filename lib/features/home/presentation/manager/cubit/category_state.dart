part of 'category_cubit.dart';

sealed class CategoryState {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final CategoryModel categoryModel;
  const CategorySuccess({required this.categoryModel});
}

final class CategoryFailure extends CategoryState {
  final String errorMessage;
  const CategoryFailure({required this.errorMessage});
}
