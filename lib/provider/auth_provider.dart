import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/login_model.dart';
import 'package:live_app/data/repository/auth_repo.dart';
import 'package:live_app/utils/constants.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/register_model.dart';
import '../data/model/response/send_otp_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../screens/auth/login_screen.dart';
import '../utils/common_widgets.dart';

class AuthProvider with ChangeNotifier {
  final storageService = StorageService();
  final AuthRepo _authRepo = AuthRepo();
  bool _isLoading = false;
  bool resend = false;
  bool get isLoading => _isLoading;
  String? mobile;
  String? otp;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<LoginModel?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) return null;
  //
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final UserCredential authResult = await _auth.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //     final apiResponse = await _authRepo.gmailLogin(user?.email??'');
  //
  //     LoginModel responseModel;
  //     if (apiResponse.statusCode == 200) {
  //
  //       responseModel = loginModelFromJson(apiResponse.body);
  //       if(responseModel.status == 1){
  //         storageService.setString(Constants.id, responseModel.data!.id!);
  //         storageService.setString(Constants.userId, responseModel.data!.userId!);
  //         storageService.setString(Constants.token, responseModel.data!.token!);
  //       }
  //     } else {
  //       responseModel = LoginModel(status: 0,message: apiResponse.reasonPhrase);
  //     }
  //     return responseModel;
  //   } catch (e) {
  //     print("Google Sign-In Error: $e");
  //     return null;
  //   }
  // }

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
        storageService.setBool('NEW_USER',true);
      }
    } else {
      responseModel = RegisterModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> logout() async {
    _isLoading = true;
    notifyListeners();
    final apiResponse = await _authRepo.logout(storageService.getString(Constants.token));
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        await storageService.clearStorage();
        Get.offAll(()=>const LogInScreen());
      }else{
        showCustomSnackBar('Failed to logout!', Get.context!);
      }
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
