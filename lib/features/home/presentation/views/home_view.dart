import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_link_dev/core/services/get_it_service.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/category_cubit.dart';
import 'package:task_link_dev/features/home/presentation/views/widgets/build_app_bar.dart';
import 'package:task_link_dev/features/home/presentation/views/widgets/get_category_bloc_consumer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryCubit>()..eitherFailureOrSuccess(),
      child: Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
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
                      textAlign: TextAlign.right,
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
                ],
              ),
            ),
            Expanded(child: GetCategoryBlocConsumer()),
          ],
        ),
      ),
    );
  }
}
