import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_link_dev/core/database/cache/cache_helper.dart';
import 'package:task_link_dev/core/services/get_it_service.dart';
import 'package:task_link_dev/features/filter/presentation/manager/cubit/filter_cubit.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/category_cubit.dart';
import 'package:task_link_dev/features/home/presentation/manager/cubit/city_cubit.dart';
import 'package:task_link_dev/features/home/presentation/views/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await sl<CacheHelper>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryCubit>(
          create: (_) => sl<CategoryCubit>()..eitherFailureOrSuccess(),
        ),
        BlocProvider<CityCubit>(
          create: (_) => sl<CityCubit>()..eitherFailureOrSuccess(),
        ),
        BlocProvider<FilterCubit>(
          create: (_) => sl<FilterCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Cairo",
        ),
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
