import 'dart:convert';

BannerDataModel bannerDataModelFromJson(String str) => BannerDataModel.fromJson(json.decode(str));

String bannerDataModelToJson(BannerDataModel data) => json.encode(data.toJson());

class BannerDataModel {
  int? status;
  String? message;
  List<BannerData>? data;

  BannerDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory BannerDataModel.fromJson(Map<String, dynamic> json) => BannerDataModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<BannerData>.from(json["data"]!.map((x) => BannerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BannerData {
  List<String>? images;
  String? id;
  String? link;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BannerData({
    this.images,
    this.id,
    this.link,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    id: json["_id"],
    link: json["link"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "_id": id,
    "link": link,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
