import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/common_model.dart';
import 'package:live_app/data/model/response/user_data_model.dart';
import 'package:live_app/utils/constants.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/repository/user_data_repo.dart';
import '../screens/auth/login_screen.dart';
import '../utils/zego_config.dart';

class UserDataProvider with ChangeNotifier {

  final storageService = StorageService();
  final UserDataRepo _userDataRepo = UserDataRepo();
  UserDataModel? userData;
  bool isUserDataLoading = true;

  Future<UserDataModel> getUser({bool refresh = true, String? id,bool isUsefunId = false}) async {
    if(!isUserDataLoading&&id==null) {
      isUserDataLoading= true;
      if(refresh)notifyListeners();
    }
    final apiResponse = await _userDataRepo.getUserById(id??storageService.getString(Constants.id),isUsefunId);
    if(id==null){
      isUserDataLoading = false;
      notifyListeners();
    }
    UserDataModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = userDataModelFromJson(apiResponse.body);
      if(responseModel.status == 1 && id==null){
        userData= responseModel;
        ZegoConfig.instance.userID = userData!.data!.id!;
        ZegoConfig.instance.streamID = userData!.data!.id!;
        ZegoConfig.instance.userName = userData!.data!.name!;
      }else if(id==null){
        storageService.logout();
        Get.to(const LogInScreen());
      }
    } else {
      responseModel = UserDataModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> updateUser(
      {required String name,
        required String dob,
        required String? email,
        required String? bio,
        String? image}) async {
    isUserDataLoading = true;
    notifyListeners();
    final apiResponse = await _userDataRepo.updateUser(
        name: name,
        email: email,
        dob: dob,
        bio: bio,
        image: image,
        id: storageService.getString(Constants.id),
        token: storageService.getString(Constants.token)
    );
    isUserDataLoading = false;
    notifyListeners();
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        getUser();
      }
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future <UserDataModel> addVisitor(String id) async {
    final apiResponse = await _userDataRepo.addVisitor(id);
    UserDataModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = userDataModelFromJson(apiResponse.body);
    } else {
      responseModel = UserDataModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

}
