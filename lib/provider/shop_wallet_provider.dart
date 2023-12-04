import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/shop_items_model.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:live_app/utils/constants.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/diamond_value_model.dart';
import '../data/repository/shop_wallet_repo.dart';

class ShopWalletProvider with ChangeNotifier {

  final storageService = StorageService();
  final ShopWalletRepo _shopRepo = ShopWalletRepo();

  bool isBuying = false;
  bool isShopLoaded = false;
  bool isWalletLoaded = false;

  double loadingShopProgress = 0.0;

  late Map<String , ShopItemsModel?> items = {
    'frame':null,
    'chatBubble':null,
    'wallpaper':null,
    'vehicle':null,
    'relationship':null,
    'specialId':null,
    'lockRoom':null,
    'extraSeat':null,
  };
  List<DiamondValue>? diamondValueList;

  Future<void> getAll() async {
    isShopLoaded = false;
    await Future.delayed(const Duration(milliseconds: 500));
    await getCategory('frame');
    await getCategory('chatBubble');
    await getCategory('wallpaper');
    await getCategory('vehicle');
    await getCategory('relationship');
    await getCategory('specialId');
    await getCategory('lockRoom');
    await getCategory('extraSeat');
    isShopLoaded = true;
    loadingShopProgress = 0.0;
    notifyListeners();
  }

  Future<void> getCategory(String key) async {
    loadingShopProgress = loadingShopProgress + 0.125;
    notifyListeners();
    final apiResponse = await _shopRepo.get(key);
    if (apiResponse.statusCode == 200) {
      ShopItemsModel responseModel = shopItemsModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        items[key] = responseModel;
      }
    } else {
      showCustomSnackBar('Error Getting $key data!', Get.context!);
    }
  }

  Future<CommonModel> buy(String product, int amount) async {
    isBuying = true;
    notifyListeners();
    final apiResponse = await _shopRepo.shop(
        userId: storageService.getString(Constants.id),
        product: product,
        amount: amount,
        method: 'diamonds');

    isBuying = false;
    notifyListeners();
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status==1){
        return responseModel;
      }else{
        return responseModel;
      }
    } else {
      return CommonModel(status: 0,message: 'error');
    }
  }

  Future<void> getDiamondValueList() async {
    isWalletLoaded = false;
    await Future.delayed(const Duration(milliseconds: 500));
    final apiResponse = await _shopRepo.getDiamondValue();
    if (apiResponse.statusCode == 200) {
      DiamondValueModel responseModel = diamondValueModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        diamondValueList = responseModel.data;
      }
    } else {
      showCustomSnackBar('Error Getting data!', Get.context!);
    }
    isWalletLoaded = true;
    notifyListeners();
  }

}
