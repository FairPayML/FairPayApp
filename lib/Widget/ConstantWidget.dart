import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FlightWidget extends StatelessWidget {
  const FlightWidget({
    required this.stops,
    required this.predictedPrice,
    required this.dept,
    required this.dest,
    required this.deptDate,
    required this.destDate,
    required this.destTime,
    required this.deptTime,
  });

  final String stops;
  final String dept;
  final String dest;
  final String deptDate;
  final String destDate;
  final String destTime;
  final String deptTime;
  final double predictedPrice;

  @override
  Widget build(BuildContext context) {
    String stop = '';
    if (stops == 'Non-Stop')
      stop = 'Non-Stop';
    else if (stops == '1')
      stop = '1 stop';
    else
      stop = '$stops stops';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.green,width: 2)
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '$dept',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffDAA210)),
                ),
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
                  '$dest',

                  textAlign: TextAlign.right,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                  '$deptDate',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffDAA210)),
                ),
              ),
              Expanded(
                child: Text(
                  '$destDate',
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
                  '$deptTime',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Color(0xffDAA210)),
                ),
              ),
              Expanded(
                child: Text(
                  '$stop',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2F80ED)),
                ),
              ),
              Expanded(
                child: Text(
                  '$destTime',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4F755B)),
                ),
              ),
            ],
          ),
          Text(
            'Price Is Rs.$predictedPrice',
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

          Flexible(
            child: Text(detail,
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color:Color(0xffDAA210))
             ),
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

class AddPassenger extends StatelessWidget {
  const AddPassenger({
    required this.typePass,
    required this.addFunction,
    required this.subFunction
  });
  final int typePass;
  final addFunction;
  final subFunction;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap:addFunction,
          child: CircleAvatar(
            child: Icon(Icons.remove,color: Colors.black,),
            backgroundColor: Colors.grey,
          ),
        ),
        SizedBox(width: 5,),
        Text('$typePass',style: TextStyle(
            color: Colors.black,
            fontSize: 20
        ),),
        SizedBox(width: 5,),
        GestureDetector(
          onTap:subFunction,
          child: CircleAvatar(
            child: Icon(Icons.add,color: Colors.black,),
            backgroundColor: Colors.grey,
          ),
        )
      ],
    );
  }
}



