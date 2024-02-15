import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../response/user_data_model.dart';

ZegoStreamExtended zegoStreamExtendedFromJson(String str) => ZegoStreamExtended.fromJson(json.decode(str));

String zegoStreamExtendedToJson(ZegoStreamExtended data) => json.encode(data.toJson());

class ZegoStreamExtended {
  String? streamId;
  UserData? userData;
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
    this.streamId,
    this.userData,
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
    streamId: json["stream_id"],
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
    "stream_id": streamId,
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
