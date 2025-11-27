import 'package:equatable/equatable.dart';

class CompanyItem extends Equatable {
  @override
  List<Object?> get props => [
    id,
    name,
    type,
    img,
    desc,
    avgRates,
    fav,
    location,
  ];
  final int? id;
  final String? name;
  final String? type;
  final String? img;
  final String? desc;
  final String? avgRates;
  final bool? fav;
  final String? location;

  const CompanyItem({
    this.id,
    this.name,
    this.type,
    this.img,
    this.desc,
    this.avgRates,
    this.fav,
    this.location,
  });

  factory CompanyItem.fromJson(Map<String, dynamic> json) {
    return CompanyItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      img: json['img'] as String?,
      desc: json['desc'] as String?,
      avgRates: json['avg_rates'] as String?,
      fav: json['fav'] as bool?,
      location: json['location'] as String?,
    );
  }
}
