import 'package:fairpay/Model/FlightModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({Key? key}) : super(key: key);

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    FlightModel flight = arg[0];
    List<FlightModel> flights = arg[1];
    String noPass = arg[2];
    int noFlight = arg[3];
    String trvlClass = arg[4];
    int noAdult = arg[5];
    int noChild = arg[6];
    int noInfants = arg[7];
    return WillPopScope(
      onWillPop: () {
        Get.toNamed('/book', arguments: [
          flight.dept.toString(),
          flight.dest.toString(),
          trvlClass,
          noPass,
          noFlight,
          flights,
          flight.deptName,
          flight.destName,
          noAdult,
          noChild,
          noInfants
        ]);
        return Future(() => false);
      },
      child: Scaffold(
          backgroundColor: Color(0xffF8FAFD),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Color(0xffF8FAFD),
            title: Text(
              'BOOKING SUMMARY',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff022541)),
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '${flight.dept}',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffDAA210)),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset('images/flighticon.png'),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        '${flight.dest}',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff4F755B)),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      BookingDetails(
                          title: 'Departure Name', detail: flight.deptName),
                      SizedBox(height: 10),
                      BookingDetails(
                          title: 'Destination City', detail: flight.destName),
                      SizedBox(height: 10),
                      BookingDetails(title: 'Total Passenger', detail: noPass),
                      SizedBox(height: 10),
                      BookingDetails(
                          title: 'Departure Date', detail: flight.deptDate),
                      SizedBox(height: 10),
                      BookingDetails(
                          title: 'Destiantion Date', detail: flight.destDate),
                      SizedBox(height: 10),
                      BookingDetails(
                          title: 'Departure Time', detail: flight.deptTime),
                      SizedBox(height: 10),
                      BookingDetails(
                          title: 'Dastination Time', detail: flight.destTime),
                      SizedBox(height: 10),
                      BookingDetails(title: 'Airline', detail: flight.airline),
                      SizedBox(height: 10),
                      BookingDetails(
                          title: 'Price', detail: 'Rs. ${flight.price}'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/passenger',
                        arguments: [noAdult, noChild, noInfants]);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color(0xffDAA210),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      'Fill Passenger Details',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Color(0xff022541),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class BookingDetails extends StatelessWidget {
  const BookingDetails({required this.detail, required this.title});
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('$title',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff4F755B))),
        ),
        Expanded(
          child: Text('$detail',
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffDAA210))),
        ),
      ],
    );
  }
}
