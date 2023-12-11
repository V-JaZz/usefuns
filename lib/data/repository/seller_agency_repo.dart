import 'package:http/http.dart' as http;
import '../datasource/remote/http/http_client.dart';

class SellerAgencyRepo {

  final HttpApiClient _httpClient = HttpApiClient();

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

  Future<http.Response> getRecord(String sellerId) async {
    try {
      http.Response response = await _httpClient
          .get('coinseller/rechargeHistory/getByAgentId/$sellerId');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
