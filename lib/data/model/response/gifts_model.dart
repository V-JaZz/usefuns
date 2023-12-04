// To parse this JSON data, do
//
//     final giftsModel = giftsModelFromJson(jsonString);

import 'dart:convert';

GiftsModel giftsModelFromJson(String str) => GiftsModel.fromJson(json.decode(str));

String giftsModelToJson(GiftsModel data) => json.encode(data.toJson());

class GiftsModel {
  int? status;
  String? message;
  List<Gift>? data;

  GiftsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GiftsModel.fromJson(Map<String, dynamic> json) => GiftsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Gift>.from(json["data"]!.map((x) => Gift.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Gift {
  List<String>? images;
  String? id;
  int? coin;
  String? name;
  String? categoryName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Gift({
    this.images,
    this.id,
    this.coin,
    this.name,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    id: json["_id"],
    coin: json["coin"],
    name: json["name"],
    categoryName: json["category_name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "_id": id,
    "coin": coin,
    "name": name,
    "category_name": categoryName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
