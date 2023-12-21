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
    ZegoGift? gift;

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
        gift: json["gift"] == null ? null : ZegoGift.fromJson(json["gift"]),
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

class ZegoGift {
    String? toName;
    String? toId;
    String? thumbnailPath;
    String? giftPath;
    int? giftPrice;
    int? count;

    ZegoGift({
        this.toName,
        this.toId,
        this.thumbnailPath,
        this.giftPath,
        this.giftPrice,
        this.count,
    });

    factory ZegoGift.fromJson(Map<String, dynamic> json) => ZegoGift(
        toName: json["toName"],
        toId: json["toId"],
        thumbnailPath: json["thumbnail_path"],
        giftPath: json["gift_path"],
        giftPrice: json["giftPrice"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "toName": toName,
        "toId": toId,
        "thumbnail_path": thumbnailPath,
        "gift_path": giftPath,
        "giftPrice": giftPrice,
        "count": count,
    };
}
