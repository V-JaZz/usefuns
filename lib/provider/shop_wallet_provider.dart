import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/shop_items_model.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:live_app/utils/constants.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/diamond_value_model.dart';
import '../data/repository/shop_wallet_repo.dart';

class ShopWalletProvider with ChangeNotifier {

  final storageService = StorageService();
  final ShopWalletRepo _shopRepo = ShopWalletRepo();

  bool isBuying = false;
  bool isWalletLoaded = false;

  double? loadingShopProgress = 0.0;
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
    await Future.delayed(const Duration(milliseconds: 500));
    await getCategory('frame');
    await getCategory('chatBubble');
    await getCategory('wallpaper');
    await getCategory('vehicle');
    await getCategory('relationship');
    await getCategory('specialId');
    await getCategory('lockRoom');
    await getCategory('extraSeat');
    if(loadingShopProgress!=null){
      loadingShopProgress = null;
      notifyListeners();
    }
  }

  Future<void> getCategory(String key) async {
    if(loadingShopProgress!=null){
      loadingShopProgress = loadingShopProgress! + 0.125;
      notifyListeners();
    }
    final apiResponse = await _shopRepo.get(key);
    if (apiResponse.statusCode == 200) {
      ShopItemsModel responseModel = shopItemsModelFromJson(apiResponse.body);
      if(responseModel.status == 1 && items[key]!=responseModel){
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

  Future<void> rewardDiamonds(int diamonds) async {
    final apiResponse = await _shopRepo.shopDiamonds(
        userId: storageService.getString(Constants.id),
        diamonds: diamonds,
        price: 0,
        method: 'reward');
    if (apiResponse.statusCode == 200) {
      Provider.of<UserDataProvider>(Get.context!,listen: false).getUser(refresh: false);
      showCustomSnackBar('$diamonds diamonds added to your wallet!', Get.context!,isError: false,isToaster: true);
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

  Future<bool> spendUserDiamonds(int diamonds) async {
    final apiResponse = await _shopRepo.spendUserDiamonds(
        userId: storageService.getString(Constants.userId),
        diamonds: diamonds);
    if (apiResponse.statusCode == 200) {
      CommonModel responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        Provider.of<UserDataProvider>(Get.context!,listen: false).getUser();
        return true;
      }
    }
    showCustomSnackBar('Error spending diamonds!', Get.context!);
    return false;
  }

  Future<void> convertBeans(int diamonds,int beans) async {
    final apiResponse = await _shopRepo.convertBeans(
        userId: storageService.getString(Constants.userId),
        diamonds: diamonds,
        beans: beans);
    if (apiResponse.statusCode == 200) {
      CommonModel responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        Provider.of<UserDataProvider>(Get.context!,listen: false).getUser();
        showCustomSnackBar('Beans Converted!', Get.context!, isToaster: true, isError: false);
      }
    } else {
      showCustomSnackBar('Error Converting beans!', Get.context!);
    }
  }

}
