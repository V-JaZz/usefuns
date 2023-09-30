// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  int? status;
  String? message;
  Data? data;

  UserDataModel({
    this.status,
    this.message,
    this.data,
  });

  UserDataModel copyWith({
    int? status,
    String? message,
    Data? data,
  }) =>
      UserDataModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
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
  int? vipLevel;
  int? exp;
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
  Club? club;

  Data({
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
    this.vipLevel,
    this.exp,
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
    this.club,
  });

  Data copyWith({
    String? bio,
    String? status,
    String? userType,
    String? deviceId,
    String? deviceType,
    List<dynamic>? kickedUser,
    int? diamonds,
    int? beans,
    int? coins,
    int? likes,
    int? comments,
    int? views,
    int? blockUsers,
    int? accounts,
    List<dynamic>? followers,
    List<dynamic>? following,
    List<dynamic>? badges,
    List<dynamic>? vehicle,
    List<dynamic>? frame,
    List<dynamic>? gift,
    int? level,
    int? vipLevel,
    int? exp,
    bool? isCommentRestricted,
    List<dynamic>? liveHotlist,
    List<String>? images,
    bool? isActiveUserId,
    bool? isActiveLive,
    bool? isActiveDeviceId,
    String? id,
    String? userId,
    String? name,
    int? mobile,
    DateTime? dob,
    String? gender,
    List<Token>? tokens,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? email,
    Club? club,
  }) =>
      Data(
        bio: bio ?? this.bio,
        status: status ?? this.status,
        userType: userType ?? this.userType,
        deviceId: deviceId ?? this.deviceId,
        deviceType: deviceType ?? this.deviceType,
        kickedUser: kickedUser ?? this.kickedUser,
        diamonds: diamonds ?? this.diamonds,
        beans: beans ?? this.beans,
        coins: coins ?? this.coins,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        views: views ?? this.views,
        blockUsers: blockUsers ?? this.blockUsers,
        accounts: accounts ?? this.accounts,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        badges: badges ?? this.badges,
        vehicle: vehicle ?? this.vehicle,
        frame: frame ?? this.frame,
        gift: gift ?? this.gift,
        level: level ?? this.level,
        vipLevel: vipLevel ?? this.vipLevel,
        exp: exp ?? this.exp,
        isCommentRestricted: isCommentRestricted ?? this.isCommentRestricted,
        liveHotlist: liveHotlist ?? this.liveHotlist,
        images: images ?? this.images,
        isActiveUserId: isActiveUserId ?? this.isActiveUserId,
        isActiveLive: isActiveLive ?? this.isActiveLive,
        isActiveDeviceId: isActiveDeviceId ?? this.isActiveDeviceId,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        tokens: tokens ?? this.tokens,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        email: email ?? this.email,
        club: club ?? this.club,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    vipLevel: json["vip_level"],
    exp: json["exp"],
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
    club: json["club"] == null ? null : Club.fromJson(json["club"]),
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
    "vip_level": vipLevel,
    "exp": exp,
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
    "club": club?.toJson(),
  };
}

class Club {
  String? label;
  String? announcement;
  int? totalDaimond;
  List<String>? members;
  List<String>? lastmembers;
  List<dynamic>? images;
  bool? isActive;
  String? id;
  String? clubId;
  String? userId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Club({
    this.label,
    this.announcement,
    this.totalDaimond,
    this.members,
    this.lastmembers,
    this.images,
    this.isActive,
    this.id,
    this.clubId,
    this.userId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Club copyWith({
    String? label,
    String? announcement,
    int? totalDaimond,
    List<String>? members,
    List<String>? lastmembers,
    List<dynamic>? images,
    bool? isActive,
    String? id,
    String? clubId,
    String? userId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Club(
        label: label ?? this.label,
        announcement: announcement ?? this.announcement,
        totalDaimond: totalDaimond ?? this.totalDaimond,
        members: members ?? this.members,
        lastmembers: lastmembers ?? this.lastmembers,
        images: images ?? this.images,
        isActive: isActive ?? this.isActive,
        id: id ?? this.id,
        clubId: clubId ?? this.clubId,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    label: json["label"],
    announcement: json["announcement"],
    totalDaimond: json["total_daimond"],
    members: json["members"] == null ? [] : List<String>.from(json["members"]!.map((x) => x)),
    lastmembers: json["lastmembers"] == null ? [] : List<String>.from(json["lastmembers"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    isActive: json["is_active"],
    id: json["_id"],
    clubId: json["clubId"],
    userId: json["userId"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "announcement": announcement,
    "total_daimond": totalDaimond,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
    "lastmembers": lastmembers == null ? [] : List<dynamic>.from(lastmembers!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_active": isActive,
    "_id": id,
    "clubId": clubId,
    "userId": userId,
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

  Token copyWith({
    String? token,
  }) =>
      Token(
        token: token ?? this.token,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
