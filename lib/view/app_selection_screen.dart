import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/res/component/app_selection_card.dart';
import 'package:rest_api_project/res/route/route_names.dart';

class AppSelectionScreen extends StatelessWidget {
  const AppSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select App'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppSelectionCard(
                title: 'Ecommerce App',
                color: Colors.amber,
                description:
                    'Discover the latest fashion trends with our eCommerce app, where a wide range of stylish clothes is available at your fingertips.',
                imageUrl: 'lottie/ecommerce_lottie.json',
                onTap: () {
                  Get.toNamed(RoutesName.homeEcommercePage);
                }),
            SizedBox(
              height: 10,
            ),
            CustomAppSelectionCard(
                title: 'News App',
                color: Colors.lightBlue,
                description:
                    'Discover the latest news trends with our News app, where a wide category of news available at your fingertips.',
                imageUrl: 'lottie/news_lottie.json',
                onTap: () {
                  Get.toNamed(RoutesName.homeNewsPage);
                }),
            SizedBox(
              height: 10,
            ),
            CustomAppSelectionCard(
                title: 'Dictionary App',
                color: Colors.lightGreen,
                description:
                    'A simple and fast dictionary app that provides word meanings, synonyms, antonyms, pronunciations, and examples instantly.',
                imageUrl: 'lottie/dictionary_lottie.json',
                onTap: () {
                  Get.toNamed(RoutesName.homeDictionaryPage);
                }),
            SizedBox(
              height: 10,
            ),
            CustomAppSelectionCard(
                title: 'Weather App',
                color: Colors.deepPurpleAccent,
                description:
                    'Get real-time weather updates, forecasts, and alerts for your location. Stay prepared with accurate temperature, humidity, and wind details.',
                imageUrl: 'lottie/weather_lottie.json',
                onTap: () {
                  Get.toNamed(RoutesName.homeWeatherPage);
                }),
            SizedBox(
              height: 10,
            ),
            CustomAppSelectionCard(
                title: 'Employee Detail App',
                color: Colors.orangeAccent,
                description:
                    'Easily access and manage employee profiles, including roles, contact information, and work details. Keep track of your workforce efficiently in one place.',
                imageUrl: 'lottie/employee_app_lottie.json',
                onTap: () {
                  Get.toNamed(RoutesName.homeEmployeePage);
                }),
          ],
        ),
      ),
    );
  }
}
