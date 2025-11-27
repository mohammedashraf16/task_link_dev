import 'package:equatable/equatable.dart';
import 'package:task_link_dev/features/home/data/models/sub_models/data_model.dart';

// ignore: must_be_immutable
class CategoryModel extends Equatable{
  List<Data>? data;
  String? message;
  bool? status;
@override
  List<Object?> get props => [data, message, status];
  CategoryModel({this.data, this.message, this.status});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
  
  
}
