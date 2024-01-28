import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/common_model.dart';
import 'package:live_app/data/model/response/seller_record_model.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/agency_host_model.dart';
import '../data/model/response/agency_login_model.dart';
import '../data/model/response/seller_login_model.dart';
import '../data/repository/seller_agency_repo.dart';

class SellerAgencyProvider with ChangeNotifier {
  final storageService = StorageService();
  final SellerAgencyRepo _sellerAgencyRepo = SellerAgencyRepo();

  //Seller
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
      }else{
        Get.back();
        showCustomSnackBar('Error! try again later', Get.context!, isToaster: true);
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

  Future<SellerRecordModel> getSellerRecord() async {
    final apiResponse = await _sellerAgencyRepo.getSellerRecord(seller!.data!.id!);
    SellerRecordModel response;
    if (apiResponse.statusCode == 200) {
      response = sellerRecordModelFromJson(apiResponse.body);
    } else {
      response = SellerRecordModel(status: 0, message: apiResponse.reasonPhrase);
    }
    return response;
  }

  //Agency
  AgencyLoginModel? agent;
  AgencyHostModel? hostList;
  HostData? host;
  bool isAgentLogged = false;
  bool isHostListLoaded = false;
  bool inviteRequestLoading = false;
  bool isHostLoaded = false;

  Future<void> loginAgency(String mobile,{bool refresh = true}) async {
    if(refresh) isAgentLogged = false;
    final apiResponse = await _sellerAgencyRepo.loginAgency(int.parse(mobile.substring(mobile.length-10)));
    if(refresh) isAgentLogged = true;
    if(refresh) notifyListeners();
    if (apiResponse.statusCode == 200) {
      AgencyLoginModel responseModel = agencyLoginModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        agent = responseModel;
      }else{
        Get.back();
        showCustomSnackBar('Error! try again later', Get.context!, isToaster: true);
      }
    } else {
      Get.back();
      showCustomSnackBar('Error! try again later', Get.context!, isToaster: true);
    }
    return ;
  }

  Future<void> getHostList() async {
    isHostListLoaded = false;
    final apiResponse = await _sellerAgencyRepo.getHostList(agent!.data!.code!);
    isHostListLoaded = true;
    notifyListeners();
    if (apiResponse.statusCode == 200) {
      hostList = agencyHostModelFromJson(apiResponse.body);
    } else {
      hostList = AgencyHostModel(status: 0, message: apiResponse.reasonPhrase);
    }
  }

  Future<void> inviteHost(String userId) async {
    inviteRequestLoading = true;
    notifyListeners();
    final apiResponse = await _sellerAgencyRepo.inviteHost(userId,agent!.data!.code!);
    if (apiResponse.statusCode == 200) {
      CommonModel responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        showCustomSnackBar('Request Sent!', Get.context!, isToaster: true, isError: false);
      }else{
        showCustomSnackBar(jsonDecode(apiResponse.body)['error'], Get.context!, isToaster: true);
      }
    } else {
      showCustomSnackBar('Error! try again later', Get.context!, isToaster: true);
    }
    inviteRequestLoading = false;
    notifyListeners();
    return ;
  }

  Future<CommonModel> addHost(String userId, String code) async {
    final apiResponse = await _sellerAgencyRepo.addHost(userId,code);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        showCustomSnackBar('Request Accepted!', Get.context!, isToaster: true, isError: false);
      }else{
        showCustomSnackBar('Error! ${responseModel.message}', Get.context!, isToaster: true);
      }
    } else {
      responseModel = CommonModel(status: 0);
      showCustomSnackBar('Error! try again later', Get.context!, isToaster: true);
    }
    return responseModel;
  }

  Future<void> getHostData(String uid) async {
    isHostLoaded = false;
    final apiResponse = await _sellerAgencyRepo.getHost(uid);
    isHostLoaded = true;
    notifyListeners();
    AgencyHostModel? model;
    HostData? data;
    if (apiResponse.statusCode == 200) {
      model = agencyHostModelFromJson(apiResponse.body);
      if(model.status == 1){
        host = model.data!.first;
      }
    }
  }

  Future<void> deleteHost(String hid) async {
    final apiResponse = await _sellerAgencyRepo.deleteHost(hid);
    CommonModel? model;
    if (apiResponse.statusCode == 200) {
      model = commonModelFromJson(apiResponse.body);
      if(model.status == 1){
        notifyListeners();
      }
    }
  }

}
