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
  String? email;
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
  List<String>? followers;
  List<String>? following;
  List<ItemModel?>? tags;
  List<dynamic>? vehicle;
  List<Frame>? frame;
  List<ItemModel>? gift;
  List<ItemModel>? roomWallpaper;
  int? level;
  int? vipLevel;
  int? exp;
  bool? isCommentRestricted;
  int? totalDiamondsUses;
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
  List<Token>? tokens;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserData({
    this.email,
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
    this.tags,
    this.vehicle,
    this.frame,
    this.gift,
    this.roomWallpaper,
    this.level,
    this.vipLevel,
    this.exp,
    this.isCommentRestricted,
    this.totalDiamondsUses,
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
    this.tokens,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    email: json["email"],
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
    followers: json["followers"] == null ? [] : List<String>.from(json["followers"]!.map((x) => x)),
    following: json["following"] == null ? [] : List<String>.from(json["following"]!.map((x) => x)),
    tags: json["tags"] == null ? [] : List<ItemModel?>.from(json["tags"]!.map((x) => x == null ? null : ItemModel.fromJson(x))),
    vehicle: json["vehicle"] == null ? [] : List<dynamic>.from(json["vehicle"]!.map((x) => x)),
    frame: json["frame"] == null ? [] : List<Frame>.from(json["frame"]!.map((x) => Frame.fromJson(x))),
    gift: json["gift"] == null ? [] : List<ItemModel>.from(json["gift"]!.map((x) => ItemModel.fromJson(x))),
    roomWallpaper: json["roomWallpaper"] == null ? [] : List<ItemModel>.from(json["roomWallpaper"]!.map((x) => ItemModel.fromJson(x))),
    level: json["level"],
    vipLevel: json["vip_level"],
    exp: json["exp"],
    isCommentRestricted: json["is_comment_restricted"],
    totalDiamondsUses: json["totalDiamondsUses"],
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
    tokens: json["tokens"] == null ? [] : List<Token>.from(json["tokens"]!.map((x) => Token.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
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
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x?.toJson())),
    "vehicle": vehicle == null ? [] : List<dynamic>.from(vehicle!.map((x) => x)),
    "frame": frame == null ? [] : List<dynamic>.from(frame!.map((x) => x.toJson())),
    "gift": gift == null ? [] : List<dynamic>.from(gift!.map((x) => x.toJson())),
    "roomWallpaper": roomWallpaper == null ? [] : List<dynamic>.from(roomWallpaper!.map((x) => x.toJson())),
    "level": level,
    "vip_level": vipLevel,
    "exp": exp,
    "is_comment_restricted": isCommentRestricted,
    "totalDiamondsUses": totalDiamondsUses,
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
    "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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
  bool? defaultFrame;
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
    this.defaultFrame,
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
    defaultFrame: json["default_frame"],
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
    "default_frame": defaultFrame,
    "is_official": isOfficial,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ItemModel {
  List<String>? images;
  String? id;
  int? coin;
  String? name;
  String? categoryName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? day;
  int? price;

  ItemModel({
    this.images,
    this.id,
    this.coin,
    this.name,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.day,
    this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    id: json["_id"],
    coin: json["coin"],
    name: json["name"],
    categoryName: json["category_name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    day: json["day"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "_id": id,
    "coin": coin,
    "name": name,
    "category_name": categoryName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "day": day,
    "price": price,
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
