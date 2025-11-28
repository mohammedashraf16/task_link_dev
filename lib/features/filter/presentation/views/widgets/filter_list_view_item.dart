import 'package:flutter/material.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/company_item.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/pagination_model.dart';
import 'package:task_link_dev/features/filter/presentation/views/widgets/company_card.dart';

class FilterResultListView extends StatefulWidget {
  final List<CompanyItem> items;
  final PaginationModel? pagination;
  final VoidCallback onLoadMore;
  final bool isGrid;

  const FilterResultListView({
    required this.items,
    required this.pagination,
    required this.onLoadMore,
    required this.isGrid,
    Key? key,
  }) : super(key: key);

  @override
  State<FilterResultListView> createState() => _FilterResultListViewState();
}

class _FilterResultListViewState extends State<FilterResultListView> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 100) {
        // load next if exists
        if (widget.pagination?.nextPageUrl != null) {
          widget.onLoadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isGrid) {
      return GridView.builder(
        controller: _controller,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, i) =>
            CompanyCard(item: widget.items[i], isGrid: true),
      );
    } else {
      return ListView.separated(
        controller: _controller,
        itemCount: widget.items.length,
        separatorBuilder: (_, _) => Divider(),
        itemBuilder: (context, i) =>
            CompanyCard(item: widget.items[i], isGrid: false),
      );
    }
  }
}