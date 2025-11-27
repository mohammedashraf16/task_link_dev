import 'package:equatable/equatable.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/company_item.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/pagination_model.dart';

class DataModel extends Equatable {
  @override
  List<Object?> get props => [data, pagination];
  final List<CompanyItem>? data;
  final PaginationModel? pagination;

  const DataModel({this.data, this.pagination});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    List<CompanyItem>? dataList;
    if (json['data'] is List) {
      dataList = (json['data'] as List)
          .map((item) => CompanyItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return DataModel(
      data: dataList,
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }
}
