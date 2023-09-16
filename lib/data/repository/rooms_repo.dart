import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../datasource/remote/http/http_client.dart';

class RoomsRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> create(String id, String name, String? path) async {
    try {
      http.Response response;
      if(path!=null){
        response = await _httpClient.postMultipartFile(
            'room/add', {'userId': id, 'name': name}, 'images', path);
      }else{
        response = await _httpClient.postMultipart(
            'room/add', {'userId': id, 'name': name});
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> updateName(String roomID, String name) async {
    try {
      http.Response response = await _httpClient.put('room/update',
        {
          "roomId": roomID,
          "name": name
        }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> addAnnouncement(String userID, String roomID, String text) async {
    try {
      http.Response response = await _httpClient.post('room/announcement/add',
        {
          "userId": userID,
          "roomId": roomID,
          "announcement": text
        }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> delete(String roomId) async {
    try {
      http.Response response = await _httpClient.delete(
        'room/delete',
        {
          "roomId":roomId
        }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getAllMine(String id) async {
    try {
      http.Response response = await _httpClient.get('room/getbyuserId/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getAllFollowingByMe(String id) async {
    try {
      http.Response response = await _httpClient.get('room/getallFollowingByUser/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getAllGroups(String id) async {
    try {
      http.Response response = await _httpClient.get('room/allRoomsByUserGroup/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getAllPopular() async {
    try {
      http.Response response = await _httpClient.get('room/getallPopular');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getAllNew() async {
    try {
      http.Response response = await _httpClient.get('room/getallNew');
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
