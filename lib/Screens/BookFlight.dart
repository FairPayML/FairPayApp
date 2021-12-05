import 'package:fairpay/Model/FlightModel.dart';
import 'package:get/get.dart';
import 'package:fairpay/Widget/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookFlight extends StatefulWidget {
  @override
  _BookFlightState createState() => _BookFlightState();
}

class _BookFlightState extends State<BookFlight>
    with SingleTickerProviderStateMixin {
  String selectAirline = ' ';
  String selectedPrice = ' ';
  int selectIndex = -1;
  late List<FlightModel> flights;
  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    String deptAirport = arg[0].toString();
    String destAirport = arg[1].toString();
    String trvlClass = arg[2];
    String noPass = arg[3].toString();
    String deptName = arg[6].toString();
    String destName = arg[7].toString();
    int noFlight = arg[4];
    flights = arg[5];
    int noAdult = arg[8];
    int noChild = arg[9];
    int noInfants = arg[10];
    return WillPopScope(
      onWillPop: () {
        Get.toNamed('/home');
        return Future(() => false);
      },
      child: Scaffold(
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
                            '$deptAirport',
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
                            '$destAirport',
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
            Column(
              children: [
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '$trvlClass Class,$noPass',
                        style: GoogleFonts.poppins(
                            color: Color(0xff022541),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: noFlight == 0
                        ? Container(
                            child: Image.asset('images/noflight.png'),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: flights.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/details', arguments: [
                                      flights[index],
                                      flights,
                                      noPass,
                                      noFlight,
                                      trvlClass,
                                      noAdult,
                                      noChild,
                                      noInfants
                                    ]);
                                  },
                                  child: FlightWidget(
                                      stops: flights[index].stops.toString(),
                                      price: double.parse(flights[index].price),
                                      dept: flights[index].dept,
                                      dest: flights[index].dest,
                                      deptDate: flights[index].deptDate,
                                      destDate: flights[index].destDate,
                                      destTime: flights[index].destTime,
                                      deptTime: flights[index].deptTime,
                                      airline: flights[index].airline,
                                      duration: flights[index].duration,
                                      deptName: deptName,
                                      destName: destName),
                                ),
                              );
                            }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
