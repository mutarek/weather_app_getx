import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxapicallingfinal/controllers/home_controller.dart';
import 'package:getxapicallingfinal/screen/MyHomePage.dart';
import 'package:getxapicallingfinal/translation/language.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  //final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Language(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('bn', 'BD'),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.white),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WeatherApp(),
    );
  }
}
