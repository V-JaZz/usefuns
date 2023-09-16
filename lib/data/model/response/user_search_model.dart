// To parse this JSON data, do
//
//     final userSearchModel = userSearchModelFromJson(jsonString);

import 'dart:convert';

UserSearchModel userSearchModelFromJson(String str) => UserSearchModel.fromJson(json.decode(str));

String userSearchModelToJson(UserSearchModel data) => json.encode(data.toJson());

class UserSearchModel {
  int? status;
  String? message;
  List<Datum>? data;

  UserSearchModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) => UserSearchModel(
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
  String? bio;
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
  bool? isCommentRestricted;
  List<dynamic>? liveHotlist;
  List<String>? images;
  bool? isActiveUserId;
  bool? isActiveLive;
  bool? isActiveDeviceId;
  String? id;
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

  Datum({
    this.bio,
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
    this.isCommentRestricted,
    this.liveHotlist,
    this.images,
    this.isActiveUserId,
    this.isActiveLive,
    this.isActiveDeviceId,
    this.id,
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bio: json["bio"],
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
    isCommentRestricted: json["is_comment_restricted"],
    liveHotlist: json["live_hotlist"] == null ? [] : List<dynamic>.from(json["live_hotlist"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isActiveUserId: json["is_active_userId"],
    isActiveLive: json["is_active_live"],
    isActiveDeviceId: json["is_active_deviceId"],
    id: json["_id"],
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
  );

  Map<String, dynamic> toJson() => {
    "bio": bio,
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
    "is_comment_restricted": isCommentRestricted,
    "live_hotlist": liveHotlist == null ? [] : List<dynamic>.from(liveHotlist!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_active_userId": isActiveUserId,
    "is_active_live": isActiveLive,
    "is_active_deviceId": isActiveDeviceId,
    "_id": id,
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
