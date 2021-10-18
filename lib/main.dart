import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'Screens/LoginPage.dart';
import 'Screens/SignupPage.dart';
import 'Screens/HomePage.dart';
import 'Screens/PredictionPage.dart';
import 'Screens/BookFlight.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/', page: () => Login()),
        GetPage(name: '/signup', page: () => Signup()),
        GetPage(name: '/home', page: () => Home()),
        GetPage(name: '/predict', page: () => Prediction()),
        GetPage(name: '/book', page: ()=> BookFlight())
      ],
    );
  }
}
