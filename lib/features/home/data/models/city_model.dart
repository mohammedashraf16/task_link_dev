import 'package:task_link_dev/features/home/data/models/sub_models/city_item.dart';

class CityModel {
  final List<CityItem>? data;
  final String? message;
  final bool? status;

  CityModel({this.data, this.message, this.status});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    List<CityItem>? dataList;
    if (json['data'] is List) {
      dataList = (json['data'] as List)
          .map((item) => CityItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return CityModel(
      data: dataList,
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
      'message': message,
      'status': status,
    };
  }
}
