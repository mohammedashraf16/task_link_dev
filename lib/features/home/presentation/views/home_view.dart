import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_link_dev/core/services/get_it_service.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/company_item.dart';
import 'package:task_link_dev/features/filter/data/models/sub_models/pagination_model.dart';
import 'package:task_link_dev/features/filter/presentation/manager/cubit/filter_cubit.dart';
import 'package:task_link_dev/features/filter/presentation/views/widgets/filter_modal.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/category_cubit.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/city_cubit.dart';
import 'package:task_link_dev/features/home/presentation/views/widgets/build_app_bar.dart';
import 'package:task_link_dev/features/home/presentation/views/widgets/get_category_bloc_consumer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  bool isGrid = true;

  void openFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (_, controller) => FilterModal(
          searchTextController: _searchController,
          onToggleView: (value) => setState(() => isGrid = value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryCubit>()..eitherFailureOrSuccess(),
      child: Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: openFilterModal,
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: const ShapeDecoration(
                        color: Color(0xff4C4F54),
                        shape: CircleBorder(),
                      ),
                      child: Image.asset("assets/images/filter.png"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      textAlign: TextAlign.right,
                      onSubmitted: (_) {
                        // open modal with results, or trigger search directly
                        openFilterModal();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffFBFBFB),
                        hintText: 'ابحث هنا عن فرد او شركة',
                        hintStyle: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        suffixIcon: Image.asset("assets/images/search.png"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // toggle icon quick access
                  IconButton(
                    icon: Icon(isGrid ? Icons.view_list : Icons.grid_view),
                    onPressed: () => setState(() => isGrid = !isGrid),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetCategoryBlocConsumer(
                // pass isGrid so result view can match layout
                isGrid: isGrid,
                searchController: _searchController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}






