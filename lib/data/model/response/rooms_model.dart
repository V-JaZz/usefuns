// To parse this JSON data, do
//
//     final roomsModel = roomsModelFromJson(jsonString);

import 'dart:convert';

RoomsModel roomsModelFromJson(String str) => RoomsModel.fromJson(json.decode(str));

String roomsModelToJson(RoomsModel data) => json.encode(data.toJson());

class RoomsModel {
  int? status;
  String? message;
  List<Room>? data;

  RoomsModel({
    this.status,
    this.message,
    this.data,
  });

  RoomsModel copyWith({
    int? status,
    String? message,
    List<Room>? data,
  }) =>
      RoomsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RoomsModel.fromJson(Map<String, dynamic> json) => RoomsModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Room>.from(json["data"]!.map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Room {
  String? announcement;
  int? treasureBoxLevel;
  int? usedDaimonds;
  List<dynamic>? members;
  List<dynamic>? lastmembers;
  List<Member>? subscribers;
  List<dynamic>? blockedList;
  List<dynamic>? kickHistory;
  List<dynamic>? contributorsList;
  List<Member>? groupMembers;
  List<String>? images;
  int? noOfSeats;
  int? totalDiamonds;
  String? country;
  String? language;
  bool? isLocked;
  bool? isActive;
  String? id;
  String? roomId;
  String? groupName;
  String? userId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? ownerId;

  Room({
    this.announcement,
    this.treasureBoxLevel,
    this.usedDaimonds,
    this.members,
    this.lastmembers,
    this.subscribers,
    this.blockedList,
    this.kickHistory,
    this.contributorsList,
    this.groupMembers,
    this.images,
    this.noOfSeats,
    this.totalDiamonds,
    this.country,
    this.language,
    this.isLocked,
    this.isActive,
    this.id,
    this.roomId,
    this.groupName,
    this.userId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.ownerId,
  });

  Room copyWith({
    String? announcement,
    int? treasureBoxLevel,
    int? usedDaimonds,
    List<dynamic>? members,
    List<dynamic>? lastmembers,
    List<Member>? subscribers,
    List<dynamic>? blockedList,
    List<dynamic>? kickHistory,
    List<dynamic>? contributorsList,
    List<Member>? groupMembers,
    List<String>? images,
    int? noOfSeats,
    int? totalDiamonds,
    String? country,
    String? language,
    bool? isLocked,
    bool? isActive,
    String? id,
    String? roomId,
    String? groupName,
    String? userId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? ownerId,
  }) =>
      Room(
        announcement: announcement ?? this.announcement,
        treasureBoxLevel: treasureBoxLevel ?? this.treasureBoxLevel,
        usedDaimonds: usedDaimonds ?? this.usedDaimonds,
        members: members ?? this.members,
        lastmembers: lastmembers ?? this.lastmembers,
        subscribers: subscribers ?? this.subscribers,
        blockedList: blockedList ?? this.blockedList,
        kickHistory: kickHistory ?? this.kickHistory,
        contributorsList: contributorsList ?? this.contributorsList,
        groupMembers: groupMembers ?? this.groupMembers,
        images: images ?? this.images,
        noOfSeats: noOfSeats ?? this.noOfSeats,
        totalDiamonds: totalDiamonds ?? this.totalDiamonds,
        country: country ?? this.country,
        language: language ?? this.language,
        isLocked: isLocked ?? this.isLocked,
        isActive: isActive ?? this.isActive,
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        groupName: groupName ?? this.groupName,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        ownerId: ownerId ?? this.ownerId,
      );

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    announcement: json["announcement"],
    treasureBoxLevel: json["treasure_box_level"],
    usedDaimonds: json["used_daimonds"],
    members: json["members"] == null ? [] : List<dynamic>.from(json["members"]!.map((x) => x)),
    lastmembers: json["lastmembers"] == null ? [] : List<dynamic>.from(json["lastmembers"]!.map((x) => x)),
    subscribers: json["subscribers"] == null ? [] : List<Member>.from(json["subscribers"]!.map((x) => Member.fromJson(x))),
    blockedList: json["blockedList"] == null ? [] : List<dynamic>.from(json["blockedList"]!.map((x) => x)),
    kickHistory: json["kickHistory"] == null ? [] : List<dynamic>.from(json["kickHistory"]!.map((x) => x)),
    contributorsList: json["contributorsList"] == null ? [] : List<dynamic>.from(json["contributorsList"]!.map((x) => x)),
    groupMembers: json["groupMembers"] == null ? [] : List<Member>.from(json["groupMembers"]!.map((x) => Member.fromJson(x))),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    noOfSeats: json["no_of_seats"],
    totalDiamonds: json["totalDiamonds"],
    country: json["Country"],
    language: json["language"],
    isLocked: json["is_locked"],
    isActive: json["is_active"],
    id: json["_id"],
    roomId: json["roomId"],
    groupName: json["groupName"],
    userId: json["userId"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    ownerId: json["ownerId"],
  );

  Map<String, dynamic> toJson() => {
    "announcement": announcement,
    "treasure_box_level": treasureBoxLevel,
    "used_daimonds": usedDaimonds,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
    "lastmembers": lastmembers == null ? [] : List<dynamic>.from(lastmembers!.map((x) => x)),
    "subscribers": subscribers == null ? [] : List<dynamic>.from(subscribers!.map((x) => x.toJson())),
    "blockedList": blockedList == null ? [] : List<dynamic>.from(blockedList!.map((x) => x)),
    "kickHistory": kickHistory == null ? [] : List<dynamic>.from(kickHistory!.map((x) => x)),
    "contributorsList": contributorsList == null ? [] : List<dynamic>.from(contributorsList!.map((x) => x)),
    "groupMembers": groupMembers == null ? [] : List<dynamic>.from(groupMembers!.map((x) => x.toJson())),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "no_of_seats": noOfSeats,
    "totalDiamonds": totalDiamonds,
    "Country": country,
    "language": language,
    "is_locked": isLocked,
    "is_active": isActive,
    "_id": id,
    "roomId": roomId,
    "groupName": groupName,
    "userId": userId,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "ownerId": ownerId,
  };
}

class Member {
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
  String? club;

  Member({
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

  Member copyWith({
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
    String? club,
  }) =>
      Member(
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

  factory Member.fromJson(Map<String, dynamic> json) => Member(
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
    club: json["club"],
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
    "club": club,
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
