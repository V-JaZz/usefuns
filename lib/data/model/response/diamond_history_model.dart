// To parse this JSON data, do
//
//     final diamondHistoryModel = diamondHistoryModelFromJson(jsonString);

import 'dart:convert';

DiamondHistoryModel diamondHistoryModelFromJson(String str) => DiamondHistoryModel.fromJson(json.decode(str));

String diamondHistoryModelToJson(DiamondHistoryModel data) => json.encode(data.toJson());

class DiamondHistoryModel {
  int? status;
  String? message;
  List<DiamondHistory>? data;

  DiamondHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory DiamondHistoryModel.fromJson(Map<String, dynamic> json) => DiamondHistoryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DiamondHistory>.from(json["data"]!.map((x) => DiamondHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DiamondHistory {
  String? id;
  String? userId;
  int? diamonds;
  int? type;
  String? uses;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  DiamondHistory({
    this.id,
    this.userId,
    this.diamonds,
    this.type,
    this.uses,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DiamondHistory.fromJson(Map<String, dynamic> json) => DiamondHistory(
    id: json["_id"],
    userId: json["userId"],
    diamonds: json["diamonds"],
    type: json["type"],
    uses: json["uses"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "diamonds": diamonds,
    "type": type,
    "uses": uses,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
