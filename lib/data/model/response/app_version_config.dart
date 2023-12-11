// To parse this JSON data, do
//
//     final appVersionConfigModel = appVersionConfigModelFromJson(jsonString);

import 'dart:convert';

AppVersionConfigModel appVersionConfigModelFromJson(String str) => AppVersionConfigModel.fromJson(json.decode(str));

String appVersionConfigModelToJson(AppVersionConfigModel data) => json.encode(data.toJson());

class AppVersionConfigModel {
  int? status;
  String? message;
  List<Version>? data;

  AppVersionConfigModel({
    this.status,
    this.message,
    this.data,
  });

  factory AppVersionConfigModel.fromJson(Map<String, dynamic> json) => AppVersionConfigModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Version>.from(json["data"]!.map((x) => Version.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Version {
  String? id;
  String? message;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Version({
    this.id,
    this.message,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Version.fromJson(Map<String, dynamic> json) => Version(
    id: json["_id"],
    message: json["message"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
