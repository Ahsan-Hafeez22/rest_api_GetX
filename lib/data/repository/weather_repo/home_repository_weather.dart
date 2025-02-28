import 'dart:developer';

import 'package:rest_api_project/data/network/network_api_service.dart';
import 'package:rest_api_project/model/weather_model.dart';
import 'package:rest_api_project/res/url/app_urls.dart';

class HomeRepositoryWeather {
  final _apiService = NetworkApiService();

  Future<WeatherModel> fetchWeatherApi(String lat, String long) async {
    final url = AppUrls.weatherUrl(lat, long);
    log('Url => $url');
    try {
      final response = await _apiService.getApi(url);
      // log(response.toString());
      if (response is Map<String, dynamic>) {
        return WeatherModel.fromJson(response);
      } else {
        throw Exception('Something went wrong while fetching weather');
      }
    } catch (e) {
      throw Exception("Error fetching News: $e");
    }
  }
}
