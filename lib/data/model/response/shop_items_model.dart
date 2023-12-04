// To parse this JSON data, do
//
//     final shopItemsModel = shopItemsModelFromJson(jsonString);

import 'dart:convert';

ShopItemsModel shopItemsModelFromJson(String str) => ShopItemsModel.fromJson(json.decode(str));

String shopItemsModelToJson(ShopItemsModel data) => json.encode(data.toJson());

class ShopItemsModel {
  int? status;
  String? message;
  List<Items>? data;

  ShopItemsModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShopItemsModel.fromJson(Map<String, dynamic> json) => ShopItemsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Items>.from(json["data"]!.map((x) => Items.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Items {
  String? id;
  List<String>? images;
  int? day;
  int? price;
  String? name;
  int? level;
  bool? isOfficial;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? label;
  String? value;

  Items({
    this.id,
    this.images,
    this.day,
    this.price,
    this.name,
    this.level,
    this.isOfficial,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.label,
    this.value,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["_id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    day: json["day"],
    price: json["price"],
    name: json["name"],
    level: json["level"],
    isOfficial: json["is_official"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "day": day,
    "price": price,
    "name": name,
    "level": level,
    "is_official": isOfficial,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "label": label,
    "value": value,
  };
}
