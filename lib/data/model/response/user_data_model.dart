// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  int? status;
  String? message;
  UserData? data;

  UserDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : UserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserData {
  String? bio;
  String? status;
  String? userType;
  String? officialId;
  String? specialId;
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
  int? vipLevel;
  int? exp;
  bool? isCommentRestricted;
  List<dynamic>? liveHotlist;
  List<String>? images;
  bool? isActiveUserId;
  bool? isSequrityPanel;
  bool? isAgencyPanel;
  bool? isCoinseller;
  bool? isActiveLive;
  bool? isActiveDeviceId;
  bool? accessSubCoinseller;
  String? id;
  String? userId;
  String? name;
  int? mobile;
  DateTime? dob;
  String? gender;
  String? email;
  List<Token>? tokens;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserData({
    this.bio,
    this.status,
    this.userType,
    this.officialId,
    this.specialId,
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
    this.vipLevel,
    this.exp,
    this.isCommentRestricted,
    this.liveHotlist,
    this.images,
    this.isActiveUserId,
    this.isSequrityPanel,
    this.isAgencyPanel,
    this.isCoinseller,
    this.isActiveLive,
    this.isActiveDeviceId,
    this.accessSubCoinseller,
    this.id,
    this.userId,
    this.name,
    this.mobile,
    this.dob,
    this.gender,
    this.email,
    this.tokens,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    bio: json["bio"],
    status: json["status"],
    userType: json["user_type"],
    officialId: json["official_id"],
    specialId: json["special_id"],
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
    vipLevel: json["vip_level"],
    exp: json["exp"],
    isCommentRestricted: json["is_comment_restricted"],
    liveHotlist: json["live_hotlist"] == null ? [] : List<dynamic>.from(json["live_hotlist"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isActiveUserId: json["is_active_userId"],
    isSequrityPanel: json["is_sequrity_panel"],
    isAgencyPanel: json["is_agency_panel"],
    isCoinseller: json["is_coinseller"],
    isActiveLive: json["is_active_live"],
    isActiveDeviceId: json["is_active_deviceId"],
    accessSubCoinseller: json["access_subCoinseller"],
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    email: json["email"],
    tokens: json["tokens"] == null ? [] : List<Token>.from(json["tokens"]!.map((x) => Token.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "bio": bio,
    "status": status,
    "user_type": userType,
    "official_id": officialId,
    "special_id": specialId,
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
    "vip_level": vipLevel,
    "exp": exp,
    "is_comment_restricted": isCommentRestricted,
    "live_hotlist": liveHotlist == null ? [] : List<dynamic>.from(liveHotlist!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_active_userId": isActiveUserId,
    "is_sequrity_panel": isSequrityPanel,
    "is_agency_panel": isAgencyPanel,
    "is_coinseller": isCoinseller,
    "is_active_live": isActiveLive,
    "is_active_deviceId": isActiveDeviceId,
    "access_subCoinseller": accessSubCoinseller,
    "_id": id,
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "dob": dob?.toIso8601String(),
    "gender": gender,
    "email": email,
    "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x.toJson())),
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
