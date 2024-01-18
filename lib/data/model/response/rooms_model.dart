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
  List<String>? admin;
  List<String>? activeUsers;
  List<String>? lastmembers;
  List<dynamic>? subscribers;
  List<dynamic>? blockedList;
  List<dynamic>? kickHistory;
  List<dynamic>? contributorsList;
  List<String>? groupMembers;
  List<String>? images;
  String? password;
  int? noOfSeats;
  int? totalDiamonds;
  int? halfMonthlyDiamonds;
  int? monthlyDiamonds;
  String? country;
  String? language;
  bool? isLocked;
  bool? isActive;
  String? id;
  String? roomId;
  String? groupName;
  String? userId;
  String? name;
  String? ownerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? countryCode;

  Room({
    this.announcement,
    this.treasureBoxLevel,
    this.usedDaimonds,
    this.admin,
    this.activeUsers,
    this.lastmembers,
    this.subscribers,
    this.blockedList,
    this.kickHistory,
    this.contributorsList,
    this.groupMembers,
    this.images,
    this.password,
    this.noOfSeats,
    this.totalDiamonds,
    this.halfMonthlyDiamonds,
    this.monthlyDiamonds,
    this.country,
    this.language,
    this.isLocked,
    this.isActive,
    this.id,
    this.roomId,
    this.groupName,
    this.userId,
    this.name,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.countryCode,
  });

  Room copyWith({
    String? announcement,
    int? treasureBoxLevel,
    int? usedDaimonds,
    List<String>? admin,
    List<String>? activeUsers,
    List<String>? lastmembers,
    List<dynamic>? subscribers,
    List<dynamic>? blockedList,
    List<dynamic>? kickHistory,
    List<dynamic>? contributorsList,
    List<String>? groupMembers,
    List<String>? images,
    String? password,
    int? noOfSeats,
    int? totalDiamonds,
    int? halfMonthlyDiamonds,
    int? monthlyDiamonds,
    String? country,
    String? language,
    bool? isLocked,
    bool? isActive,
    String? id,
    String? roomId,
    String? groupName,
    String? userId,
    String? name,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? countryCode,
  }) =>
      Room(
        announcement: announcement ?? this.announcement,
        treasureBoxLevel: treasureBoxLevel ?? this.treasureBoxLevel,
        usedDaimonds: usedDaimonds ?? this.usedDaimonds,
        admin: admin ?? this.admin,
        activeUsers: activeUsers ?? this.activeUsers,
        lastmembers: lastmembers ?? this.lastmembers,
        subscribers: subscribers ?? this.subscribers,
        blockedList: blockedList ?? this.blockedList,
        kickHistory: kickHistory ?? this.kickHistory,
        contributorsList: contributorsList ?? this.contributorsList,
        groupMembers: groupMembers ?? this.groupMembers,
        images: images ?? this.images,
        password: password ?? this.password,
        noOfSeats: noOfSeats ?? this.noOfSeats,
        totalDiamonds: totalDiamonds ?? this.totalDiamonds,
        halfMonthlyDiamonds: halfMonthlyDiamonds ?? this.halfMonthlyDiamonds,
        monthlyDiamonds: monthlyDiamonds ?? this.monthlyDiamonds,
        country: country ?? this.country,
        language: language ?? this.language,
        isLocked: isLocked ?? this.isLocked,
        isActive: isActive ?? this.isActive,
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        groupName: groupName ?? this.groupName,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        ownerId: ownerId ?? this.ownerId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        countryCode: countryCode ?? this.countryCode,
      );

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    announcement: json["announcement"],
    treasureBoxLevel: json["treasure_box_level"],
    usedDaimonds: json["used_daimonds"],
    admin: json["admin"] == null ? [] : List<String>.from(json["admin"]!.map((x) => x)),
    activeUsers: json["activeUsers"] == null ? [] : List<String>.from(json["activeUsers"]!.map((x) => x)),
    lastmembers: json["lastmembers"] == null ? [] : List<String>.from(json["lastmembers"]!.map((x) => x)),
    subscribers: json["subscribers"] == null ? [] : List<dynamic>.from(json["subscribers"]!.map((x) => x)),
    blockedList: json["blockedList"] == null ? [] : List<dynamic>.from(json["blockedList"]!.map((x) => x)),
    kickHistory: json["kickHistory"] == null ? [] : List<dynamic>.from(json["kickHistory"]!.map((x) => x)),
    contributorsList: json["contributorsList"] == null ? [] : List<dynamic>.from(json["contributorsList"]!.map((x) => x)),
    groupMembers: json["groupMembers"] == null ? [] : List<String>.from(json["groupMembers"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    password: json["password"],
    noOfSeats: json["no_of_seats"],
    totalDiamonds: json["totalDiamonds"],
    halfMonthlyDiamonds: json["halfMonthlyDiamonds"],
    monthlyDiamonds: json["MonthlyDiamonds"],
    country: json["Country"],
    language: json["language"],
    isLocked: json["is_locked"],
    isActive: json["is_active"],
    id: json["_id"],
    roomId: json["roomId"],
    groupName: json["groupName"],
    userId: json["userId"],
    name: json["name"],
    ownerId: json["ownerId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    countryCode: json["countryCode"],
  );

  Map<String, dynamic> toJson() => {
    "announcement": announcement,
    "treasure_box_level": treasureBoxLevel,
    "used_daimonds": usedDaimonds,
    "admin": admin == null ? [] : List<dynamic>.from(admin!.map((x) => x)),
    "activeUsers": activeUsers == null ? [] : List<dynamic>.from(activeUsers!.map((x) => x)),
    "lastmembers": lastmembers == null ? [] : List<dynamic>.from(lastmembers!.map((x) => x)),
    "subscribers": subscribers == null ? [] : List<dynamic>.from(subscribers!.map((x) => x)),
    "blockedList": blockedList == null ? [] : List<dynamic>.from(blockedList!.map((x) => x)),
    "kickHistory": kickHistory == null ? [] : List<dynamic>.from(kickHistory!.map((x) => x)),
    "contributorsList": contributorsList == null ? [] : List<dynamic>.from(contributorsList!.map((x) => x)),
    "groupMembers": groupMembers == null ? [] : List<dynamic>.from(groupMembers!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "password": password,
    "no_of_seats": noOfSeats,
    "totalDiamonds": totalDiamonds,
    "halfMonthlyDiamonds": halfMonthlyDiamonds,
    "MonthlyDiamonds": monthlyDiamonds,
    "Country": country,
    "language": language,
    "is_locked": isLocked,
    "is_active": isActive,
    "_id": id,
    "roomId": roomId,
    "groupName": groupName,
    "userId": userId,
    "name": name,
    "ownerId": ownerId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "countryCode": countryCode,
  };
}
