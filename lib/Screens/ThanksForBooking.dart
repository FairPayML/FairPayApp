import 'dart:async';
import 'package:fairpay/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PassengerDetails extends StatefulWidget {
  const PassengerDetails({Key? key}) : super(key: key);

  @override
  _PassengerDetailsState createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/confirm.png'),
          Text(
            'Ticket Confirm',
            style: GoogleFonts.poppins(color: Color(0xff00C48C), fontSize: 20),
          )
        ],
      ),
    )));
  }
}
