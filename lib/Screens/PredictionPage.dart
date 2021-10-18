import 'package:flutter/material.dart';
import 'package:fairpay/Networking/networkHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import 'package:fairpay/Widget/ConstantWidget.dart';
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
                print(snapshot.error.toString());
                return Container(
                  child: Text('Error Occured'),

                );
              } else {
                double predictedPrice = double.parse(price['response']);
                predictedPrice = (predictedPrice * 100).round() / 100.0;
                String stops = '';
                if (arg[3].toString() == 'Non-Stop')
                  stops = 'Non-Stop';
                else if (arg[3].toString() == '1')
                  stops = '1 stop';
                else
                  stops = '${arg[3]} stops';
                return Container(
                  padding:EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          DetailWidget(title: 'Origin Place',detail: arg[0],),
                          SizedBox(height: 10,),
                          DetailWidget(title: 'Arrival Place',detail: arg[1],),
                          SizedBox(height: 10,),
                          DetailWidget(title: 'Airline',detail: arg[2],),
                          SizedBox(height: 10,),
                          DetailWidget(title: 'Stops',detail: stops,),
                          SizedBox(height: 10,),
                          DetailWidget(title: 'Departure Time',detail: arg[4],),
                          SizedBox(height: 10,),
                          DetailWidget(title: 'Arrival Time',detail: arg[5],),
                          SizedBox(height: 10,),
                          DetailWidget(title: 'Departure Date',detail: arg[6],),
                          SizedBox(height: 10,),
                          DetailWidget(title: 'Arrival Date',detail: arg[7],),
                        ],
                      ),
                      Column(
                        children: [
                          PricePredicted(title: 'Predicted Price',detail: predictedPrice.toString(),),
                          SizedBox(height: 20,),
                          ConfirmationSlider(
                              onConfirmation: (){
                                  Get.toNamed('/book');
                                },
                            backgroundColor: Color(0xffDAA210),
                            backgroundColorEnd: Colors.yellowAccent,
                            iconColor: Colors.yellowAccent,
                            foregroundColor: Colors.yellow,

                            text: "Slide to Book",
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
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

