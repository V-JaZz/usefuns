import 'package:http/http.dart' as http;
import '../datasource/remote/http/http_client.dart';

class AuthRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> sendOtp(int phone) async {
    try {
      http.Response response = await _httpClient.post('user/getotp', {"mobile": phone});
      return response;
    } catch (e) {
      rethrow;
    }

  }

  Future<http.Response> gmailLogin(String gmail) async {
    try {
      http.Response response = await _httpClient.post('user/loginemail',
          {"email":gmail});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> login(int phone) async {
    try {
      http.Response response = await _httpClient.post('user/loginmobile', {"mobile": phone});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> register(
      {required String name,
        required int phone,
        required String dob,
        required String gender,
        required String countryCode,
      String? image}) async {
    try {
      http.Response response = image == null || image == ''
          ? await _httpClient.postMultipart(
          'user/register',
          {
            'name': name,
            "mobile": phone,
            'dob': dob,
            'gender': gender,
            'countryCode': countryCode
          })
      :await _httpClient.postMultipartFile(
          'user/register',
          {
            'name': name,
            "mobile": phone,
            'dob': dob,
            'gender': gender,
            'countryCode': countryCode
          },
          'images',
          image
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> logout(String id, String token) async {
    try {
      http.Response response = await _httpClient.post('user/logout/$id', {},bearerToken: token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
