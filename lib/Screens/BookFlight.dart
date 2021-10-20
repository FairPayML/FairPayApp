import 'dart:convert';
import 'dart:io';

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
  late FlightModel flightModel ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData("DEL", "CCU", "2021-11-01", 1);
  }
  void getData(String dept,String dest,String deptDate,int noPass)async{
    NetworkHelper networkHelper=NetworkHelper();
    var response=await networkHelper.getAccessToken();
    String token= response["access_token"].toString();
    var res=await http.get(Uri.parse("https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=$dept&destinationLocationCode=$dest&departureDate=$deptDate&adults=$noPass&currencyCode=INR"),
        headers: {
            "Authorization":"Bearer $token"
          }
        );
    if (res.statusCode == 200) {
      String data = res.body;
      print(jsonDecode(data));
    } else {
      print("error in flight");
      print(res.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      SafeArea(
        child: FutureBuilder(
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
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
              }else{
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Container(
                    child: Text('Error Occured'),

                  );
                }else{
                  return Container(

                  );
                }
              }
            }
        ),
      ),
    );
  }
}
