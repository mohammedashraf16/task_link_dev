import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/company_item.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/pagination_model.dart';
import 'package:task_link_dev/features/filter/presentation/manager/cubit/filter_cubit.dart';
import 'package:task_link_dev/features/filter/presentation/views/widgets/filter_modal.dart';

import 'widgets/filter_list_view_item.dart';

class FilterResultsListView extends StatelessWidget {
  const FilterResultsListView({
    super.key,
    required this.items,
    required this.pagination,
    required this.selectedSubCategories,
    required this.selectedCityId,
    required this.selectedType,
    required this.widget,
    required this.isGrid,
  });

  final List<CompanyItem> items;
  final PaginationModel? pagination;
  final List<int> selectedSubCategories;
  final int selectedCityId;
  final String selectedType;
  final FilterModal widget;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return FilterResultListView(
      items: items,
      pagination: pagination,
      onLoadMore: () {
        context.read<FilterCubit>().filterCompanies(
          subCategories: selectedSubCategories,
          cityId: selectedCityId,
          type: selectedType,
          searchText: widget.searchTextController.text,
          loadMore: true,
        );
      },
      isGrid: isGrid,
    );
  }
}
