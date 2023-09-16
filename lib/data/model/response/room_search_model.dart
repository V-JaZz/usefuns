// To parse this JSON data, do
//
//     final roomSearchModel = roomSearchModelFromJson(jsonString);

import 'dart:convert';

RoomSearchModel roomSearchModelFromJson(String str) => RoomSearchModel.fromJson(json.decode(str));

String roomSearchModelToJson(RoomSearchModel data) => json.encode(data.toJson());

class RoomSearchModel {
  int? status;
  String? message;
  List<Datum>? data;

  RoomSearchModel({
    this.status,
    this.message,
    this.data,
  });

  factory RoomSearchModel.fromJson(Map<String, dynamic> json) => RoomSearchModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? announcement;
  List<dynamic>? members;
  List<String>? lastmembers;
  List<String>? subscribers;
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
  String? imageUrl;
  int? password;

  Datum({
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
    this.imageUrl,
    this.password,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    announcement: json["announcement"],
    members: json["members"] == null ? [] : List<dynamic>.from(json["members"]!.map((x) => x)),
    lastmembers: json["lastmembers"] == null ? [] : List<String>.from(json["lastmembers"]!.map((x) => x)),
    subscribers: json["subscribers"] == null ? [] : List<String>.from(json["subscribers"]!.map((x) => x)),
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
    imageUrl: json["image_url"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "announcement": announcement,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
    "lastmembers": lastmembers == null ? [] : List<dynamic>.from(lastmembers!.map((x) => x)),
    "subscribers": subscribers == null ? [] : List<dynamic>.from(subscribers!.map((x) => x)),
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
    "image_url": imageUrl,
    "password": password,
  };
}
