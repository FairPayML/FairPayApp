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
        'https://fairpay517.herokuapp.com/predict?Dep_time=${deptDate}T${deptTime}&Arrival_Time=${arvDate}T${arvTime}&airline=${airlines}&Source=${source}&Destination=${destination}&stops=$stops'));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
