// To parse this JSON data, do
//
//     final momentsModel = momentsModelFromJson(jsonString);

import 'dart:convert';

MomentsModel momentsModelFromJson(String str) => MomentsModel.fromJson(json.decode(str));

String momentsModelToJson(MomentsModel data) => json.encode(data.toJson());

class MomentsModel {
  int? status;
  String? message;
  List<Datum>? data;

  MomentsModel({
    this.status,
    this.message,
    this.data,
  });

  factory MomentsModel.fromJson(Map<String, dynamic> json) => MomentsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  List<String>? images;
  bool? isActive;
  String? createdBy;
  String? caption;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isCommentRestricted;
  List<User>? userDetails;
  List<Comment>? comments;
  List<Like>? likes;

  Datum({
    this.id,
    this.images,
    this.isActive,
    this.createdBy,
    this.caption,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isCommentRestricted,
    this.userDetails,
    this.comments,
    this.likes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isActive: json["is_active"],
    createdBy: json["createdBy"],
    caption: json["caption"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isCommentRestricted: json["is_comment_restricted"],
    userDetails: json["userDetails"] == null ? [] : List<User>.from(json["userDetails"]!.map((x) => User.fromJson(x))),
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    likes: json["likes"] == null ? [] : List<Like>.from(json["likes"]!.map((x) => Like.fromJson(x))),
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
    "is_comment_restricted": isCommentRestricted,
    "userDetails": userDetails == null ? [] : List<dynamic>.from(userDetails!.map((x) => x.toJson())),
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x.toJson())),
  };
}

class Comment {
  String? id;
  String? comment;
  String? postId;
  List<User>? userId;
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
    userId: json["userId"] == null ? [] : List<User>.from(json["userId"]!.map((x) => User.fromJson(x))),
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

class User {
  String? id;
  String? status;
  String? userType;
  String? deviceId;
  String? deviceType;
  List<dynamic>? kickedUser;
  int? diamonds;
  int? beans;
  int? coins;
  int? likes;
  int? comments;
  int? views;
  int? blockUsers;
  int? accounts;
  List<dynamic>? followers;
  List<dynamic>? following;
  List<dynamic>? badges;
  List<dynamic>? vehicle;
  List<dynamic>? frame;
  List<dynamic>? gift;
  int? level;
  List<dynamic>? liveHotlist;
  List<String>? images;
  bool? isActiveUserId;
  bool? isActiveLive;
  bool? isActiveDeviceId;
  String? userId;
  String? name;
  int? mobile;
  DateTime? dob;
  String? gender;
  List<Token>? tokens;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? email;
  String? bio;

  User({
    this.id,
    this.status,
    this.userType,
    this.deviceId,
    this.deviceType,
    this.kickedUser,
    this.diamonds,
    this.beans,
    this.coins,
    this.likes,
    this.comments,
    this.views,
    this.blockUsers,
    this.accounts,
    this.followers,
    this.following,
    this.badges,
    this.vehicle,
    this.frame,
    this.gift,
    this.level,
    this.liveHotlist,
    this.images,
    this.isActiveUserId,
    this.isActiveLive,
    this.isActiveDeviceId,
    this.userId,
    this.name,
    this.mobile,
    this.dob,
    this.gender,
    this.tokens,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.email,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    status: json["status"],
    userType: json["user_type"],
    deviceId: json["device_id"],
    deviceType: json["device_type"],
    kickedUser: json["kickedUser"] == null ? [] : List<dynamic>.from(json["kickedUser"]!.map((x) => x)),
    diamonds: json["diamonds"],
    beans: json["beans"],
    coins: json["coins"],
    likes: json["likes"],
    comments: json["comments"],
    views: json["views"],
    blockUsers: json["block_users"],
    accounts: json["accounts"],
    followers: json["followers"] == null ? [] : List<dynamic>.from(json["followers"]!.map((x) => x)),
    following: json["following"] == null ? [] : List<dynamic>.from(json["following"]!.map((x) => x)),
    badges: json["badges"] == null ? [] : List<dynamic>.from(json["badges"]!.map((x) => x)),
    vehicle: json["vehicle"] == null ? [] : List<dynamic>.from(json["vehicle"]!.map((x) => x)),
    frame: json["frame"] == null ? [] : List<dynamic>.from(json["frame"]!.map((x) => x)),
    gift: json["gift"] == null ? [] : List<dynamic>.from(json["gift"]!.map((x) => x)),
    level: json["level"],
    liveHotlist: json["live_hotlist"] == null ? [] : List<dynamic>.from(json["live_hotlist"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isActiveUserId: json["is_active_userId"],
    isActiveLive: json["is_active_live"],
    isActiveDeviceId: json["is_active_deviceId"],
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    tokens: json["tokens"] == null ? [] : List<Token>.from(json["tokens"]!.map((x) => Token.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    email: json["email"],
    bio: json["bio"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "status": status,
    "user_type": userType,
    "device_id": deviceId,
    "device_type": deviceType,
    "kickedUser": kickedUser == null ? [] : List<dynamic>.from(kickedUser!.map((x) => x)),
    "diamonds": diamonds,
    "beans": beans,
    "coins": coins,
    "likes": likes,
    "comments": comments,
    "views": views,
    "block_users": blockUsers,
    "accounts": accounts,
    "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
    "following": following == null ? [] : List<dynamic>.from(following!.map((x) => x)),
    "badges": badges == null ? [] : List<dynamic>.from(badges!.map((x) => x)),
    "vehicle": vehicle == null ? [] : List<dynamic>.from(vehicle!.map((x) => x)),
    "frame": frame == null ? [] : List<dynamic>.from(frame!.map((x) => x)),
    "gift": gift == null ? [] : List<dynamic>.from(gift!.map((x) => x)),
    "level": level,
    "live_hotlist": liveHotlist == null ? [] : List<dynamic>.from(liveHotlist!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_active_userId": isActiveUserId,
    "is_active_live": isActiveLive,
    "is_active_deviceId": isActiveDeviceId,
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "dob": dob?.toIso8601String(),
    "gender": gender,
    "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "email": email,
    "bio": bio,
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

class Like {
  String? id;
  String? postId;
  List<User>? userId;
  int? v;

  Like({
    this.id,
    this.postId,
    this.userId,
    this.v,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
    id: json["_id"],
    postId: json["postId"],
    userId: json["userId"] == null ? [] : List<User>.from(json["userId"]!.map((x) => User.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postId": postId,
    "userId": userId == null ? [] : List<dynamic>.from(userId!.map((x) => x.toJson())),
    "__v": v,
  };
}
