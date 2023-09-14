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
  Data? data;

  CreateRoomModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateRoomModel.fromJson(Map<String, dynamic> json) => CreateRoomModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? announcement;
  List<dynamic>? members;
  List<dynamic>? lastmembers;
  List<Member>? subscribers;
  List<String>? images;
  int? noOfSeats;
  bool? isLocked;
  bool? isActive;
  String? id;
  String? roomId;
  String? userId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.announcement,
    this.members,
    this.lastmembers,
    this.subscribers,
    this.images,
    this.noOfSeats,
    this.isLocked,
    this.isActive,
    this.id,
    this.roomId,
    this.userId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    announcement: json["announcement"],
    members: json["members"] == null ? [] : List<dynamic>.from(json["members"]!.map((x) => x)),
    lastmembers: json["lastmembers"] == null ? [] : List<dynamic>.from(json["lastmembers"]!.map((x) => x)),
    subscribers: json["subscribers"] == null ? [] : List<Member>.from(json["subscribers"]!.map((x) => Member.fromJson(x))),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    noOfSeats: json["no_of_seats"],
    isLocked: json["is_locked"],
    isActive: json["is_active"],
    id: json["_id"],
    roomId: json["roomId"],
    userId: json["userId"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "announcement": announcement,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
    "lastmembers": lastmembers == null ? [] : List<dynamic>.from(lastmembers!.map((x) => x)),
    "subscribers": subscribers == null ? [] : List<dynamic>.from(subscribers!.map((x) => x.toJson())),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "no_of_seats": noOfSeats,
    "is_locked": isLocked,
    "is_active": isActive,
    "_id": id,
    "roomId": roomId,
    "userId": userId,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
