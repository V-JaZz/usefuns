// To parse this JSON data, do
//
//     final userSearchModel = userSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:live_app/data/model/response/user_data_model.dart';

UserSearchModel userSearchModelFromJson(String str) => UserSearchModel.fromJson(json.decode(str));

String userSearchModelToJson(UserSearchModel data) => json.encode(data.toJson());

class UserSearchModel {
  int? status;
  String? message;
  List<UserData>? data;

  UserSearchModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) => UserSearchModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<UserData>.from(json["data"]!.map((x) => UserData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Token {
  String? token;

  Token({
    this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
