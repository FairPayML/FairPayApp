import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FlightWidget extends StatelessWidget {
  const FlightWidget({
    Key? key,
    required this.arg,
    required this.stops,
    required this.predictedPrice,
  }) : super(key: key);

  final arg;
  final String stops;
  final double predictedPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '${arg[0]}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffDAA210)),
                  ),
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/line.png'),
                  Image.asset('images/plane.png')
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  '${arg[1]}',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4F755B)),
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${arg[4]}',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffDAA210)),
                ),
              ),
              Expanded(
                child: Text(
                  '${arg[5]}',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4F755B)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${arg[6]}',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Color(0xffDAA210)),
                ),
              ),
              Expanded(
                child: Text(
                  '${stops}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2F80ED)),
                ),
              ),
              Expanded(
                child: Text(
                  '${arg[7]}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4F755B)),
                ),
              ),
            ],
          ),
          Text(
            'Price Is $predictedPrice',
          ),
        ],
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  final String title;
  final String detail;

  const DetailWidget({required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
        children:[
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xff4F755B))
              ),
            ),

          Text(detail,
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color:Color(0xffDAA210))
           ),
        ]
    );
  }
}

class PricePredicted extends StatelessWidget {
  final String title;
  final String detail;

  const PricePredicted({required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
        children:[
          Expanded(
            child: Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff4F755B))
            ),
          ),

          Text('Rs. $detail',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color:Color(0xff2F80ED))
          ),
        ]
    );
  }
}


