import 'package:fairpay/Networking/networkHelper.dart';
import 'package:flutter/material.dart';

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
