import 'package:equatable/equatable.dart';

class LinkItem extends Equatable {
  @override
  List<Object?> get props => [url, label, active];
  final String? url;
  final String? label;
  final bool? active;

  const LinkItem({this.url, this.label, this.active});

  factory LinkItem.fromJson(Map<String, dynamic> json) {
    return LinkItem(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );
  }
}
