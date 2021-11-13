import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fairpay/Networking/networkHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatefulWidget {
  final String? dept;
  final String? dest;
  final String departureDate;
  final String trvlClass;
  final int noAdult;
  final int noChild;
  final int noInfants;

  const LoadingScreen(
      {required this.dept,
      required this.dest,
      required this.departureDate,
      required this.trvlClass,
      required this.noAdult,
      required this.noChild,
      required this.noInfants});
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData(
        widget.dept.toString(),
        widget.dest.toString(),
        widget.departureDate,
        widget.noAdult,
        widget.noChild,
        widget.noInfants,
        widget.trvlClass);
  }

  var data;
  void getData(String dept, String dest, String deptDate, int noAdult,
      int noChild, int noInfants, String travelClass) async {
    String noPass = '';
    print(deptDate);
    if (noAdult > 0) noPass = noPass + '$noAdult Adult ';
    if (noChild > 0) noPass = noPass + '$noChild Child ';
    if (noInfants > 0) noPass = noPass + '$noInfants Baby ';
    String deptAirport = '';
    String destAirport = '';
    if (dept == 'Delhi')
      deptAirport = 'DEL';
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
    NetworkHelper networkHelper = NetworkHelper();
    var response = await networkHelper.getAccessToken();
    String token = response["access_token"].toString();
    var res = await http.get(
        Uri.parse("https://test.api.amadeus.com/v2/shopping/flight-offers?"
            "originLocationCode=$deptAirport&destinationLocationCode=$destAirport&departureDate=$deptDate"
            "&adults=$noAdult&children=$noChild&infants=$noInfants&currencyCode=INR&travelClass=$travelClass"),
        headers: {"Authorization": "Bearer $token"});
    data = jsonDecode(res.body);
    int noFlight = data["meta"]["count"];

    print('Number of Flight $noFlight');
    Get.toNamed('/book', arguments: [
      deptAirport,
      destAirport,
      travelClass,
      noPass,
      noFlight,
      data
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xff468A62),
        ),
      ),
    );
  }
}
