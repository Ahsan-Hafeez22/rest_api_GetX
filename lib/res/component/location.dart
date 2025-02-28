import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  static Future<Map<String, String>?> determinePosition() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      // Request permission if not granted
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          log('Location permission denied.');
          Get.snackbar(
            "Permission Denied",
            "Please enable location permissions in settings.",
            snackPosition: SnackPosition.BOTTOM,
          );
          return null;
        }
      }

      // Fetch current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      Get.snackbar(
        "Location Retrieved",
        "Your current location: ${position.latitude}, ${position.longitude}",
        snackPosition: SnackPosition.BOTTOM,
      );

      return {
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
      };
    } catch (e) {
      log("Error getting location: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch location.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }
}
