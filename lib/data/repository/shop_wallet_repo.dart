import 'package:http/http.dart' as http;

import '../datasource/remote/http/http_client.dart';

class ShopWalletRepo {

  final HttpApiClient _httpClient = HttpApiClient();

  Future<http.Response> getItems(String type) async {
    try {
      http.Response response = await _httpClient.get('admin/$type/getall');
      return response;
    } catch (e) {
      return getItems(type);
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
      {required String userId,required Map<String, dynamic> item, required int price, required String type}) async {
    try {
      http.Response response = await _httpClient.post(
        'user/shop',
          {
            "userId": userId,
            "item": item,
            "price": price,
            "itemType": type
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> shopDiamonds(
      {required String userId,required int diamonds, required int price, required String method, required String transactionId,required String status,}) async {
    try {
      http.Response response = await _httpClient.post(
          'user/wallet/add',
          {
            "userId": userId,
            "diamonds": diamonds,
            "payment_method": method,
            "price": price,
            "transactionId": transactionId,
            "status": status
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> diamondSubmitFlow(
      {required String userId,required int diamonds, required String uses,required int type}) async {
    try {
      http.Response response = await _httpClient.post(
          'user/diamondSubmitFlow',
          {
            "userId": userId,
            "diamonds": diamonds,
            "uses": uses,
            "type": type,
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> convertBeans(
      {required String userId,required int diamonds, required int beans}) async {
    try {
      http.Response response = await _httpClient.post(
          'user/beansToDiamonds/convert',
          {
            "userId": userId,
            "diamonds": diamonds,
            "beans": beans
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getRechargeHistory(
      {required String userId}) async {
    try {
      http.Response response = await _httpClient.get(
          'user/wallet/transaction/$userId'
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getDiamondHistory(
      {required String userId, required String type}) async {
    try {
      http.Response response = await _httpClient.post(
          'user/diamond/transaction/$userId',
          {
            "uses": type
          }
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
