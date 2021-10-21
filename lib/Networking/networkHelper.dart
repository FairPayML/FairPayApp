import 'dart:convert';
import 'package:dio/dio.dart';
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
        'https://fairpay517.herokuapp.com/predict?Dep_time=${deptDate}T${deptTime}'
            '&Arrival_Time=${arvDate}T${arvTime}&airline=${airlines}&Source=${source}'
            '&Destination=${destination}&stops=$stops'));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
  Future getAccessToken()async{
    var res=await http.post(Uri.parse(
        "https://test.api.amadeus.com/v1/security/oauth2/token"),
        body: {
          "client_id":"rZwzUHHCfe6yZ5GW7XHXU0yRXaZOGXm4",
          "client_secret":"1H9uz3aM9qBNxUeH",
          "grant_type":"client_credentials"
        },
        headers: {
          "Content-Type":"application/x-www-form-urlencoded"
        }
    );
    if (res.statusCode == 200) {
      String data = res.body;
      return jsonDecode(data);
    } else {
      print("error in getting access token");
      print(res.statusCode);
    }
  }
}
