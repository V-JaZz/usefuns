import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../datasource/remote/http/http_client.dart';

class ClubRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> getAll() async {
    try {
      http.Response response = await _httpClient.get('club/getall');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> join(String userId, String clubId) async {
    try {
      http.Response response = await _httpClient.post(
        'club/member/add',
        {
          "userId": userId,
          "clubId": clubId
        }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> create(
      {required String id,
        required String name,
        required String label,
        required String announcement,
        String? image}) async {
    try {
      http.Response response = image == null || image == ''
          ? await _httpClient.postMultipart(
          'club/add',
          {
            'userId': id,
            'name': name,
            'label': label,
            'announcement': announcement
          })
          :await _httpClient.postMultipartFile(
          'club/add',
          {
            'userId': id,
            'name': name,
            'label': label,
            'announcement': announcement
          },
          'images',
          image
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
