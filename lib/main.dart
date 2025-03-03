import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/res/route/route_names.dart';
import 'package:rest_api_project/res/route/routes.dart';
// import 'package:rest_api_project/view/dictionary_api/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splashScreen, // Initial route
      getPages: AppRoutes.appRoutes(),
    );
  }
}
