// To parse this JSON data, do
//
//     final sellerModel = sellerModelFromJson(jsonString);

import 'dart:convert';

SellerModel sellerModelFromJson(String str) => SellerModel.fromJson(json.decode(str));

String sellerModelToJson(SellerModel data) => json.encode(data.toJson());

class SellerModel {
  int? status;
  String? message;
  List<SellerData>? data;

  SellerModel({
    this.status,
    this.message,
    this.data,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SellerData>.from(json["data"]!.map((x) => SellerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SellerData {
  int? totalCoins;
  List<String>? images;
  List<dynamic>? subCoinseller;
  bool? isActive;
  String? id;
  String? userId;
  String? sellerName;
  int? mobile;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SellerData({
    this.totalCoins,
    this.images,
    this.subCoinseller,
    this.isActive,
    this.id,
    this.userId,
    this.sellerName,
    this.mobile,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SellerData.fromJson(Map<String, dynamic> json) => SellerData(
    totalCoins: json["totalCoins"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    subCoinseller: json["subCoinseller"] == null ? [] : List<dynamic>.from(json["subCoinseller"]!.map((x) => x)),
    isActive: json["is_active"],
    id: json["_id"],
    userId: json["userId"],
    sellerName: json["seller_name"],
    mobile: json["mobile"],
    email: json["email"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "totalCoins": totalCoins,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "subCoinseller": subCoinseller == null ? [] : List<dynamic>.from(subCoinseller!.map((x) => x)),
    "is_active": isActive,
    "_id": id,
    "userId": userId,
    "seller_name": sellerName,
    "mobile": mobile,
    "email": email,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
