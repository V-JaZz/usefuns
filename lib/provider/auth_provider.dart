import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_app/data/model/response/login_model.dart';
import 'package:live_app/data/repository/auth_repo.dart';
import 'package:live_app/utils/constants.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/register_model.dart';
import '../data/model/response/send_otp_model.dart';

class AuthProvider with ChangeNotifier {
  final storageService = StorageService();
  final AuthRepo _authRepo = AuthRepo();
  bool _isLoading = false;
  bool resend = false;
  bool get isLoading => _isLoading;
  String? mobile;
  String? otp;

  Future<SendOtpModel> sendOtp({bool? fromResend}) async {
    if(fromResend==true) resend = true;
    _isLoading = true;
    notifyListeners();
    final apiResponse = await _authRepo.sendOtp(mobile!);
    _isLoading = false;
    notifyListeners();
    SendOtpModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = sendOtpModelFromJson(apiResponse.body);
      otp = responseModel.data?.otp;
    } else {
      responseModel = SendOtpModel(status: 0,message: apiResponse.reasonPhrase);
    }
    notifyListeners();
    return responseModel;
  }

  Future<LoginModel> login() async {
    _isLoading = true;
    notifyListeners();
    final apiResponse = await _authRepo.login(mobile!);
    _isLoading = false;
    notifyListeners();
    LoginModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = loginModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        storageService.setString(Constants.id, responseModel.data!.id!);
        storageService.setString(Constants.userId, responseModel.data!.userId!);
        storageService.setString(Constants.token, responseModel.data!.token!);
      }
    } else {
      responseModel = LoginModel(status: 0,message: apiResponse.reasonPhrase);
    }
    notifyListeners();
    return responseModel;
  }

  Future<RegisterModel> register(
      {required String name,
        required String dob,
        required String gender,
        String? language,
        String? image}) async {
    _isLoading = true;
    notifyListeners();
    storageService.setString(Constants.language, language??'English');
    final apiResponse = await _authRepo.register(
        name: name,
        phone: mobile!,
        dob: dob,
        gender: gender,
      image: image
    );
    _isLoading = false;
    notifyListeners();
    RegisterModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = registerModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        storageService.setString(Constants.id, responseModel.data!.id!);
        storageService.setString(Constants.userId, responseModel.data!.userId!);
        storageService.setString(Constants.token, responseModel.data!.token!);
      }
    } else {
      responseModel = RegisterModel(status: 0,message: apiResponse.reasonPhrase);
    }
    notifyListeners();
    return responseModel;
  }

  Future<CommonModel> logout() async {
    _isLoading = true;
    notifyListeners();
    final apiResponse = await _authRepo.logout(storageService.getString(Constants.token));
    _isLoading = false;
    notifyListeners();
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        storageService.logout();
      }
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    notifyListeners();
    return responseModel;
  }
}
