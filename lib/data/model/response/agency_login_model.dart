import 'dart:convert';

AgencyLoginModel agencyLoginModelFromJson(String str) => AgencyLoginModel.fromJson(json.decode(str));

String agencyLoginModelToJson(AgencyLoginModel data) => json.encode(data.toJson());

class AgencyLoginModel {
  int? status;
  String? message;
  Data? data;

  AgencyLoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory AgencyLoginModel.fromJson(Map<String, dynamic> json) => AgencyLoginModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<String>? images;
  bool? isActive;
  String? id;
  String? code;
  String? userId;
  String? name;
  int? mobile;
  String? email;
  String? admin;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.images,
    this.isActive,
    this.id,
    this.code,
    this.userId,
    this.name,
    this.mobile,
    this.email,
    this.admin,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isActive: json["is_active"],
    id: json["_id"],
    code: json["code"],
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    admin: json["admin"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_active": isActive,
    "_id": id,
    "code": code,
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "email": email,
    "admin": admin,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
