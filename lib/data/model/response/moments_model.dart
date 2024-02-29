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
  UserData? userDetails;
  List<String>? images;
  bool? isActive;
  String? createdBy;
  String? caption;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<UserReaction>? comments;
  List<UserReaction>? likes;

  Moment({
    this.id,
    this.userDetails,
    this.images,
    this.isActive,
    this.createdBy,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.v,
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
    comments: json["comments"] == null ? [] : List<UserReaction>.from(json["comments"]!.map((x) => UserReaction.fromJson(x))),
    likes: json["likes"] == null ? [] : List<UserReaction>.from(json["likes"]!.map((x) => UserReaction.fromJson(x))),
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
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x.toJson())),
  };
}

class UserReaction {
  String? id;
  String? comment;
  String? postId;
  String? userId;
  int? v;

  UserReaction({
    this.id,
    this.comment,
    this.postId,
    this.userId,
    this.v,
  });

  factory UserReaction.fromJson(Map<String, dynamic> json) => UserReaction(
    id: json["_id"],
    comment: json["comment"],
    postId: json["postId"],
    userId: json["userId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "comment": comment,
    "postId": postId,
    "userId": userId,
    "__v": v,
  };
}
