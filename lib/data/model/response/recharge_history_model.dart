// To parse this JSON data, do
//
//     final rechargeHistoryModel = rechargeHistoryModelFromJson(jsonString);

import 'dart:convert';

RechargeHistoryModel rechargeHistoryModelFromJson(String str) => RechargeHistoryModel.fromJson(json.decode(str));

String rechargeHistoryModelToJson(RechargeHistoryModel data) => json.encode(data.toJson());

class RechargeHistoryModel {
  int? status;
  String? message;
  List<RechargeDetail>? data;

  RechargeHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory RechargeHistoryModel.fromJson(Map<String, dynamic> json) => RechargeHistoryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<RechargeDetail>.from(json["data"]!.map((x) => RechargeDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RechargeDetail {
  int? diamonds;
  bool? isActive;
  String? id;
  String? userId;
  String? status;
  int? price;
  String? paymentMethod;
  String? transactionId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  RechargeDetail({
    this.diamonds,
    this.isActive,
    this.id,
    this.userId,
    this.status,
    this.price,
    this.paymentMethod,
    this.transactionId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RechargeDetail.fromJson(Map<String, dynamic> json) => RechargeDetail(
    diamonds: json["diamonds"],
    isActive: json["is_active"],
    id: json["_id"],
    userId: json["userId"],
    status: json["status"],
    price: json["price"],
    paymentMethod: json["payment_method"],
    transactionId: json["transactionId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "diamonds": diamonds,
    "is_active": isActive,
    "_id": id,
    "userId": userId,
    "status": status,
    "price": price,
    "payment_method": paymentMethod,
    "transactionId": transactionId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
