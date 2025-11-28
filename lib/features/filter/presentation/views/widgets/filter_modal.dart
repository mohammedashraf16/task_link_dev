import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_link_dev/core/services/get_it_service.dart';
import 'package:task_link_dev/features/filter/presentation/manager/cubit/filter_cubit.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/category_cubit.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/city_cubit.dart';
import 'empty_search_widget.dart';
import '../filter_results_list_view.dart';

class FilterModal extends StatefulWidget {
  final TextEditingController searchTextController;
  final ValueChanged<bool>? onToggleView;

  const FilterModal({
    required this.searchTextController,
    this.onToggleView,
    super.key,
  });

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  List<int> selectedSubCategories = [];
  int selectedCityId = 0;
  String selectedType = 'office';
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    sl<CityCubit>().eitherFailureOrSuccess();
  }

  void applyFilter() {
    final filterCubit = sl<FilterCubit>();
    filterCubit.filterCompanies(
      subCategories: selectedSubCategories,
      cityId: selectedCityId,
      type: selectedType,
      searchText: widget.searchTextController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // handle - top bar
            Container(width: 40, height: 4, color: Colors.grey[600]),
            const SizedBox(height: 12),
            // filters: provider type
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "مقدم الخدمة",
                    style:  GoogleFonts.cairo(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Spacer(),
                  ToggleButtons(
                    isSelected: [
                      selectedType == 'office',
                      selectedType == 'individual',
                    ],
                    onPressed: (index) {
                      setState(() {
                        selectedType = (index == 0) ? 'office' : 'individual';
                      });
                    },
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("المكاتب الهندسية",style: GoogleFonts.cairo(),),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("الأفراد",style: GoogleFonts.cairo(),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return CircularProgressIndicator();
                }
                if (state is CategoryFailure) {
                  return Text('خطأ في تحميل الخدمات');
                }
                if (state is CategorySuccess) {
                  final services = state.categoryModel.data ?? [];
                  return Wrap(
                    spacing: 8,
                    children: services.map((s) {
                      final id = s.id!;
                      final selected = selectedSubCategories.contains(id);
                      return ChoiceChip(
                        label: Text(s.name ?? ''),
                        selected: selected,
                        onSelected: (v) {
                          setState(() {
                            if (v) {
                              selectedSubCategories.add(id);
                            } else {
                              selectedSubCategories.remove(id);
                            }
                          });
                        },
                      );
                    }).toList(),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
            buildCityBlocProvider(),

            const SizedBox(height: 12),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color(0xff75A460))
                      ),
                        onPressed: applyFilter, child: Text('تطبيق',style: GoogleFonts.cairo(
                      color: Colors.white
                    ),)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedSubCategories.clear();
                        selectedCityId = 0;
                        selectedType = 'office';
                        widget.searchTextController.clear();
                      });
                    },
                    child: Text('مسح الكل',style: GoogleFonts.cairo(),),
                  ),
                ),
                Spacer(),
              ],
            ),

            const SizedBox(height: 12),
            BlocProvider(
              create: (_) => sl<FilterCubit>(),
              child: Expanded(
                child: BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    if (state is FilterInitial) {
                      return Center(child: Text('اضغط تطبيق لبدء البحث',style: GoogleFonts.cairo(),),);
                    }
                    if (state is FilterLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is FilterFailure) {
                      return Center(child: Text('حدث خطأ: ${state.message}'));
                    }
                    if (state is FilterSuccess) {
                      final model = state.model;
                      final items = model.data?.data ?? [];
                      final pagination = model.data?.pagination;
                      if (items.isEmpty) {
                        return EmptySearchWidget(onRetry: applyFilter);
                      }

                      return FilterResultsListView(items: items, pagination: pagination, selectedSubCategories: selectedSubCategories, selectedCityId: selectedCityId, selectedType: selectedType, widget: widget, isGrid: isGrid);
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocProvider<CityCubit> buildCityBlocProvider() {
    return BlocProvider(
            create: (_) => sl<CityCubit>()..eitherFailureOrSuccess(),
            child: BlocBuilder<CityCubit, CityState>(
              builder: (context, state) {
                if (state is CityLoading) return CircularProgressIndicator();
                if (state is CityFailure) return Text('خطأ في تحميل المدن',style: GoogleFonts.cairo(),);
                if (state is CitySuccess) {
                  final cities = state.cityModel.data ?? [];
                  return DropdownButtonFormField<int>(
                    decoration: InputDecoration(labelText: 'المدينة'),
                    value: selectedCityId == 0 && cities.isNotEmpty
                        ? cities.first.id
                        : (selectedCityId == 0 ? null : selectedCityId),
                    items: cities
                        .map(
                          (c) => DropdownMenuItem<int>(
                        value: c.id!,
                        child: Text(c.name ?? '',style: GoogleFonts.cairo(),),
                      ),
                    )
                        .toList(),
                    onChanged: (v) => setState(() => selectedCityId = v ?? 0),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          );
  }
}

