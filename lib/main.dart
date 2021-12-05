import 'package:fairpay/Screens/BookingDeatils.dart';
import 'package:fairpay/Screens/ThanksForBooking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'Screens/MakePrediction.dart';
import 'Screens/PredictionPage.dart';
import 'Screens/BookFlight.dart';
import 'Screens/HomePage.dart';
import 'Screens/BookingDeatils.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => Home()),
        GetPage(name: '/makePredict', page: () => MakePrediction()),
        GetPage(name: '/predict', page: () => Prediction()),
        GetPage(name: '/book', page: () => BookFlight()),
        GetPage(name: '/details', page: () => BookingDetail()),
        GetPage(name: '/passenger', page: () => PassengerDetails()),
      ],
    );
  }
}
