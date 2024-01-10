// To parse this JSON data, do
//
//     final roomGiftHistoryModel = roomGiftHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'gifts_model.dart';

RoomGiftHistoryModel roomGiftHistoryModelFromJson(String str) => RoomGiftHistoryModel.fromJson(json.decode(str));

String roomGiftHistoryModelToJson(RoomGiftHistoryModel data) => json.encode(data.toJson());

class RoomGiftHistoryModel {
  int? status;
  String? message;
  List<GiftHistory>? data;

  RoomGiftHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory RoomGiftHistoryModel.fromJson(Map<String, dynamic> json) => RoomGiftHistoryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<GiftHistory>.from(json["data"]!.map((x) => GiftHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GiftHistory {
  String? id;
  String? roomId;
  String? sender;
  int? count;
  String? receiver;
  Gift? gift;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  GiftHistory({
    this.id,
    this.roomId,
    this.sender,
    this.count,
    this.receiver,
    this.gift,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GiftHistory.fromJson(Map<String, dynamic> json) => GiftHistory(
    id: json["_id"],
    roomId: json["roomId"],
    sender: json["sender"],
    count: json["count"],
    receiver: json["receiver"],
    gift: json["gift"] == null ? null : Gift.fromJson(json["gift"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "roomId": roomId,
    "sender": sender,
    "count": count,
    "receiver": receiver,
    "gift": gift?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
