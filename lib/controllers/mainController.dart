import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getxapicallingfinal/remote/api_client.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    await getUserLocation();
    currentWeatherData = ApiClient().getCurrentWeather(latitude.value, longitude.value);
    hourlyWeatherData = ApiClient().getHourlyWeather(latitude.value, longitude.value);
    super.onInit();
  }

  var isDark = false.obs;
  dynamic currentWeatherData;
  dynamic hourlyWeatherData;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isloaded = false.obs;
  var isBangla = false.obs;

  changeLanguage(){
    isBangla.value =! isBangla.value;
    Get.updateLocale(isBangla.value?Locale('bn,','BD'):Locale('en,','US'));
  }

  changeTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error("Location is not enabled");
    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      return Future.error("Permission is denied forever");
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      isloaded.value = true;
    });
  }
}
