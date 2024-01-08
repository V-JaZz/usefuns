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
      http.Response response = await _httpClient.put('room/update/$roomID',
        {"name": name}
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> updatePicture(String roomID, String path, String name) async {
    try {
      http.Response response = await _httpClient.postMultipartFile(
          'room/update/$roomID',
          {"name": name},
          'images',
          path,
        method: 'PUT'
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

  Future<http.Response> addUser(String roomID, String userID) async {
    try {
      http.Response response = await _httpClient.post('room/activeUser/add',
          {
            "userId": userID,
            "roomId": roomID
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> lockRoom(String roomID, String userID, String password, String token) async {
    try {
      http.Response response = await _httpClient.post('room/lock',
          {
            "userId": userID,
            "roomId": roomID,
            "password": password
          },
        bearerToken: token
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> unlockRoom(String roomID, String userID, String token) async {
    try {
      http.Response response = await _httpClient.post('room/unlock',
          {
            "userId": userID,
            "roomId": roomID
          },
          bearerToken: token
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> addUserLocked(String roomID, String userID, String password) async {
    try {
      http.Response response = await _httpClient.post('room/activeUser/add_in_locked_room',
          {
            "userId": userID,
            "roomId": roomID,
            "password": password
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> removeUser(String roomID, String userID) async {
    try {
      http.Response response = await _httpClient.post('room/activeUser/remove',
          {
            "userId": userID,
            "roomId": roomID
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> addAdmin(String roomID, String userID) async {
    try {
      http.Response response = await _httpClient.post('room/admin/add',
        {
          "userId": userID,
          "roomId": roomID
        }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> removeAdmin(String roomID, String userID) async {
    try {
      http.Response response = await _httpClient.post('room/admin/remove',
        {
          "userId": userID,
          "roomId": roomID
        }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getRoomByRoomId(String id) async {
    try {
      http.Response response = await _httpClient.get('room/getbyRoomId/$id');
      return response;
    } catch (e) {
      // return await getRoom(id);
      rethrow;
    }
  }

  Future<http.Response> getRoomById(String id) async {
    try {
      http.Response response = await _httpClient.get('room/getbyid/$id');
      return response;
    } catch (e) {
      // return await getRoom(id);
      rethrow;
    }
  }

  Future<http.Response> getBannerList() async {
    try {
      http.Response response = await _httpClient.get('admin/banner/getall');
      return response;
    } catch (e) {
      // return await getRoom(id);
      rethrow;
    }
  }

  Future<http.Response> getAdmins(String id) async {
    try {
      http.Response response = await _httpClient.get('room/getUpdatedAdmin/$id');
      return response;
    } catch (e) {
      // return await getAdmins(id);
      rethrow;
    }
  }

  Future<http.Response> getTreasureBox(String id) async {
    try {
      http.Response response = await _httpClient.get('room/getTreasureBoxLevel/$id');
      return response;
    } catch (e) {
      // return await getTreasureBox(id);
      rethrow;
    }
  }

  Future<http.Response> getAllMine(String id) async {
    try {
      http.Response response = await _httpClient.get('room/getbyuserId/$id');
      return response;
    } catch (e) {
      // return await getAllMine(id);
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

  Future<http.Response> getAllMyRecent(String id) async {
    try {
      http.Response response = await _httpClient.get('room/joinrecentlyByUser/$id');
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

  Future<http.Response> getAllPopular(int page, int limit) async {
    try {
      http.Response response = await _httpClient.get('room/getallPopular?page=$page&limit=$limit');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getAllNew(int page, int limit) async {
    try {
      http.Response response = await _httpClient.get('room/getallNew?page=$page&limit=$limit');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
