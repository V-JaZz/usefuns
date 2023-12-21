import 'package:http/http.dart' as http;
import '../datasource/remote/http/http_client.dart';

class SellerAgencyRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  //seller
  Future<http.Response> sellerLogin(int number) async {
    try {
      http.Response response = await _httpClient.post('coinseller/loginmobile',
        {
          "mobile": number
        }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> rechargeUser(String sellerId, String userId, int amount) async {
    try {
      http.Response response = await _httpClient.post('coinseller/recharge/user',
          {
            "coinSellerId": sellerId,
            "userId": userId,
            "amount": amount
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getSellerRecord(String sellerId) async {
    try {
      http.Response response = await _httpClient
          .get('coinseller/rechargeHistory/getByAgentId/$sellerId');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //agency
  Future<http.Response> loginAgency(int number) async {
    try {
      http.Response response = await _httpClient.post('user/agency/loginmobile',
          {
            "mobile": number
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getHostList(String code) async {
    try {
      http.Response response = await _httpClient
          .get('host/getAllHostByAgencyCode/$code');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> inviteHost(String userId, String code) async {
    try {
      http.Response response = await _httpClient.post('host/sendRequest',
          {
            "userId": userId,
            "agency_code": code
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> addHost(String userId, String code) async {
    try {
      http.Response response = await _httpClient.post('host/add',
          {
            "userId": userId,
            "agency_code": code
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getHost(String uid) async {
    try {
      http.Response response = await _httpClient
          .get('host/getApprovedByid/$uid');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> deleteHost(String id) async {
    try {
      http.Response response = await _httpClient
          .delete('host/removeByid/$id',{});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
