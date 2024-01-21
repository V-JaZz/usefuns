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
  bool? isDefault;
  String? name;
  bool? isOfficial;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<PriceAndvalidity>? priceAndvalidity;
  String? label;
  String? value;

  Items({
    this.id,
    this.images,
    this.isDefault,
    this.name,
    this.isOfficial,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.priceAndvalidity,
    this.label,
    this.value,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["_id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isDefault: json["is_default"],
    name: json["name"],
    isOfficial: json["is_official"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    priceAndvalidity: json["priceAndvalidity"] == null ? [] : List<PriceAndvalidity>.from(json["priceAndvalidity"]!.map((x) => PriceAndvalidity.fromJson(x))),
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_default": isDefault,
    "name": name,
    "is_official": isOfficial,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "priceAndvalidity": priceAndvalidity == null ? [] : List<dynamic>.from(priceAndvalidity!.map((x) => x.toJson())),
    "label": label,
    "value": value,
  };
}

class PriceAndvalidity {
  int? price;
  int? validity;

  PriceAndvalidity({
    this.price,
    this.validity,
  });

  factory PriceAndvalidity.fromJson(Map<String, dynamic> json) => PriceAndvalidity(
    price: json["price"],
    validity: json["validity"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "validity": validity,
  };
}
