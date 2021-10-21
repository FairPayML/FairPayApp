import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class MakePrediction extends StatefulWidget {
  @override
  _MakePredictionState createState() => _MakePredictionState();
}

class _MakePredictionState extends State<MakePrediction> {
  String? _source;
  String? _destination;
  String? airlines;
  String? stops;
  DateTime departureDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();
  TimeOfDay departureTime = TimeOfDay.now();
  TimeOfDay arrivalTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context, int select) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: select == 1 ? DateTime.now() : departureDate,
        firstDate: select == 1 ? DateTime.now() : departureDate,
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != departureDate)
      setState(() {
        setState(() {
          if (select == 1)
            departureDate = pickedDate;
          else
            arrivalDate = pickedDate;
        });
      });
  }

  Future<void> _selectTime(BuildContext context, int select) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: select == 1 ? departureTime : arrivalTime,
    );
    if (pickedTime != null && pickedTime != departureTime) {
      setState(() {
        if (select == 1)
          departureTime = pickedTime;
        else
          arrivalTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String deptDate = DateFormat('yyyy-MM-dd').format(departureDate);
    String arvDate = DateFormat('yyyy-MM-dd').format(arrivalDate);
    String deptTime = localizations.formatTimeOfDay(departureTime,
        alwaysUse24HourFormat: true);
    String arvTime =
        localizations.formatTimeOfDay(arrivalTime, alwaysUse24HourFormat: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin:
                  EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Color(0xffB3BABF).withOpacity(0.5)),
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('images/planeup.png'),
                      Text(
                        'FROM',
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Color(0xff344655)),
                      )
                    ],
                  ),
                  DropdownButton(
                    hint: Text(
                      'Select Your Origin',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 12),
                    ),
                    value: _source,
                    items: <String>[
                      'Delhi',
                      'Kolkata',
                      'Mumbai',
                      'Chennai'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        _source = val;
                      });
                    },
                    elevation: 2,
                  ),
                  Row(
                    children: [
                      Image.asset('images/planedown.png'),
                      Text(
                        'TO',
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Color(0xff344655)),
                      ),
                    ],
                  ),
                  DropdownButton(
                    hint: Text('Select Your Destination',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 12)),
                    value: _destination,
                    items: <String>[
                      'Cochin',
                      'Delhi',
                      'New Delhi',
                      'Hyderabad',
                      'Kolkata'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        _destination = val;
                      });
                    },
                    elevation: 2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: <Widget>[
                    Text(
                      'Departure Date',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context, 1);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('images/calendar.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text('$deptDate')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Departure Time',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, 1);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.timer),
                          SizedBox(
                            width: 5,
                          ),
                          Text('$deptTime')
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Arrival Date',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context, 2);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('images/calendar.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text('$arvDate')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Arrival Time',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, 2);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.timer),
                          SizedBox(
                            width: 5,
                          ),
                          Text('$arvTime')
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Air Lines',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton(
              hint: Text(
                'Choose an airline',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 9),
              ),
              value: airlines,
              items: <String>[
                'JetAirways',
                'IndiGo',
                'Air India',
                'Multiple Carriers',
                'SpiceJet',
                'Vistara',
                'Air Asia',
                'GoAir',
                'Multiple carriers Premium economy',
                'JetAirways Business',
                'Vistara Premium economy',
                'Trujet'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? val) {
                setState(() {
                  airlines = val;
                });
              },
              elevation: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'No. of Stops',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton(
              hint: Text(
                'Choose No. of Stops',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 9),
              ),
              value: stops,
              items: <String>['Non-Stop', '1', '2', '3', '4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? val) {
                setState(() {
                  stops = val;
                });
              },
              elevation: 2,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                print(stops);
                if (_source != null &&
                    _destination != null &&
                    airlines != null &&
                    stops != null &&
                    deptDate != null &&
                    arvDate != null &&
                    deptTime != null &&
                    arvTime != null)
                  Get.toNamed('/predict', arguments: [
                    _source,
                    _destination,
                    airlines,
                    stops,
                    deptDate,
                    arvDate,
                    deptTime,
                    arvTime
                  ]);
                else
                  Get.snackbar('Field is Empty',
                      'All Fields are Mandatory to fill',
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      backgroundColor: Color(0xff468A62));
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Color(0xffDAA210)),
                  width: MediaQuery.of(context).size.width,
                  child: Text('Check The Price',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }
}
