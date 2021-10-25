import 'package:flutter/material.dart';
import 'package:fairpay/Networking/networkHelper.dart';
import 'package:intl/intl.dart';
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
  String arvDate='';
  String arvTime='';
  Future<dynamic> predictPrice(
      String source,
      String destination,
      String airlines,
      String stops,
      DateTime departureDate,
      TimeOfDay departureTime,
      String deptDate,
      String deptTime) async {
    int hr=0,min=0;
    DateTime arrivalDate = DateTime.now();
    TimeOfDay arrivalTime = TimeOfDay.now();
    if(source=='Delhi' && destination=='Cochin') {
      min=15;
      if(stops=='Non-Stop')
        hr=3;
      if(stops=='1')
        hr=5;
      else
        hr=15;
    }
    if(source=='Delhi' && destination=='Hyderabad'){
      min=30;
      if(stops=='Non-Stop')
        hr=2;
      if(stops=='1')
        hr=6;
      else
        hr=9;
    }
    if(source=='Delhi' && destination=='Kolkata'){
      if(stops=='Non-Stop')
        hr=2;
      if(stops=='1')
        hr=24;
      else
        hr=28;
    }
    if(source=='Bangalore' && destination=='Cochin'){
      min=15;
      if(stops=='Non-Stop')
        hr=24;
      if(stops=='1')
        hr=28;
      else
        hr=31;
    }
    if(source=='Bangalore' && destination=='Hyderabad'){
      min=30;
      if(stops=='Non-Stop')
        hr=1;
      if(stops=='1')
        hr=3;
      else
        hr=8;
    }
    if(source=='Bangalore' && destination=='Kolkata'){
      min=45;
      if(stops=='Non-Stop')
        hr=2;
      if(stops=='1')
        hr=9;
      else
        hr=15;
    }
    if(source=='Mumbai' && destination=='Cochin'){
      min=15;
      if(stops=='Non-Stop')
        hr=2;
      if(stops=='1')
        hr=13;
      else
        hr=18;
    }
    if(source=='Mumbai' && destination=='Hyderabad'){
      min=24;
      if(stops=='Non-Stop')
        hr=1;
      if(stops=='1')
        hr=7;
      else
        hr=16;
    }
    if(source=='Mumbai' && destination=='Kolkata'){
      min=15;
      if(stops=='Non-Stop')
        hr=6;
      if(stops=='1')
        hr=10;
      else
        hr=17;
    }
    if(source=='Chennai' && destination=='Cochin'){
      min=15;
      if(stops=='Non-Stop')
        hr=12;
      if(stops=='1')
        hr=22;
      else
        hr=31;
    }
    if(source=='Chennai' && destination=='Hyderabad'){
      min=25;
      if(stops=='Non-Stop')
        hr=1;
      if(stops=='1')
        hr=3;
      else
        hr=5;
    }
    if(source=='Chennai' && destination=='Kolkata'){
      min=40;
      if(stops=='Non-Stop')
        hr=7;
      if(stops=='1')
        hr=11;
      else
        hr=15;
    }
    arrivalDate=departureDate.add(Duration(hours: departureDate.hour+departureTime.hour+hr,minutes: departureDate.minute+departureTime.minute));
    arrivalTime=TimeOfDay.fromDateTime(arrivalDate);
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    arvDate = DateFormat('yyyy-MM-dd').format(arrivalDate).toString();
    arvTime =
    localizations.formatTimeOfDay(arrivalTime, alwaysUse24HourFormat: true).toString();
    NetworkHelper networkHelper = NetworkHelper();
    price = await networkHelper.predicts(source, destination, airlines, stops,
        deptDate, arvDate, deptTime, arvTime);
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
                          DetailWidget(title: 'Departure Time',detail: arg[7],),
                          SizedBox(height: 10,),
                          DetailWidget(title: 'Departure Date',detail: arg[6],),
                        ],
                      ),
                      Column(
                        children: [
                          PricePredicted(title: 'Predicted Price',detail: predictedPrice.toString(),),
                          SizedBox(height: 20,),
                          ConfirmationSlider(
                              onConfirmation: (){
                                  Get.toNamed('/book',arguments: [
                                    arg[0],arg[1],arg[2],arg[3],arg[6],arg[7],arvDate,arvTime,predictedPrice
                                  ]);
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

