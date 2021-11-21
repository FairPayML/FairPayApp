import 'package:get/get.dart';
import 'package:fairpay/Widget/ConstantWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class BookFlight extends StatefulWidget {
  @override
  _BookFlightState createState() => _BookFlightState();
}

class _BookFlightState extends State<BookFlight> {
  Future<dynamic> getData() async {
    return 1;
  }

  bool isVisible = false;
  String selectAirline = ' ';
  String selectedPrice = ' ';
  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    String deptAirport = arg[0];
    String destAirport = arg[1];
    String trvlClass = arg[2];
    String noPass = arg[3];
    int noFlight = arg[4];
    var data = arg[5];
    print('data value ${data['meta']['count']}');
    return WillPopScope(
      onWillPop: () {
        if (isVisible == false)
          Get.toNamed('/home');
        else
          setState(() {
            isVisible = !isVisible;
          });

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
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 230,
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
                        if (snapshot.hasError || data == null) {
                          return Container(
                            child: Text('Error Occured'),
                          );
                        } else {
                          if (noFlight == 0) {
                            return Center(
                                child: Image.asset(
                              'images/noflight.png',
                              fit: BoxFit.fitWidth,
                            ));
                          } else {
                            return ListView.builder(
                                padding: EdgeInsets.all(5),
                                itemCount: noFlight,
                                itemBuilder: (context, index) {
                                  String price =
                                      data['data'][index]['price']['total'];
                                  String carrierCode = data['data'][0]
                                          ['itineraries'][0]['segments'][0]
                                      ['carrierCode'];
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
                                  String deptTime = deptDateTime[1]
                                      .toString()
                                      .substring(0, 5);
                                  var destDateTime = data['data'][index]
                                              ['itineraries'][0]['segments'][0]
                                          ['arrival']['at']
                                      .toString()
                                      .split('T');
                                  String destDate = destDateTime[0].toString();
                                  String destTime = destDateTime[1]
                                      .toString()
                                      .substring(0, 5);
                                  String stops = data['data'][index]
                                              ['itineraries'][0]['segments'][0]
                                          ['numberOfStops']
                                      .toString();
                                  if (stops == '0') {
                                    stops = 'Non-Stop';
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      // print('ticket Page');
                                      if (selectIndex != index) {
                                        setState(() {
                                          if (isVisible == false)
                                            isVisible = !isVisible;
                                          selectedPrice = price;
                                          selectAirline = airline;
                                          selectIndex = index;
                                        });
                                      } else {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      }
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
                    future: getData(),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Visibility(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$selectAirline',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffDAA210),
                            fontSize: 20),
                      ),
                      Text('Rs. $selectedPrice',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff4F755B),
                              fontSize: 20)),
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/details', arguments: [
                              deptAirport,
                              destAirport,
                              trvlClass,
                              noPass,
                              noFlight,
                              data,
                              data['data'][selectIndex]
                            ]);
                          },
                          child: Text('BOOK',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2F80ED),
                                  fontSize: 20)))
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Color(0xffF8FAFD),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                ),
                visible: isVisible,
                maintainState: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
