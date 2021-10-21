import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
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
  late FlightModel flightModel ;
  Future<dynamic> getData(String dept,String dest,String deptDate,int noPass,bool isNonStop)async{
    NetworkHelper networkHelper=NetworkHelper();
    var response=await networkHelper.getAccessToken();
    String token= response["access_token"].toString();
    var res=await http.get(Uri.parse("https://test.api.amadeus.com/v2/shopping/flight-offers?"
        "originLocationCode=$dept&destinationLocationCode=$dest&departureDate=$deptDate"
        "&adults=$noPass&currencyCode=INR&nonStop=$isNonStop"),
        headers: {
            "Authorization":"Bearer $token"
          }
        );
      data = jsonDecode(res.body);
      print(data);
      return data;
  }
  @override
  Widget build(BuildContext context) {
    var arg=Get.arguments;
    bool isNonStop=false;
    String dept=arg[0].toString();
    String dest=arg[1].toString();
    String airlines=arg[2].toString();
    String stops=arg[3].toString();
    if(stops=='Non-Stop')
      isNonStop=true;
    String deptDate=arg[4].toString();
    String destDate=arg[5].toString();
    String destTime=arg[6].toString();
    String deptTime=arg[7].toString();
    double predictedPrice=double.parse(arg[8].toString());
    String deptAirport='';
    String destAirport='';
    if(dept=='Delhi')
      deptAirport='DEL';
    else if(dept=='Kolkata')
      deptAirport='CCU';
    else if(dept=='Mumbai')
      deptAirport='BOM';
    else
      deptAirport='MAA';

    if(dest=='Cochin')
      destAirport='COK';
    else if(dest=='Delhi')
      destAirport='DEL';
    else if(dest=='New Delhi')
      destAirport='DEL';
    else if(dest=='Hyderabad')
      destAirport='HYD';
    else
      destAirport='CCU';

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
                    child: ListView.builder(
                        padding: EdgeInsets.all(5),
                        itemCount:data["meta"]["count"],
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
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
                     }
                    ),
                  );
                }
              }
            },
          future: getData(deptAirport, destAirport, deptDate, 1,isNonStop),
        ),
      ),
    );
  }
}
