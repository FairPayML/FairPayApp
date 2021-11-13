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
    print('details Page');
    var arg = Get.arguments;
    String deptAirport = arg[0];
    String destAirport = arg[1];
    String trvlClass = arg[2];
    String noPass = arg[3];
    int noFlight = arg[4];
    var data = arg[5];
    var detail = arg[6];
    return WillPopScope(
      onWillPop: () {
        Get.toNamed('/book', arguments: [
          deptAirport,
          destAirport,
          trvlClass,
          noPass,
          noFlight,
          data
        ]);
        return Future(() => false);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'BOOKING DETAILS',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff022541)),
            ),
          ),
          body: Container()),
    );
  }
}
