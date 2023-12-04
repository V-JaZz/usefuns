import 'dart:convert';
import 'package:live_app/data/model/response/rooms_model.dart';

RoomSearchModel roomSearchModelFromJson(String str) => RoomSearchModel.fromJson(json.decode(str));

String roomSearchModelToJson(RoomSearchModel data) => json.encode(data.toJson());

class RoomSearchModel {
  int? status;
  String? message;
  List<Room>? data;

  RoomSearchModel({
    this.status,
    this.message,
    this.data,
  });

  factory RoomSearchModel.fromJson(Map<String, dynamic> json) => RoomSearchModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Room>.from(json["data"]!.map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
