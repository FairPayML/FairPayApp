// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FlightModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightModel _$FlightModelFromJson(Map<String, dynamic> json) => FlightModel(
      json['arvAirport'] as String,
      json['arvDate'] as String,
      json['arvTime'] as String,
      json['deptAirport'] as String,
      json['deptDate'] as String,
      json['deptTime'] as String,
    );

Map<String, dynamic> _$FlightModelToJson(FlightModel instance) =>
    <String, dynamic>{
      'deptAirport': instance.deptAirport,
      'arvAirport': instance.arvAirport,
      'deptDate': instance.deptDate,
      'arvDate': instance.arvDate,
      'deptTime': instance.deptTime,
      'arvTime': instance.arvTime,
    };
