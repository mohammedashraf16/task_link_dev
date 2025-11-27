import 'package:equatable/equatable.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/link_item.dart';

class PaginationModel extends Equatable {
  @override
  List<Object?> get props => [
    currentPage,
    firstPageUrl,
    from,
    lastPage,
    lastPageUrl,
    links,
    nextPageUrl,
    path,
    perPage,
    to,
    total,
    prevPageUrl,
  ];
  final int? currentPage;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<LinkItem>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;
  final String? prevPageUrl;

  PaginationModel({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.to,
    this.total,
    this.prevPageUrl,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    List<LinkItem>? linksList;
    if (json['links'] is List) {
      linksList = (json['links'] as List)
          .map((item) => LinkItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return PaginationModel(
      currentPage: json['current_page'] as int?,
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: linksList,
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      to: json['to'] as int?,
      total: json['total'] as int?,
      prevPageUrl: json['prev_page_url'] as String?,
    );
  }
}
