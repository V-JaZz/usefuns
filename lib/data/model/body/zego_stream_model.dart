import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

ZegoStreamExtended zegoStreamExtendedFromJson(String str) => ZegoStreamExtended.fromJson(json.decode(str));

String zegoStreamExtendedToJson(ZegoStreamExtended data) => json.encode(data.toJson());

class ZegoStreamExtended {
  String? id;
  String? streamId;
  String? userName;
  String? gender;
  String? image;
  int? level;
  int? age;
  int? followers;
  int? vip;
  int? seat;
  bool? micOn;
  bool? chatBan;
  bool? micPermit;
  double? soundLevel;
  int? points;
  SVGAAnimationController? reactionController;
  bool? owner;
  bool? member;

  ZegoStreamExtended({
    this.id,
    this.streamId,
    this.userName,
    this.gender,
    this.image,
    this.level,
    this.age,
    this.followers,
    this.vip,
    this.seat,
    this.micOn,
    this.chatBan,
    this.micPermit,
    this.soundLevel,
    this.points,
    this.reactionController,
    this.owner,
    this.member,
  });

  factory ZegoStreamExtended.fromJson(Map<String, dynamic> json) => ZegoStreamExtended(
    id: json["id"],
    streamId: json["stream_id"],
    userName: json["user_name"],
    gender: json["gender"],
    image: json["image"],
    level: json["level"],
    age: json["age"],
    followers: json["followers"],
    vip: json["vip"],
    seat: json["seat"],
    micOn: json["mic_on"],
    chatBan: json["chat_ban"],
    micPermit: json["mic_permit"],
    soundLevel: json["sound_level"],
    points: json["points"],
    owner: json["owner"],
    member: json["member"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stream_id": streamId,
    "user_name": userName,
    "gender": gender,
    "image": image,
    "level": level,
    "age": age,
    "followers": followers,
    "vip": vip,
    "seat": seat,
    "mic_on": micOn,
    "chat_ban": chatBan,
    "mic_permit": micPermit,
    "sound_level": soundLevel,
    "points": points,
    "owner": owner,
    "member": member,
  };
}
