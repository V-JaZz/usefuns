import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/shop_items_model.dart';
import 'package:live_app/data/model/response/user_data_model.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:live_app/utils/constants.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/diamond_value_model.dart';
import '../data/repository/shop_wallet_repo.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class ShopWalletProvider with ChangeNotifier {

  ShopWalletProvider() {
    _initializePurchaseStream();
    _initStoreInfo();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  final storageService = StorageService();
  final ShopWalletRepo _shopRepo = ShopWalletRepo();
  bool isBuying = false;
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


  //In-App-Purchase

  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails>? iapDiamondsList;
  bool iapAvailable = false;
  bool iapLoading = true;


  void _initializePurchaseStream() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // Handle error here
      showCustomSnackBar('purchase init error!', Get.context!,isToaster: true);
    });
  }

  Future<void> _initStoreInfo() async {
    iapAvailable = await _iap.isAvailable();
    if(iapAvailable){
      _fetchProductList();
    }
    iapLoading = false;
    notifyListeners();
  }

  void _fetchProductList() async {

    final diamondValue = await getDiamondValueList();
    Set<String> ids = diamondValue.map((e) => e.id!).toSet();

    final response = await _iap.queryProductDetails(ids);
    for (var element in response.notFoundIDs) {
      print('Purchase $element not found');
    }
    if(response.error == null){

    }else{
      print('Products fetch error');
    }

    iapDiamondsList = response.productDetails;
    notifyListeners();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((purchaseDetails) {
      switch(purchaseDetails.status){
        case PurchaseStatus.pending:
          showCustomDialog(
              'Purchase pending!',
            'Please wait few minutes in app until purchase finished.',
            Icons.access_time
          );
          break;
        case PurchaseStatus.error:
          showCustomDialog(
              'Purchase failed!',
              'Please try again.',
              Icons.cancel,
              icColor: Colors.red
          );
          break;
        case PurchaseStatus.purchased:
          rewardDiamonds(int.parse(iapDiamondsList!.firstWhere((e) => e.id == purchaseDetails.productID).title.split(' ').first));
          showCustomDialog(
              'Purchase Success!',
              null,
              Icons.check_circle,
              icColor: Colors.green
          );
          break;
        default:
          break;
      }
    });
  }

  Future<void> purchaseDiamonds(ProductDetails productDetails) async {
    PurchaseParam purchaseParam;

    purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );

    await _iap.buyConsumable(purchaseParam: purchaseParam);
  }



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

  Future<bool> buyItem(String type, int price, Items item, int days) async {
    isBuying = true;
    bool success = false;
    notifyListeners();
    DateTime validity = DateTime.now().add(Duration(days: days));
    final apiResponse = await _shopRepo.shop(
        userId: storageService.getString(Constants.id),
        item: UserItem(
            id: item.id,
            name: item.name,
            images: item.images,
            isDefault: item.isDefault,
            isOfficial: item.isOfficial,
            v: 0,
            validTill: validity
        ).toJson(),
        price: price,
        type: type);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status==1){
        await Provider.of<UserDataProvider>(Get.context!,listen: false).getUser(loading: false);
        success = true;
        notifyListeners();
      }else{
        success = false;
      }
    } else {
      success = false;
    }
    isBuying=false;
    notifyListeners();
    return success;
  }

  Future<void> rewardDiamonds(int diamonds) async {
    final apiResponse = await _shopRepo.shopDiamonds(
        userId: storageService.getString(Constants.id),
        diamonds: diamonds,
        price: 0,
        method: 'reward');
    if (apiResponse.statusCode == 200) {
      Provider.of<UserDataProvider>(Get.context!,listen: false).getUser(loading: false);
      showCustomSnackBar('$diamonds diamonds added to your wallet!', Get.context!,isError: false,isToaster: true);
    }
  }

  Future<List<DiamondValue>> getDiamondValueList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final apiResponse = await _shopRepo.getDiamondValue();
    if (apiResponse.statusCode == 200) {
      DiamondValueModel responseModel = diamondValueModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        return responseModel.data??[];
      }
    } else {
      showCustomSnackBar('Error Getting data!', Get.context!);
    }
    return [];
  }

  Future<bool> spendUserDiamonds(int diamonds) async {
    final apiResponse = await _shopRepo.spendUserDiamonds(
        userId: storageService.getString(Constants.userId),
        diamonds: diamonds);
    if (apiResponse.statusCode == 200) {
      CommonModel responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        Provider.of<UserDataProvider>(Get.context!,listen: false).getUser(loading: false);
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
        Provider.of<UserDataProvider>(Get.context!,listen: false).getUser(loading: false);
        showCustomSnackBar('Beans Converted!', Get.context!, isToaster: true, isError: false);
      }
    } else {
      showCustomSnackBar('Error Converting beans!', Get.context!);
    }
  }

}
