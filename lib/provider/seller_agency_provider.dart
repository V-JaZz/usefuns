import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/common_model.dart';
import 'package:live_app/data/model/response/seller_record_model.dart';
import 'package:live_app/utils/common_widgets.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/seller_login_model.dart';
import '../data/repository/seller_agency_repo.dart';

class SellerAgencyProvider with ChangeNotifier {

  final storageService = StorageService();
  final SellerAgencyRepo _sellerAgencyRepo = SellerAgencyRepo();
  SellerLoginModel? seller;
  bool isSellerLogged = false;
  bool loadingUserRecharge = false;

  Future<void> loginSeller(String mobile,{bool refresh = true}) async {
    if(refresh) isSellerLogged = false;
    final apiResponse = await _sellerAgencyRepo.sellerLogin(int.parse(mobile.substring(mobile.length-10)));
    if(refresh) isSellerLogged = true;
    if(refresh) notifyListeners();
    if (apiResponse.statusCode == 200) {
      SellerLoginModel responseModel = sellerLoginModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        seller = responseModel;
      }
    } else {
      Get.back();
      showCustomSnackBar('Error! try again later', Get.context!, isToaster: true);
    }
    return ;
  }

  Future<CommonModel> rechargeUser(String userId, String amount) async {
    loadingUserRecharge = true;
    notifyListeners();
    final apiResponse = await _sellerAgencyRepo.rechargeUser(
        seller!.data!.id!,
        userId,
        int.tryParse(amount)??0
    );
    loadingUserRecharge = false;
    notifyListeners();
    CommonModel response;
    if (apiResponse.statusCode == 200) {
      response = commonModelFromJson(apiResponse.body);
      if(response.status != 1 && response.status == null){
        response = CommonModel(status: 0, message: 'Insufficient Balance!');
      }else{
        loginSeller(seller!.data!.mobile.toString(), refresh : false);
      }
    } else {
      response = CommonModel(status: 0, message: apiResponse.reasonPhrase);
    }
    return response;
  }

  Future<SellerRecordModel> getRecord() async {
    final apiResponse = await _sellerAgencyRepo.getRecord(seller!.data!.id!);
    SellerRecordModel response;
    if (apiResponse.statusCode == 200) {
      response = sellerRecordModelFromJson(apiResponse.body);
    } else {
      response = SellerRecordModel(status: 0, message: apiResponse.reasonPhrase);
    }
    return response;
  }

}
