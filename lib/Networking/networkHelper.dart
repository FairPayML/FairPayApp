import 'dart:convert';
import 'package:fairpay/Model/FlightModel.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future predicts(
      String source,
      String destination,
      String airlines,
      String stops,
      String deptDate,
      String arvDate,
      String deptTime,
      String arvTime) async {
    if (stops == 'Non-Stop') stops = '0';
    http.Response response = await http.post(Uri.parse(
        'https://fairpay517.herokuapp.com/predict?Dep_time=${deptDate}T$deptTime'
        '&Arrival_Time=${arvDate}T$arvTime&airline=$airlines&Source=$source'
        '&Destination=$destination&stops=$stops'));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getAccessToken() async {
    var res = await http.post(
        Uri.parse("https://test.api.amadeus.com/v1/security/oauth2/token"),
        body: {
          "client_id": "rZwzUHHCfe6yZ5GW7XHXU0yRXaZOGXm4",
          "client_secret": "1H9uz3aM9qBNxUeH",
          "grant_type": "client_credentials"
        },
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        });
    if (res.statusCode == 200) {
      String data = res.body;
      return jsonDecode(data);
    } else {
      print("error in getting access token");
      print(res.statusCode);
    }
  }
}

void getData(String dept, String dest, String deptDate, int noAdult,
    int noChild, int noInfants, String travelClass) async {
  var data;
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
  List<FlightModel> flight = [];
  if (noFlight > 0) {
    final List flights = data['data'];
    flight = flights
        .map((json) =>
            FlightModel.fromJson(json, dept, dest, deptAirport, destAirport))
        .toList();
  }
  Get.toNamed('/book', arguments: [
    deptAirport,
    destAirport,
    travelClass,
    noPass,
    noFlight,
    flight,
    dept,
    dest,
    noAdult,
    noChild,
    noInfants
  ]);
}
