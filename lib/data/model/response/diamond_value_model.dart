// To parse this JSON data, do
//
//     final diamondValueModel = diamondValueModelFromJson(jsonString);

import 'dart:convert';

DiamondValueModel diamondValueModelFromJson(String str) => DiamondValueModel.fromJson(json.decode(str));

String diamondValueModelToJson(DiamondValueModel data) => json.encode(data.toJson());

class DiamondValueModel {
  int? status;
  String? message;
  List<DiamondValue>? data;

  DiamondValueModel({
    this.status,
    this.message,
    this.data,
  });

  factory DiamondValueModel.fromJson(Map<String, dynamic> json) => DiamondValueModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DiamondValue>.from(json["data"]!.map((x) => DiamondValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DiamondValue {
  String? id;
  num? price;
  int? diamond;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  DiamondValue({
    this.id,
    this.price,
    this.diamond,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DiamondValue.fromJson(Map<String, dynamic> json) => DiamondValue(
    id: json["_id"],
    price: json["price"],
    diamond: json["diamond"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "price": price,
    "diamond": diamond,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
