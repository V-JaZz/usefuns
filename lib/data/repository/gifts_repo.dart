import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../datasource/remote/http/http_client.dart';

class GiftsRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> getAll() async {
    try {
      http.Response response = await _httpClient.get('admin/gift/getall');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getAllContribution(String id) async {
    try {
      http.Response response = await _httpClient.get('room/getGiftHistory/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> sendGift(
      String senderId,
      String receiverId,
      String giftId,
      int count,
      String roomId
      ) async {
    try {
      http.Response response = await _httpClient.post(
          'user/send/gift',
        {
          "sender": senderId,
          "receiver": receiverId,
          "giftId": giftId,
          "count":count,
          "roomId": roomId
        }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> updateTBoxLevel(
      String roomId,
      int giftPrice
      ) async {
    try {
      http.Response response = await _httpClient.put(
          'room/updateBoxLevel',
          {
            "roomId": roomId,
            "daimonds": giftPrice
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
