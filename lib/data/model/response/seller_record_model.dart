import 'dart:convert';

SellerRecordModel sellerRecordModelFromJson(String str) => SellerRecordModel.fromJson(json.decode(str));

String sellerRecordModelToJson(SellerRecordModel data) => json.encode(data.toJson());

class SellerRecordModel {
  int? status;
  String? message;
  List<Transaction>? data;

  SellerRecordModel({
    this.status,
    this.message,
    this.data,
  });

  factory SellerRecordModel.fromJson(Map<String, dynamic> json) => SellerRecordModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Transaction>.from(json["data"]!.map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Transaction {
  String? id;
  String? coinSellerId;
  String? userId;
  int? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Transaction({
    this.id,
    this.coinSellerId,
    this.userId,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["_id"],
    coinSellerId: json["coinSellerId"],
    userId: json["userId"],
    amount: json["amount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "coinSellerId": coinSellerId,
    "userId": userId,
    "amount": amount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
