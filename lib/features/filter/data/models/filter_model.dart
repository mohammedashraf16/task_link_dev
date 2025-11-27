import 'package:equatable/equatable.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/data_model.dart';

class FilterModel extends Equatable {
  @override
  List<Object?> get props => [data, message, status];
  final DataModel? data;
  final String? message;
  final bool? status;

  const FilterModel({this.data, this.message, this.status});

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      data: json['data'] != null
          ? DataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );
  }
}
