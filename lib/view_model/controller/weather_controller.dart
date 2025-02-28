import 'dart:developer';

import 'package:get/get.dart';
import 'package:rest_api_project/data/repository/weather_repo/home_repository_weather.dart';
import 'package:rest_api_project/data/response/status.dart';
import 'package:rest_api_project/model/weather_model.dart';

class WeatherController extends GetxController {
  HomeRepositoryWeather hm = HomeRepositoryWeather();
  RxString error = "".obs;
  final rxWeatherResponse = Rx<WeatherModel?>(null);
  final rxRequestStatus = Status.LOADING.obs;

  void setRxError(String errorMessage) => error.value = errorMessage;
  void setRxRequestStatus(Status status) => rxRequestStatus.value = status;
  void setRxWeatherResponse(WeatherModel response) =>
      rxWeatherResponse.value = response;

  void fetchWeather(String lat, String lon) {
    setRxRequestStatus(Status.LOADING);
    hm.fetchWeatherApi(lat, lon).then(
      (response) {
        setRxWeatherResponse(response);
        setRxRequestStatus(Status.COMPLETED);
      },
    ).onError(
      (error, stackTrace) {
        log(error.toString());
        log(stackTrace.toString());
        setRxRequestStatus(Status.ERROR);
        setRxError(error.toString());
      },
    );
  }
}
