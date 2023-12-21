// To parse this JSON data, do
//
//     final agencyHostModel = agencyHostModelFromJson(jsonString);

import 'dart:convert';

AgencyHostModel agencyHostModelFromJson(String str) => AgencyHostModel.fromJson(json.decode(str));

String agencyHostModelToJson(AgencyHostModel data) => json.encode(data.toJson());

class AgencyHostModel {
  int? status;
  String? message;
  List<HostData>? data;

  AgencyHostModel({
    this.status,
    this.message,
    this.data,
  });

  factory AgencyHostModel.fromJson(Map<String, dynamic> json) => AgencyHostModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<HostData>.from(json["data"]!.map((x) => HostData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HostData {
  String? status;
  String? id;
  String? userId;
  String? agencyCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  HostData({
    this.status,
    this.id,
    this.userId,
    this.agencyCode,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory HostData.fromJson(Map<String, dynamic> json) => HostData(
    status: json["status"],
    id: json["_id"],
    userId: json["userId"],
    agencyCode: json["agency_code"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "userId": userId,
    "agency_code": agencyCode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
