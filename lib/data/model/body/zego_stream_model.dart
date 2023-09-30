// To parse this JSON data, do
//
//     final zegoStreamExtended = zegoStreamExtendedFromJson(jsonString);

import 'dart:convert';

ZegoStreamExtended zegoStreamExtendedFromJson(String str) => ZegoStreamExtended.fromJson(json.decode(str));

String zegoStreamExtendedToJson(ZegoStreamExtended data) => json.encode(data.toJson());

class ZegoStreamExtended {
  String? id;
  String? streamId;
  String? userName;
  String? gender;
  String? image;
  int? level;
  int? age;
  int? followers;
  int? vip;
  int? seat;
  String? reaction;
  bool? owner;
  bool? admin;
  bool? member;

  ZegoStreamExtended({
    this.id,
    this.streamId,
    this.userName,
    this.gender,
    this.image,
    this.level,
    this.age,
    this.followers,
    this.vip,
    this.seat,
    this.reaction,
    this.owner,
    this.admin,
    this.member,
  });

  factory ZegoStreamExtended.fromJson(Map<String, dynamic> json) => ZegoStreamExtended(
    id: json["id"],
    streamId: json["stream_id"],
    userName: json["user_name"],
    gender: json["gender"],
    image: json["image"],
    level: json["level"],
    age: json["age"],
    followers: json["followers"],
    vip: json["vip"],
    seat: json["seat"],
    reaction: json["reaction"],
    owner: json["owner"],
    admin: json["admin"],
    member: json["member"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stream_id": streamId,
    "user_name": userName,
    "gender": gender,
    "image": image,
    "level": level,
    "age": age,
    "followers": followers,
    "vip": vip,
    "seat": seat,
    "reaction": reaction,
    "owner": owner,
    "admin": admin,
    "member": member,
  };
}
