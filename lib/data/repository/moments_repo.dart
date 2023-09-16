import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../datasource/remote/http/http_client.dart';

class MomentsRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> getAllMoments() async {
    try {
      http.Response response = await _httpClient.get('user/post/getall');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getFollowingMoments(String id) async {
    try {
      http.Response response = await _httpClient.get('user/post/followingUser/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getById(String id) async {
    try {
      http.Response response = await _httpClient.get('user/post/getbyuserId/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> likePost(String id, String postId) async {
    try {
      http.Response response = await _httpClient.post('user/post/like/unlike',{
        "userId":id,
        "postId":postId
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> addPost(
      {required String id, required String path, required String caption, required String token}) async {
    try {
      http.Response response = await _httpClient.postMultipartFile('user/post/add',
          {
        'createdBy': id,
        'caption': caption
          },
          'images',
        path,
        bearerToken: token
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> reportUser(
      {required String id, required String message}) async {
    try {
      http.Response response = await _httpClient.post('user/userReport/add',
          {
            "userId": id,
            "message": message
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> makeComment(
      {required String id, required String postId, required String comment}) async {
    try {
      http.Response response = await _httpClient.post('user/post/addComment',{
        "userId":id,
        "postId":postId,
        "comment": comment
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteComment(
      {required String id, required String commentId}) async {
    try {
      http.Response response = await _httpClient.delete('user/post/deleteComment',{
        "userId": id,
        "commentId": commentId
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }


}
