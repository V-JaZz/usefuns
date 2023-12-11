// To parse this JSON data, do
//
//     final momentsModel = momentsModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_app/data/model/response/user_data_model.dart';

MomentsModel momentsModelFromJson(String str) => MomentsModel.fromJson(json.decode(str));

String momentsModelToJson(MomentsModel data) => json.encode(data.toJson());

class MomentsModel {
  int? status;
  String? message;
  List<Moment>? data;

  MomentsModel({
    this.status,
    this.message,
    this.data,
  });

  factory MomentsModel.fromJson(Map<String, dynamic> json) => MomentsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Moment>.from(json["data"]!.map((x) => Moment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Moment {
  String? id;
  List<String>? images;
  bool? isActive;
  String? createdBy;
  String? caption;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<UserData>? userDetails;
  List<Comment>? comments;
  List<Comment>? likes;

  Moment({
    this.id,
    this.images,
    this.isActive,
    this.createdBy,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.userDetails,
    this.comments,
    this.likes,
  });

  factory Moment.fromJson(Map<String, dynamic> json) => Moment(
    id: json["_id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isActive: json["is_active"],
    createdBy: json["createdBy"],
    caption: json["caption"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    userDetails: json["userDetails"] == null ? [] : List<UserData>.from(json["userDetails"]!.map((x) => UserData.fromJson(x))),
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    likes: json["likes"] == null ? [] : List<Comment>.from(json["likes"]!.map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_active": isActive,
    "createdBy": createdBy,
    "caption": caption,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "userDetails": userDetails == null ? [] : List<dynamic>.from(userDetails!.map((x) => x.toJson())),
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x.toJson())),
  };
}

class Comment {
  String? id;
  String? comment;
  String? postId;
  List<UserData>? userId;
  int? v;

  Comment({
    this.id,
    this.comment,
    this.postId,
    this.userId,
    this.v,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["_id"],
    comment: json["comment"],
    postId: json["postId"],
    userId: json["userId"] == null ? [] : List<UserData>.from(json["userId"]!.map((x) => UserData.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "comment": comment,
    "postId": postId,
    "userId": userId == null ? [] : List<dynamic>.from(userId!.map((x) => x.toJson())),
    "__v": v,
  };
}

class Frame {
  List<String>? images;
  String? id;
  int? day;
  int? price;
  String? name;
  int? level;
  bool? isOfficial;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Frame({
    this.images,
    this.id,
    this.day,
    this.price,
    this.name,
    this.level,
    this.isOfficial,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Frame.fromJson(Map<String, dynamic> json) => Frame(
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    id: json["_id"],
    day: json["day"],
    price: json["price"],
    name: json["name"],
    level: json["level"],
    isOfficial: json["is_official"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "_id": id,
    "day": day,
    "price": price,
    "name": name,
    "level": level,
    "is_official": isOfficial,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Tag {
  List<String>? images;
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Tag({
    this.images,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    id: json["_id"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "_id": id,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Token {
  String? token;

  Token({
    this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
