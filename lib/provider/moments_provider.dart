import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_app/data/repository/moments_repo.dart';
import 'package:live_app/utils/constants.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/moments_model.dart';

class MomentsProvider with ChangeNotifier {

  final storageService = StorageService();
  final MomentsRepo _momentsRepo = MomentsRepo();

  MomentsModel? allMoments;
  MomentsModel? followingMoments;
  MomentsModel? myMoments;
  bool isLoadedFollowing = false;
  bool isLoadedAll = false;
  bool _isLoadedMy = false;
  bool get isLoadedMy => _isLoadedMy;
  bool emptyFollowings = true;
  bool isPosting = false;
  bool isCommenting = false;
  bool isDeletingComment = false;

  Future<MomentsModel> getAllMoments({bool refresh = false}) async {
    isLoadedAll = false;
    if(refresh) notifyListeners();
    final apiResponse = await _momentsRepo.getAllMoments();
    MomentsModel responseModel;
    if (apiResponse.statusCode == 200) {
      isLoadedAll = true;
      notifyListeners();
      responseModel = momentsModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        allMoments= responseModel;
      }
    } else {
      responseModel = MomentsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    notifyListeners();
    return responseModel;
  }

  Future<MomentsModel> getFollowingMoments({bool refresh = false}) async {
    isLoadedFollowing = false;
    if(refresh) notifyListeners();
    final apiResponse = await _momentsRepo.getFollowingMoments(storageService.getString(Constants.id));
    MomentsModel responseModel;
    if (apiResponse.statusCode == 200) {
      isLoadedFollowing = true;
      notifyListeners();
      responseModel = momentsModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        followingMoments= responseModel;
      }
    } else {
      responseModel = MomentsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    notifyListeners();
    return responseModel;
  }

  Future<MomentsModel> getById({String? id}) async {
    final apiResponse = await _momentsRepo.getById(id??storageService.getString(Constants.id));

    MomentsModel responseModel;
    if (apiResponse.statusCode == 200) {
      _isLoadedMy = true;
      notifyListeners();
      responseModel = momentsModelFromJson(apiResponse.body);
      if(responseModel.status == 1 && id==null){
        myMoments= responseModel;
      }
    } else {
      responseModel = MomentsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    notifyListeners();
    return responseModel;
  }

  Future<CommonModel> addPost(String path, String? caption) async {
    isPosting = true;
    notifyListeners();
    final apiResponse = await _momentsRepo.addPost(id: storageService.getString(Constants.id),caption: caption??'',path: path,token: storageService.getString(Constants.token));

    isPosting = false;
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

  likePost(String postId, {bool? all, bool? following}) async {

    final apiResponse = await _momentsRepo.likePost(storageService.getString(Constants.id),postId);

    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
        if(all==true){
        getAllMoments();
      }else if(following==true){
        getFollowingMoments();
      }else{
        getById();
      }
    } else {
      log('error');
    }
  }

  bool checkLike(int index, {bool? all, bool? following}) {
    MomentsModel? moments;
    bool liked;
    if(all==true){
      moments = allMoments;
    }else if(following==true){
      moments = followingMoments;
    }else{
      moments = myMoments;
    }
    try{
    liked = moments!.data![index].likes!.contains(moments.data![index].likes!.where((element) => element.userId!.where((element) => element.id == storageService.getString(Constants.id)).isNotEmpty).first);
    }catch(e){
      liked = false;
    }
    return liked;
  }

  Future<CommonModel> reportUser({required String id, required String message}) async {

    final apiResponse = await _momentsRepo.reportUser(id: id,message: message);

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

  Future<bool> makeComment (int index, String postId, String comment, {bool? all, bool? following}) async {
    isCommenting = true;
    notifyListeners();
    final apiResponse = await _momentsRepo.makeComment(postId: postId,id: storageService.getString(Constants.id),comment: comment);

    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
      if(all==true){
        getAllMoments();
      }else if(following==true){
        getFollowingMoments();
      }else{
        getById();
      }
      isCommenting = false;
      notifyListeners();
      return true;
    } else {
      log('error');
      isCommenting = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteComment (int index, String postId, String commentId, {bool? all, bool? following}) async {
    isDeletingComment = true;
    notifyListeners();
    final apiResponse = await _momentsRepo.deleteComment(id: storageService.getString(Constants.id),commentId: commentId);

    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
      if(all==true){
        getAllMoments();
      }else if(following==true){
        getFollowingMoments();
      }else{
        getById();
      }
      isDeletingComment = false;
      notifyListeners();
      return true;
    } else {
      log('error');
      isDeletingComment = false;
      notifyListeners();
      return false;
    }
  }

}
