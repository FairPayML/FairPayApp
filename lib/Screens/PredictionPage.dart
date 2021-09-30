import 'package:flutter/material.dart';
import 'package:fairpay/Networking/networkHelper.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:get/get.dart';

class Prediction extends StatefulWidget {
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  var price;
  Future<dynamic> predictPrice(
      String source,
      String destination,
      String airlines,
      String stops,
      String deptDate,
      String arvDate,
      String deptTime,
      String arvTime) async {
    NetworkHelper networkHelper = NetworkHelper();
    price = await networkHelper.predicts(source, destination, airlines, stops,
        deptDate, arvDate, deptTime, arvTime);
    print(price);
    return price;
  }

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              if (snapshot.hasError) {
                return Container(
                  child: Text('Error Occured'),
                );
              } else {
                double predictedPrice = double.parse(price['response']);
                predictedPrice = (predictedPrice * 100).round() / 100.0;
                return Container(child: Text('Price Is $predictedPrice'));
              }
            }
          },
          future: predictPrice(
              arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7]),
        ),
      ),
    );
  }
}
