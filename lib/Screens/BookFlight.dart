import 'dart:convert';
import 'package:get/get.dart';
import 'package:fairpay/Widget/ConstantWidget.dart';
import 'package:fairpay/Model/FlightModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Future<dynamic> getData(
      String dept,
      String dest,
      String deptDate,
      int noAdult,
      int noChild,
      int noInfants,
      bool isNonStop,
      String travelClass) async {
    NetworkHelper networkHelper = NetworkHelper();
    var response = await networkHelper.getAccessToken();
    String token = response["access_token"].toString();
    var res = await http.get(
        Uri.parse("https://test.api.amadeus.com/v2/shopping/flight-offers?"
            "originLocationCode=$dept&destinationLocationCode=$dest&departureDate=$deptDate"
            "&adults=$noAdult&children=$noChild&infants=$noInfants&currencyCode=INR&nonStop=$isNonStop&travelClass=$travelClass"),
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
    String departureDate = arg[4];
    String trvlClass = arg[8].toString();
    int noAdult = int.parse(arg[9].toString());
    int noChild = int.parse(arg[10].toString());
    int noInfants = int.parse(arg[11].toString());
    String noPass = '';
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

    return Scaffold(
      backgroundColor: Color(0xffF8FAFD),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xff468A62),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                image: DecorationImage(
                    image: ExactAssetImage('images/map.png'),
                    fit: BoxFit.cover)),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SELECT FLIGHTS',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'images/travelicon.png',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(right: 50),
                        child: Text(
                          deptAirport,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(left: 50),
                        child: Text(
                          destAirport,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 180, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                color: Colors.white,
                border: Border.all(color: Color(0xff707070))),
            width: MediaQuery.of(context).size.width,
            height: 48,
            child: Text(
              '$trvlClass Class,$noPass',
              style: GoogleFonts.poppins(
                  color: Color(0xff022541),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 230),
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
                  print("this is data $data");
                  if (snapshot.hasError ||
                      data['meta'] == null ||
                      data == null) {
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
                      return ListView.builder(
                          padding: EdgeInsets.all(5),
                          itemCount: data["meta"]["count"],
                          itemBuilder: (context, index) {
                            String price =
                                data['data'][index]['price']['total'];
                            String carrierCode = data['data'][index]
                                    ['itineraries'][0]['segments'][0]
                                ['operating']['carrierCode'];
                            String airline = ' ';
                            if (carrierCode == '9I')
                              airline = 'ALLIANCE AIR';
                            else if (carrierCode == 'UK')
                              airline = 'VISTARA';
                            else
                              airline = 'AIR INDIA';
                            var deptDateTime = data['data'][index]
                                        ['itineraries'][0]['segments'][0]
                                    ['departure']['at']
                                .toString()
                                .split('T');
                            String deptDate = deptDateTime[0].toString();
                            String deptTime =
                                deptDateTime[1].toString().substring(0, 5);
                            var destDateTime = data['data'][index]
                                        ['itineraries'][0]['segments'][0]
                                    ['arrival']['at']
                                .toString()
                                .split('T');
                            String destDate = destDateTime[0].toString();
                            String destTime =
                                destDateTime[1].toString().substring(0, 5);
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
                                    price: double.parse(price.toString()),
                                    dept: deptAirport,
                                    dest: destAirport,
                                    airline: airline,
                                    deptDate: deptDate,
                                    destDate: destDate,
                                    destTime: destTime,
                                    deptTime: deptTime),
                              ),
                            );
                          });
                    }
                  }
                }
              },
              future: getData(deptAirport, destAirport, departureDate, noAdult,
                  noChild, noInfants, isNonStop, trvlClass),
            ),
          ),
        ],
      ),
    );
  }
}
