import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_app/data/model/response/club_model.dart';
import 'package:live_app/utils/constants.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/repository/club_repo.dart';

class ClubProvider with ChangeNotifier {

  final storageService = StorageService();
  final ClubRepo _clubRepo = ClubRepo();
  ClubModel? allClubs;
  bool isCreating = false;

  Future<ClubModel> getAll() async {
    final apiResponse = await _clubRepo.getAll();
    ClubModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = clubModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        allClubs= responseModel;
      }
    } else {
      responseModel = ClubModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> join(String clubID) async {
    final apiResponse = await _clubRepo.join(storageService.getString(Constants.id),clubID);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> create(String name, String label, String path, String announcement) async {
    isCreating = true;
    notifyListeners();
    final apiResponse = await _clubRepo.create(
        id: storageService.getString(Constants.id),
        name: name,
        image: path,
        label: label,
        announcement: announcement);

    isCreating = false;
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

}
