part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterSuccess extends FilterState {
  final FilterModel model;
  FilterSuccess(this.model);

  @override
  List<Object?> get props => [model];
}

class FilterFailure extends FilterState {
  final String message;
  FilterFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class FilterLoadingMore extends FilterState {
  final FilterModel? model;
  FilterLoadingMore({this.model});

  @override
  List<Object?> get props => [model];
}
