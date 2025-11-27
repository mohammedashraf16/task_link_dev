import 'package:flutter/material.dart';
import 'package:task_link_dev/core/database/cache/cache_helper.dart';
import 'package:task_link_dev/core/services/get_it_service.dart';
import 'package:task_link_dev/features/home/presentation/views/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
