import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../datasource/remote/http/http_client.dart';

class MessagesRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> getAll(String uid) async {
    try {
      http.Response response = await _httpClient.get('user/pushMessageById/$uid');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteNotification(String id) async {
    try {
      http.Response response = await _httpClient.delete('user/pushMessageDeleteById/$id',{});
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
