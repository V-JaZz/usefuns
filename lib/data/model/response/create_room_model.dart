// To parse this JSON data, do
//
//     final createRoomModel = createRoomModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_app/data/model/response/rooms_model.dart';

CreateRoomModel createRoomModelFromJson(String str) => CreateRoomModel.fromJson(json.decode(str));

String createRoomModelToJson(CreateRoomModel data) => json.encode(data.toJson());

class CreateRoomModel {
  int? status;
  String? message;
  Room? data;

  CreateRoomModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateRoomModel.fromJson(Map<String, dynamic> json) => CreateRoomModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Room.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}
