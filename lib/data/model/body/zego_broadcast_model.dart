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
    List<String>? tags;
    String? message;
    String? type;
    Gift? gift;

    ZegoBroadcastModel({
        this.level,
        this.image,
        this.frame,
        this.tags,
        this.message,
        this.type,
        this.gift,
    });

    factory ZegoBroadcastModel.fromJson(Map<String, dynamic> json) => ZegoBroadcastModel(
        level: json["level"],
        image: json["image"],
        frame: json["frame"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        message: json["message"],
        type: json["type"],
        gift: json["gift"] == null ? null : Gift.fromJson(json["gift"]),
    );

    Map<String, dynamic> toJson() => {
        "level": level,
        "image": image,
        "frame": frame,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "message": message,
        "type": type,
        "gift": gift?.toJson(),
    };
}

class Gift {
    String? to;
    String? giftPath;
    int? count;

    Gift({
        this.to,
        this.giftPath,
        this.count,
    });

    factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        to: json["to"],
        giftPath: json["gift_path"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "to": to,
        "gift_path": giftPath,
        "count": count,
    };
}
