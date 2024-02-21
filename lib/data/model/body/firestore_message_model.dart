import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  final String toId;
  final String fromId;
  final Type type;
  final String message;
  final DateTime timeStamp;

  Message({
    required this.toId,
    required this.fromId,
    required this.type,
    required this.message,
    required this.timeStamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    toId: json["toId"],
    fromId: json["fromId"],
    type: typeValues.map[json["type"]]!,
    message: json["message"],
    timeStamp: DateTime.parse(json["timeStamp"]),
  );

  Map<String, dynamic> toJson() => {
    "toId": toId,
    "fromId": fromId,
    "type": typeValues.reverse[type],
    "message": message,
    "timeStamp": timeStamp.toIso8601String(),
  };
}

enum Type {
  image,
  text,
  emoji
}

final typeValues = EnumValues({
  "image": Type.image,
  "text": Type.text,
  "emoji": Type.emoji
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}