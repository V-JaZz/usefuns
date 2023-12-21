// To parse this JSON data, do
//
//     final zegoRoomModel = zegoRoomModelFromJson(jsonString);

import 'dart:convert';

ZegoRoomModel zegoRoomModelFromJson(String str) => ZegoRoomModel.fromJson(json.decode(str));

String zegoRoomModelToJson(ZegoRoomModel data) => json.encode(data.toJson());

class ZegoRoomModel {
  int totalSeats;
  List<int> lockedSeats;
  bool viewCalculator;

  ZegoRoomModel({
    required this.totalSeats,
    required this.lockedSeats,
    required this.viewCalculator
  });

  factory ZegoRoomModel.fromJson(Map<String, dynamic> json) => ZegoRoomModel(
    totalSeats: json["total_seats"],
    lockedSeats: List<int>.from(json["locked_seats"].map((x) => x)),
    viewCalculator: json["view_calculator"]
  );

  Map<String, dynamic> toJson() => {
    "total_seats": totalSeats,
    "locked_seats": List<dynamic>.from(lockedSeats.map((x) => x)),
    "view_calculator": viewCalculator
  };
}
