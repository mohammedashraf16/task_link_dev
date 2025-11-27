import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Data extends Equatable {
  int? id;
  String? name;
  String? img;

  Data({this.id, this.name, this.img});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    return data;
  }

  @override
  List<Object?> get props => [id, name, img];
}
