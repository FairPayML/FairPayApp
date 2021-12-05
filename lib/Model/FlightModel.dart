class FlightModel {
  final int stops;
  final String dept;
  final String dest;
  final String duration;
  final String deptName;
  final String destName;
  final String deptDate;
  final String destDate;
  final String destTime;
  final String deptTime;
  final String price;
  final String airline;

  FlightModel(
      {required this.stops,
      required this.dept,
      required this.dest,
      required this.duration,
      required this.deptName,
      required this.destName,
      required this.deptDate,
      required this.destDate,
      required this.destTime,
      required this.deptTime,
      required this.price,
      required this.airline});

  factory FlightModel.fromJson(Map<String, dynamic> json, String deptName,
      String destName, String deptAirport, String destAirpot) {
    List deptDT = json['itineraries'][0]['segments'][0]['departure']['at']
        .toString()
        .split('T');
    String deptDate = deptDT[0];
    String deptTime = deptDT[1].toString().substring(0, 5);
    List destDT = json['itineraries'][0]['segments'][0]['arrival']['at']
        .toString()
        .split('T');
    String destDate = destDT[0];
    String destTime = destDT[1].toString().substring(0, 5);
    String carrierCode = json['itineraries'][0]['segments'][0]['carrierCode'];
    String airline = ' ';
    if (carrierCode == '9I')
      airline = 'ALLIANCE AIR';
    else if (carrierCode == 'UK')
      airline = 'VISTARA';
    else
      airline = 'AIR INDIA';
    return FlightModel(
      stops: json['itineraries'][0]['segments'][0]['numberOfStops'],
      dept: deptAirport,
      dest: destAirpot,
      duration: json['itineraries'][0]['duration'].toString().split('T')[1],
      deptName: deptName,
      destName: destName,
      deptDate: deptDate,
      destDate: destDate,
      destTime: destTime,
      deptTime: deptTime,
      price: json['price']['total'],
      airline: airline,
    );
  }
}
