class CityItem {
  final int? id;
  final String? name;

  CityItem({this.id, this.name});

  factory CityItem.fromJson(Map<String, dynamic> json) {
    return CityItem(id: json['id'] as int?, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
