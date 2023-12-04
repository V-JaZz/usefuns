import 'package:http/http.dart' as http;

import '../datasource/remote/http/http_client.dart';

class ShopWalletRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> get(String type) async {
    try {
      http.Response response = await _httpClient.get('admin/$type/getall');
      return response;
    } catch (e) {
      return get(type);
    }
  }

  Future<http.Response> getDiamondValue() async {
    try {
      http.Response response = await _httpClient.get('admin/walletValue/getall');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> shop(
      {required String userId,required String product, required int amount, required String method}) async {
    try {
      http.Response response = await _httpClient.post(
        'user/shop',
          {
            "userId": userId,
            "product": "car",
            "shop_amount": amount,
            "shop_method": method
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
