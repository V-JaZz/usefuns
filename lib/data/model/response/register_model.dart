// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  int? status;
  String? message;
  Data? data;

  RegisterModel({
    this.status,
    this.message,
    this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null || json["data"] is! Map<String, dynamic> ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? userId;
  String? name;
  int? mobile;
  DateTime? dob;
  String? gender;
  List<dynamic>? followers;
  List<dynamic>? following;
  int? diamonds;
  int? coins;
  int? beans;
  List<dynamic>? images;
  String? token;

  Data({
    this.id,
    this.userId,
    this.name,
    this.mobile,
    this.dob,
    this.gender,
    this.followers,
    this.following,
    this.diamonds,
    this.coins,
    this.beans,
    this.images,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    followers: json["followers"] == null ? [] : List<dynamic>.from(json["followers"]!.map((x) => x)),
    following: json["following"] == null ? [] : List<dynamic>.from(json["following"]!.map((x) => x)),
    diamonds: json["diamonds"],
    coins: json["coins"],
    beans: json["beans"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "dob": dob?.toIso8601String(),
    "gender": gender,
    "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
    "following": following == null ? [] : List<dynamic>.from(following!.map((x) => x)),
    "diamonds": diamonds,
    "coins": coins,
    "beans": beans,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "token": token,
  };
}
