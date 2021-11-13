import 'package:fairpay/Screens/LoadingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:fairpay/Widget/ConstantWidget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? _source;
  String? _destination;
  String? airlines;
  String? stops;
  DateTime departureDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();
  TimeOfDay departureTime = TimeOfDay.now();
  TimeOfDay arrivalTime = TimeOfDay.now();
  String flgCls = 'Economy';
  bool isNonStop = false;
  int _noPass = 0;
  int _noAdult = 0;
  int _noInfants = 0;
  int _noChild = 0;
  List<IconData> icons = [
    Icons.check_circle,
    Icons.radio_button_unchecked,
    Icons.radio_button_unchecked
  ];
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
    String deptTime = localizations.formatTimeOfDay(departureTime,
        alwaysUse24HourFormat: true);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffB3BABF).withOpacity(0.5)),
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
                          color: Colors.black.withOpacity(0.4), fontSize: 12),
                    ),
                    value: _source,
                    items: <String>['Delhi', 'Kolkata', 'Mumbai', 'Chennai']
                        .map<DropdownMenuItem<String>>((String value) {
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
                    items: <String>['Cochin', 'Hyderabad', 'Kolkata']
                        .map<DropdownMenuItem<String>>((String value) {
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
              height: 5,
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
              ],
            ),
            Text(
              'Class',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    barrierColor: Colors.black.withOpacity(0.7),
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, state) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.white,
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'CHOOSE CLASS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue,
                                      fontSize: 20),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Economy',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                        GestureDetector(
                                          child: Icon(
                                            icons[0],
                                            color: Colors.green[900],
                                            size: 30,
                                          ),
                                          onTap: () {
                                            updateClass(state, 1);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'BUSINESS',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                        GestureDetector(
                                          child: Icon(
                                            icons[1],
                                            color: Colors.green[900],
                                            size: 30,
                                          ),
                                          onTap: () {
                                            updateClass(state, 2);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'FIRST CLASS',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                        GestureDetector(
                                          child: Icon(
                                            icons[2],
                                            color: Colors.green[900],
                                            size: 30,
                                          ),
                                          onTap: () {
                                            updateClass(state, 3);
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffDAA210),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      'DONE',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('images/crown.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$flgCls',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Passenger',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    barrierColor: Colors.black.withOpacity(0.7),
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, state) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.white,
                                border: Border.all(color: Colors.black)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'CHOOSE PASSENGERS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blue,
                                      fontSize: 20),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        PassengerText(
                                          title: 'Adults',
                                          detail: '(18y+)',
                                        ),
                                        AddPassenger(
                                          typePass: _noAdult,
                                          addFunction: () {
                                            updated(state, 1, 1);
                                          },
                                          subFunction: () {
                                            updated(state, 2, 1);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        PassengerText(
                                            title: 'Children',
                                            detail: '(2y-18y)'),
                                        AddPassenger(
                                          typePass: _noChild,
                                          addFunction: () {
                                            updated(state, 1, 2);
                                          },
                                          subFunction: () {
                                            updated(state, 2, 2);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        PassengerText(
                                            title: 'Infants',
                                            detail: '(bellow 2y)'),
                                        AddPassenger(
                                          typePass: _noInfants,
                                          addFunction: () {
                                            updated(state, 1, 3);
                                          },
                                          subFunction: () {
                                            updated(state, 2, 3);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _noPass =
                                          _noInfants + _noChild + _noAdult;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffDAA210),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      'DONE',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$_noPass',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
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
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10, right: 20),
              child: DropdownButton(
                hint: Text(
                  'Choose No. of Stops',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.4), fontSize: 9),
                ),
                value: stops,
                isExpanded: true,
                items: <String>['Non-Stop', 'stops']
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
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                String fligthClass = 'ECONOMY';
                if (flgCls == 'Economy')
                  fligthClass = 'ECONOMY';
                else if (flgCls == 'Business')
                  fligthClass = 'BUSINESS';
                else
                  fligthClass = 'FIRST';
                if (_noAdult == 0) {
                  Get.snackbar(
                      'No Adult', 'There should be atleast one adult Passenger',
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      backgroundColor: Color(0xff468A62));
                } else if (_source != null &&
                    _destination != null &&
                    stops != null) {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) {
                        return LoadingScreen(
                            dept: _source,
                            dest: _destination,
                            departureDate: deptDate,
                            trvlClass: fligthClass,
                            noAdult: _noAdult,
                            noChild: _noChild,
                            noInfants: _noInfants);
                      },
                    ),
                  );
                } else
                  Get.snackbar(
                      'Field is Empty', 'All Fields are Mandatory to fill',
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
                  child: Text('Search the Flight',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> updated(StateSetter updateState, int fun, int pass) async {
    updateState(() {
      if (fun == 1) {
        if (pass == 1 && _noAdult > 0) _noAdult--;
        if (pass == 2 && _noChild > 0) _noChild--;
        if (pass == 3 && _noInfants > 0) _noInfants--;
      } else {
        if (pass == 1) _noAdult++;
        if (pass == 2) _noChild++;
        if (pass == 3) _noInfants++;
      }
    });
  }

  Future<Null> updateClass(StateSetter state, int cls) async {
    state(() {
      if (cls == 1) {
        flgCls = 'Economy';
        icons[0] = Icons.check_circle;
        icons[1] = Icons.radio_button_unchecked;
        icons[2] = Icons.radio_button_unchecked;
      } else if (cls == 2) {
        flgCls = 'Business';
        icons[1] = Icons.check_circle;
        icons[0] = Icons.radio_button_unchecked;
        icons[2] = Icons.radio_button_unchecked;
      } else {
        flgCls = 'First Class';
        icons[2] = Icons.check_circle;
        icons[0] = Icons.radio_button_unchecked;
        icons[1] = Icons.radio_button_unchecked;
      }
    });
  }
}
