
import 'package:json_annotation/json_annotation.dart';
part 'FlightModel.g.dart';

@JsonSerializable()
class FlightModel{
  String deptAirport;
  String arvAirport;
  String deptDate;
  String arvDate;
  String deptTime;
  String arvTime;
  FlightModel(this.arvAirport,this.arvDate,this.arvTime,this.deptAirport,this.deptDate,this.deptTime);
  factory FlightModel.fromJSON(Map<String,dynamic> json)=>_$FlightModelFromJson(json);
  Map<String,dynamic> toJson()=>_$FlightModelToJson(this);
}