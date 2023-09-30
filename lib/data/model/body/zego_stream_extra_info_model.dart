// To parse this JSON data, do
//
//     final streamExtraInfoModel = streamExtraInfoModelFromJson(jsonString);

import 'dart:convert';

StreamExtraInfoModel streamExtraInfoModelFromJson(String str) => StreamExtraInfoModel.fromJson(json.decode(str));

String streamExtraInfoModelToJson(StreamExtraInfoModel data) => json.encode(data.toJson());

class StreamExtraInfoModel {
  String? id;
  int? level;
  int? age;
  int? followers;
  int? vip;
  String? gender;
  String? image;
  bool? owner;
  bool? admin;
  bool? member;

  StreamExtraInfoModel({
    this.id,
    this.level,
    this.age,
    this.followers,
    this.vip,
    this.gender,
    this.image,
    this.owner,
    this.admin,
    this.member,
  });

  factory StreamExtraInfoModel.fromJson(Map<String, dynamic> json) => StreamExtraInfoModel(
    id: json["id"],
    level: json["level"],
    age: json["age"],
    followers: json["followers"],
    vip: json["vip"],
    gender: json["gender"],
    image: json["image"],
    owner: json["owner"],
    admin: json["admin"],
    member: json["member"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "level": level,
    "age": age,
    "followers": followers,
    "vip": vip,
    "gender": gender,
    "image": image,
    "owner": owner,
    "admin": admin,
    "member": member,
  };
}
