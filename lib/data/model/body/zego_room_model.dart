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
  List<String> admins;

  ZegoRoomModel({
    required this.totalSeats,
    required this.lockedSeats,
    required this.viewCalculator,
    required this.admins,
  });

  factory ZegoRoomModel.fromJson(Map<String, dynamic> json) => ZegoRoomModel(
    totalSeats: json["total_seats"],
    lockedSeats: List<int>.from(json["locked_seats"].map((x) => x)),
    viewCalculator: json["view_calculator"],
    admins: List<String>.from(json["admins"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "total_seats": totalSeats,
    "locked_seats": List<dynamic>.from(lockedSeats.map((x) => x)),
    "view_calculator": viewCalculator,
    "admins": List<dynamic>.from(admins.map((x) => x)),
  };
}
