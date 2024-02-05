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
  String? roomName;
  String? officialId;
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
  List<UserItem>? tags;
  List<UserItem>? vehicle;
  List<UserItem>? profileCard;
  List<UserItem>? lockRoom;
  List<UserItem>? extraSeat;
  List<UserItem>? frame;
  List<UserItem>? chatBubble;
  List<UserItem>? specialId;
  List<UserItem>? roomWallpaper;
  List<dynamic>? vip;
  List<dynamic>? svip;
  List<Agency>? agency;
  List<Admin>? admin;
  List<SubAdmin>? subAdmin;
  int? level;
  int? loginOtp;
  int? vipLevel;
  double? exp;
  double? totalDiamondsUses;
  bool? isCommentRestricted;
  List<String>? liveHotlist;
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
  String? countryCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? tokens;

  UserData({
    this.email,
    this.bio,
    this.status,
    this.userType,
    this.roomName,
    this.officialId,
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
    this.profileCard,
    this.vip,
    this.svip,
    this.lockRoom,
    this.extraSeat,
    this.agency,
    this.admin,
    this.subAdmin,
    this.specialId,
    this.frame,
    this.chatBubble,
    this.roomWallpaper,
    this.level,
    this.loginOtp,
    this.vipLevel,
    this.exp,
    this.totalDiamondsUses,
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
    this.countryCode,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.tokens,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    email: json["email"],
    bio: json["bio"],
    status: json["status"],
    userType: json["user_type"],
    roomName: json["roomName"],
    officialId: json["official_id"],
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
    tags: json["tags"] == null ? [] : List<UserItem>.from(json["tags"]!.map((x) => UserItem.fromJson(x))),
    vehicle: json["vehicle"] == null ? [] : List<UserItem>.from(json["vehicle"]!.map((x) => UserItem.fromJson(x))),
    profileCard: json["profileCard"] == null ? [] : List<UserItem>.from(json["profileCard"]!.map((x) => UserItem.fromJson(x))),
    vip: json["vip"] == null ? [] : List<dynamic>.from(json["vip"]!.map((x) => x)),
    svip: json["svip"] == null ? [] : List<dynamic>.from(json["svip"]!.map((x) => x)),
    lockRoom: json["lockRoom"] == null ? [] : List<UserItem>.from(json["lockRoom"]!.map((x) => UserItem.fromJson(x))),
    extraSeat: json["extraSeat"] == null ? [] : List<UserItem>.from(json["extraSeat"]!.map((x) => UserItem.fromJson(x))),
    agency: json["agency"] == null ? [] : List<Agency>.from(json["agency"]!.map((x) => Agency.fromJson(x))),
    admin: json["admin"] == null ? [] : List<Admin>.from(json["admin"]!.map((x) => Admin.fromJson(x))),
    subAdmin: json["subAdmin"] == null ? [] : List<SubAdmin>.from(json["subAdmin"]!.map((x) => SubAdmin.fromJson(x))),
    specialId: json["special_id"] == null ? [] : List<UserItem>.from(json["special_id"]!.map((x) => UserItem.fromJson(x))),
    frame: json["frame"] == null ? [] : List<UserItem>.from(json["frame"]!.map((x) => UserItem.fromJson(x))),
    chatBubble: json["chatBubble"] == null ? [] : List<UserItem>.from(json["chatBubble"]!.map((x) => UserItem.fromJson(x))),
    roomWallpaper: json["roomWallpaper"] == null ? [] : List<UserItem>.from(json["roomWallpaper"]!.map((x) => UserItem.fromJson(x))),
    level: json["level"],
    loginOtp: json["loginOtp"],
    vipLevel: json["vip_level"],
    exp: json["exp"]?.toDouble(),
    totalDiamondsUses: json["totalDiamondsUses"]?.toDouble(),
    isCommentRestricted: json["is_comment_restricted"],
    liveHotlist: json["live_hotlist"] == null ? [] : List<String>.from(json["live_hotlist"]!.map((x) => x)),
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
    countryCode: json["countryCode"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    tokens: json["tokens"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "bio": bio,
    "status": status,
    "user_type": userType,
    "roomName": roomName,
    "official_id": officialId,
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
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
    "vehicle": vehicle == null ? [] : List<dynamic>.from(vehicle!.map((x) => x.toJson())),
    "profileCard": profileCard == null ? [] : List<dynamic>.from(profileCard!.map((x) => x.toJson())),
    "vip": vip == null ? [] : List<dynamic>.from(vip!.map((x) => x)),
    "svip": svip == null ? [] : List<dynamic>.from(svip!.map((x) => x)),
    "lockRoom": lockRoom == null ? [] : List<dynamic>.from(lockRoom!.map((x) => x.toJson())),
    "extraSeat": extraSeat == null ? [] : List<dynamic>.from(extraSeat!.map((x) => x.toJson())),
    "agency": agency == null ? [] : List<dynamic>.from(agency!.map((x) => x.toJson())),
    "admin": admin == null ? [] : List<dynamic>.from(admin!.map((x) => x.toJson())),
    "subAdmin": subAdmin == null ? [] : List<dynamic>.from(subAdmin!.map((x) => x.toJson())),
    "special_id": specialId == null ? [] : List<dynamic>.from(specialId!.map((x) => x.toJson())),
    "frame": frame == null ? [] : List<dynamic>.from(frame!.map((x) => x.toJson())),
    "chatBubble": chatBubble == null ? [] : List<dynamic>.from(chatBubble!.map((x) => x.toJson())),
    "roomWallpaper": roomWallpaper == null ? [] : List<dynamic>.from(roomWallpaper!.map((x) => x.toJson())),
    "level": level,
    "loginOtp": loginOtp,
    "vip_level": vipLevel,
    "exp": exp,
    "totalDiamondsUses": totalDiamondsUses,
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
    "countryCode": countryCode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "tokens": tokens,
  };
}

class Admin {
  String? id;
  int? totalCoins;
  bool? isBanUnban;
  bool? mute;
  bool? kick;
  bool? screenshot;
  bool? agencyban;
  bool? dpapprove;
  bool? isActive;
  String? userId;
  String? username;
  String? password;
  List<dynamic>? tokens;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? label;
  String? value;

  Admin({
    this.id,
    this.totalCoins,
    this.isBanUnban,
    this.mute,
    this.kick,
    this.screenshot,
    this.agencyban,
    this.dpapprove,
    this.isActive,
    this.userId,
    this.username,
    this.password,
    this.tokens,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.label,
    this.value,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["_id"],
    totalCoins: json["totalCoins"],
    isBanUnban: json["is_ban_unban"],
    mute: json["mute"],
    kick: json["kick"],
    screenshot: json["screenshot"],
    agencyban: json["agencyban"],
    dpapprove: json["dpapprove"],
    isActive: json["is_active"],
    userId: json["userId"],
    username: json["username"],
    password: json["password"],
    tokens: json["tokens"] == null ? [] : List<dynamic>.from(json["tokens"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "totalCoins": totalCoins,
    "is_ban_unban": isBanUnban,
    "mute": mute,
    "kick": kick,
    "screenshot": screenshot,
    "agencyban": agencyban,
    "dpapprove": dpapprove,
    "is_active": isActive,
    "userId": userId,
    "username": username,
    "password": password,
    "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "label": label,
    "value": value,
  };
}

class Agency {
  String? id;
  List<String>? images;
  bool? isActive;
  String? code;
  String? userId;
  String? name;
  int? mobile;
  String? email;
  String? admin;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? label;
  String? value;

  Agency({
    this.id,
    this.images,
    this.isActive,
    this.code,
    this.userId,
    this.name,
    this.mobile,
    this.email,
    this.admin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.label,
    this.value,
  });

  factory Agency.fromJson(Map<String, dynamic> json) => Agency(
    id: json["_id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isActive: json["is_active"],
    code: json["code"],
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    admin: json["admin"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_active": isActive,
    "code": code,
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "email": email,
    "admin": admin,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "label": label,
    "value": value,
  };
}

class UserItem {
  String? id;
  String? name;
  List<String>? images;
  bool? isDefault;
  bool? isOfficial;
  DateTime? validTill;
  int? v;

  UserItem({
    this.id,
    this.name,
    this.images,
    this.isDefault,
    this.isOfficial,
    this.validTill,
    this.v,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
    id: json["_id"],
    name: json["name"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isDefault: json["is_default"],
    isOfficial: json["is_official"],
    validTill: json["validTill"] == null ? null : DateTime.parse(json["validTill"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_default": isDefault,
    "is_official": isOfficial,
    "validTill": validTill?.toIso8601String(),
    "__v": v,
  };
}

class SubAdmin {
  String? id;
  List<String>? images;
  bool? isActive;
  String? userId;
  String? username;
  String? password;
  String? role;
  List<dynamic>? tokens;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? label;
  String? value;

  SubAdmin({
    this.id,
    this.images,
    this.isActive,
    this.userId,
    this.username,
    this.password,
    this.role,
    this.tokens,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.label,
    this.value,
  });

  factory SubAdmin.fromJson(Map<String, dynamic> json) => SubAdmin(
    id: json["_id"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isActive: json["is_active"],
    userId: json["userId"],
    username: json["username"],
    password: json["password"],
    role: json["role"],
    tokens: json["tokens"] == null ? [] : List<dynamic>.from(json["tokens"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "is_active": isActive,
    "userId": userId,
    "username": username,
    "password": password,
    "role": role,
    "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "label": label,
    "value": value,
  };
}