import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../datasource/remote/http/http_client.dart';

class UserDataRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> getUserById(String id) async {
    try {
      http.Response response = await _httpClient.get('user/getbyid/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> updateUser(
      {required String? name,
        required String? email,
        required String? dob,
        required String? bio,
        required String? id,
        required String? token,
        String? image}) async {
    try {
      http.Response response = image == null || image == ''
          ? await _httpClient.postMultipart(
          'user/update/$id',
          {
            if(name!= null)'name': name,
            if(email!= null)"email": email,
            if(dob!= null)'dob': dob,
            if(bio!= null)'bio': bio
          },
          bearerToken: token,
        method: 'PUT'
      )
          :await _httpClient.postMultipartFile(
          'user/update/$id',
          {
            if(name!= null)'name': name,
            if(email!= null)"email": email,
            if(dob!= null)'dob': dob,
            if(bio!= null)'bio': bio
          },
          'images',
          image,
        bearerToken: token,
          method: 'PUT'
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
