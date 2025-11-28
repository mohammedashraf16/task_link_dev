import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/category_cubit.dart';

class GetCategoryBlocConsumer extends StatelessWidget {
  final bool isGrid;
  final TextEditingController searchController;

  const GetCategoryBlocConsumer({
    super.key,
    required this.isGrid,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategorySuccess) {
          final items = state.categoryModel.data ?? [];

          if (items.isEmpty) {
            return Center(
              child: Text(
                "لا توجد بيانات متاحة",
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          // === GRID VIEW ===
          if (isGrid) {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildCategoryCard(item);
              },
            );
          }

          // === LIST VIEW ===
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildCategoryListItem(item),
              );
            },
          );
        }

        if (state is CategoryFailure) {
          return Center(
            child: Text(
              "حدث خطأ أثناء تحميل البيانات",
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // ================ CARD FOR GRID VIEW ================
  Widget _buildCategoryCard(item) {
    return Card(
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: item.img ?? "",
            height: 40,
            width: 40,
            placeholder: (context, url) =>
            const CircularProgressIndicator(strokeWidth: 2),
            errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      item.name ?? "لا يوجد اسم",
                      maxLines: 2,
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Image.asset("assets/images/fav.png", height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================ ROW FOR LIST VIEW ================
  Widget _buildCategoryListItem(item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: item.img ?? "",
            height: 50,
            width: 50,
            placeholder: (context, url) =>
            const CircularProgressIndicator(strokeWidth: 2),
            errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.name ?? "لا يوجد اسم",
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Image.asset("assets/images/fav.png", height: 28),
        ],
      ),
    );
  }
}
