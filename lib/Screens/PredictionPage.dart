import 'package:flutter/material.dart';
import 'package:fairpay/Networking/networkHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:get/get.dart';

class Prediction extends StatefulWidget {
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  var price;
  Future<dynamic> predictPrice(
      String source,
      String destination,
      String airlines,
      String stops,
      String deptDate,
      String arvDate,
      String deptTime,
      String arvTime) async {
    NetworkHelper networkHelper = NetworkHelper();
    price = await networkHelper.predicts(source, destination, airlines, stops,
        deptDate, arvDate, deptTime, arvTime);
    print(price);
    return price;
  }

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    return Scaffold(
      body: SafeArea(
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
              if (snapshot.hasError) {
                return Container(
                  child: Text('Error Occured'),
                );
              } else {
                double predictedPrice = double.parse(price['response']);
                predictedPrice = (predictedPrice * 100).round() / 100.0;
                String stops = '';
                if (arg[3].toString() == 'Non-Stop')
                  stops = 'Non-Stop';
                else if (arg[3].toString() == '1')
                  stops = '1 stop';
                else
                  stops = '${arg[3]} stops';
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
                              textAlign: TextAlign.right,
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
          },
          future: predictPrice(
              arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7]),
        ),
      ),
    );
  }
}
