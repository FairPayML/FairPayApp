import 'dart:convert';
import 'package:get/get.dart';
import 'package:fairpay/Widget/ConstantWidget.dart';
import 'package:fairpay/Model/FlightModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fairpay/Networking/networkHelper.dart';
import 'package:loading_indicator/loading_indicator.dart';

class BookFlight extends StatefulWidget {
  @override
  _BookFlightState createState() => _BookFlightState();
}

class _BookFlightState extends State<BookFlight> {
  var data;
  late FlightModel flightModel;
  Future<dynamic> getData(String dept, String dest, String deptDate, int noPass,
      bool isNonStop) async {
    NetworkHelper networkHelper = NetworkHelper();
    var response = await networkHelper.getAccessToken();
    String token = response["access_token"].toString();
    var res = await http.get(
        Uri.parse("https://test.api.amadeus.com/v2/shopping/flight-offers?"
            "originLocationCode=$dept&destinationLocationCode=$dest&departureDate=$deptDate"
            "&adults=$noPass&currencyCode=INR&nonStop=$isNonStop"),
        headers: {"Authorization": "Bearer $token"});
    data = jsonDecode(res.body);
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    bool isNonStop = false;
    String dept = arg[0].toString();
    String dest = arg[1].toString();
    String airlines = arg[2].toString();
    String deptDate = arg[4].toString();
    String destDate = arg[6].toString();
    String destTime = arg[7].toString();
    String deptTime = arg[5].toString();
    double predictedPrice = double.parse(arg[8].toString());
    String deptAirport = '';
    String destAirport = '';
    if (dept == 'Delhi')
      deptAirport = 'DEL';
    else if (dept == 'Bangalore')
      deptAirport = 'BLR';
    else if (dept == 'Kolkata')
      deptAirport = 'CCU';
    else if (dept == 'Mumbai')
      deptAirport = 'BOM';
    else
      deptAirport = 'MAA';

    if (dest == 'Cochin')
      destAirport = 'COK';
    else if (dest == 'Hyderabad')
      destAirport = 'HYD';
    else
      destAirport = 'CCU';

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
              if (snapshot.hasError || data['meta'] == null) {
                return Container(
                  child: Text('Error Occured'),
                );
              } else {
                if (data["meta"]["count"] == 0) {
                  return Center(
                      child: Image.asset(
                    'images/noflight.png',
                    fit: BoxFit.fitWidth,
                  ));
                } else {
                  return Container(
                    child: ListView.builder(
                        padding: EdgeInsets.all(5),
                        itemCount: data["meta"]["count"],
                        itemBuilder: (context, index) {
                          String stops = data["data"][index]['itineraries'][0]
                                  ["segments"][0]['numberOfStops']
                              .toString();
                          if (stops == '0') {
                            stops = 'Non-Stop';
                            isNonStop = true;
                          }
                          return GestureDetector(
                            onTap: () {
                              print(data["data"][index]);
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: FlightWidget(
                                  stops: stops,
                                  predictedPrice: predictedPrice,
                                  dept: deptAirport,
                                  dest: destAirport,
                                  deptDate: deptDate,
                                  destDate: destDate,
                                  destTime: destTime,
                                  deptTime: deptTime),
                            ),
                          );
                        }),
                  );
                }
              }
            }
          },
          future: getData(deptAirport, destAirport, deptDate, 1, isNonStop),
        ),
      ),
    );
  }
}
