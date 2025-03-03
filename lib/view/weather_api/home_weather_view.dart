import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/weather_model.dart';
import 'package:rest_api_project/res/component/location.dart';
import 'package:rest_api_project/view_model/controller/weather_controller.dart';

class HomeWeatherView extends StatefulWidget {
  const HomeWeatherView({super.key});

  @override
  State<HomeWeatherView> createState() => _HomeWeatherViewState();
}

class _HomeWeatherViewState extends State<HomeWeatherView> {
  WeatherController wc = Get.put(WeatherController());

  @override
  void initState() {
    fetchUserLocation();
    super.initState();
  }

  void fetchUserLocation() async {
    Map<String, String>? location = await LocationService.determinePosition();

    if (location != null) {
      log("User Location: ${location['latitude']}, ${location['longitude']}");
      wc.fetchWeather(location['latitude']!, location['longitude']!);
    } else {
      log("Failed to retrieve location.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Obx(() {
        switch (wc.rxRequestStatus.value) {
          case Status.LOADING:
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          case Status.COMPLETED:
            return WeatherDetail(weather: wc.rxWeatherResponse.value!);
          case Status.ERROR:
            return Center(
              child: Text(
                'Error: ${wc.error.value}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
        }
      }),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final WeatherModel weather;
  const WeatherDetail({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    double celciusTemp = (weather.main.temp - 273.15);
    double feelsLikeTemp = (weather.main.feelsLike - 273.15);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(weather.name,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 10),
          Text('${celciusTemp.toStringAsFixed(1)}°C',
              style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 10),
          Text(weather.weather[0].description.toUpperCase(),
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherInfo(
                  icon: Icons.thermostat,
                  label: 'Feels Like',
                  value: '${feelsLikeTemp.toStringAsFixed(1)}°C'),
              WeatherInfo(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '${weather.main.humidity}%'),
              WeatherInfo(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '${weather.wind.speed.toStringAsFixed(1)} m/s'),
            ],
          ),
          const SizedBox(height: 20),
          Text(formattedDate,
              style: const TextStyle(fontSize: 18, color: Colors.white)),
          Text(formattedTime,
              style: const TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherInfo(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
        Text(value,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }
}
