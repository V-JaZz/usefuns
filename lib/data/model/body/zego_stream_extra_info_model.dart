import 'dart:convert';

ZegoStreamExtraInfo zegoStreamExtraInfoFromJson(String str) => ZegoStreamExtraInfo.fromJson(json.decode(str));

String zegoStreamExtraInfoToJson(ZegoStreamExtraInfo data) => json.encode(data.toJson());

class ZegoStreamExtraInfo {
  String? image;
  String? frame;
  List<String>? tags;

  ZegoStreamExtraInfo({
    this.image,
    this.frame,
    this.tags,
  });

  factory ZegoStreamExtraInfo.fromJson(Map<String, dynamic> json) => ZegoStreamExtraInfo(
    image: json["image"],
    frame: json["frame"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "frame": frame,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}
