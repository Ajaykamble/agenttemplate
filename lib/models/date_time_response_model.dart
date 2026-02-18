// To parse this JSON data, do
//
//     final dateTimeResponseModel = dateTimeResponseModelFromJson(jsonString);

import 'dart:convert';

DateTimeResponseModel dateTimeResponseModelFromJson(String str) => DateTimeResponseModel.fromJson(json.decode(str));

String dateTimeResponseModelToJson(DateTimeResponseModel data) => json.encode(data.toJson());

class DateTimeResponseModel {
  DateTime? dateTime;
  DateTime? date;
  String? time;
  String? hours;
  String? seconds;
  String? minutes;

  DateTimeResponseModel({this.dateTime, this.date, this.time, this.hours, this.seconds, this.minutes});

  factory DateTimeResponseModel.fromJson(Map<String, dynamic> json) => DateTimeResponseModel(
    dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    hours: json["hours"],
    seconds: json["seconds"],
    minutes: json["minutes"],
  );

  Map<String, dynamic> toJson() => {
    "dateTime": dateTime?.toIso8601String(),
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "hours": hours,
    "seconds": seconds,
    "minutes": minutes,
  };
}
