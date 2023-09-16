// To parse this JSON data, do
//
//     final zegoBroadcastModel = zegoBroadcastModelFromJson(jsonString);

import 'dart:convert';

ZegoBroadcastModel zegoBroadcastModelFromJson(String str) => ZegoBroadcastModel.fromJson(json.decode(str));

String zegoBroadcastModelToJson(ZegoBroadcastModel data) => json.encode(data.toJson());

class ZegoBroadcastModel {
    int? level;
    String? image;
    String? frame;
    String? message;
    List<String>? tags;

    ZegoBroadcastModel({
        this.level,
        this.image,
        this.frame,
        this.message,
        this.tags,
    });

    factory ZegoBroadcastModel.fromJson(Map<String, dynamic> json) => ZegoBroadcastModel(
        level: json["level"],
        image: json["image"],
        frame: json["frame"],
        message: json["message"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "level": level,
        "image": image,
        "frame": frame,
        "message": message,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    };
}
