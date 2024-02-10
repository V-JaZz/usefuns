import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/constants.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/bannner_model.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/create_room_model.dart';
import '../data/model/response/rooms_model.dart';
import '../data/repository/rooms_repo.dart';
import '../utils/common_widgets.dart';

class RoomsProvider with ChangeNotifier {
  final storageService = StorageService();
  final RoomsRepo _roomsRepo = RoomsRepo();

  RoomsModel? _myRoom;
  List<Room> newRooms = [];
  List<Room> popularRooms = [];
  List<Room> recentRooms = [];

  bool roomLoading = true;

  String _selectedCountryCode = 'all';
  String get selectedCountryCode => _selectedCountryCode;
  set selectedCountryCode(String value) {
    _selectedCountryCode = value;
    notifyListeners();
  }


  RoomsModel? get myRoom {
    if(_myRoom == null) getAllMine();
    return _myRoom;
  }
  set myRoom(RoomsModel? value) {
    _myRoom = value;
    notifyListeners();
  }
  List<BannerData> bannerList = [];
  bool creatingRoom = false;

  //Room
  Future<CreateRoomModel> create(String name, String? path) async {
    creatingRoom = true;
    notifyListeners();
    final apiResponse = await _roomsRepo.create(storageService.getString(Constants.id),name,path);
    CreateRoomModel responseModel;
    creatingRoom = false;
    notifyListeners();
    if (apiResponse.statusCode == 200) {
      responseModel = createRoomModelFromJson(apiResponse.body);
      getAllMine();
    } else {
      responseModel = CreateRoomModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<Room?> getRoomByRoomId(String roomId) async {
    final apiResponse = await _roomsRepo.getRoomByRoomId(roomId);
    Room? responseModel;
    if (apiResponse.statusCode == 200) {
      try{
        responseModel = Room.fromJson(jsonDecode(apiResponse.body)['data']);
      }catch(e){
        responseModel = null;
      }
    }
    return responseModel;
  }

  Future<Room?> getRoomById(String id) async {
    final apiResponse = await _roomsRepo.getRoomById(id);
    Room? responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = Room.fromJson(jsonDecode(apiResponse.body)['data']);
    }
    return responseModel;
  }

  Future<void> getBannerList() async {
    final apiResponse = await _roomsRepo.getBannerList();
    if (apiResponse.statusCode == 200) {
      bannerList = bannerDataModelFromJson(apiResponse.body).data??[];
      notifyListeners();
    }
  }

  Future<Room?> getAdmins(String roomId) async {
    final apiResponse = await _roomsRepo.getAdmins(roomId);
    Room? responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = Room.fromJson(jsonDecode(apiResponse.body)['data']);
    }
    return responseModel;
  }

  Future<Room?> getTreasureBox(String roomId) async {
    final apiResponse = await _roomsRepo.getTreasureBox(roomId);
    Room? responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = Room.fromJson(jsonDecode(apiResponse.body)['data']);
    }
    return responseModel;
  }

  Future<CommonModel> updateRoomLock(String roomId, {String? password}) async {
    final apiResponse = password==null
        ? await _roomsRepo.unlockRoom(roomId,storageService.getString(Constants.id),storageService.getString(Constants.token))
        : await _roomsRepo.lockRoom(roomId,storageService.getString(Constants.id), password,storageService.getString(Constants.token));
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      showCustomSnackBar('Room Lock Updated!', Get.context!,isToaster: true,isError: false);
      responseModel = commonModelFromJson(apiResponse.body);
      getAllMine();
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> updateRoomTotalSeats(String roomId, int totalSeats) async {
    final apiResponse = await _roomsRepo.updateRoomTotalSeats(roomId, totalSeats);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      showCustomSnackBar('Extra Seat Updated!', Get.context!,isToaster: true,isError: false);
      responseModel = commonModelFromJson(apiResponse.body);
      getAllMine();
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> addRoomUser(String roomId, {String? password}) async {
    final apiResponse = password==null
        ? await _roomsRepo.addUser(roomId,storageService.getString(Constants.id))
        : await _roomsRepo.addUserLocked(roomId,storageService.getString(Constants.id), password);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> removeRoomUser(String roomId) async {
    final apiResponse = await _roomsRepo.removeUser(roomId,storageService.getString(Constants.id));
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> updateName(String roomId, String name) async {
    final apiResponse = await _roomsRepo.updateName(roomId, name);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> updatePicture(String roomId, String path, String name) async {
    final apiResponse = await _roomsRepo.updatePicture(roomId, path, name);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> addAnnouncement(String roomId, String name) async {
    final apiResponse = await _roomsRepo.addAnnouncement(storageService.getString(Constants.id),roomId, name);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> addAdmin(String roomId, String userId) async {
    final apiResponse = await _roomsRepo.addAdmin(roomId,userId);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<CommonModel> removeAdmin(String roomId, String userId) async {
    final apiResponse = await _roomsRepo.removeAdmin(roomId,userId);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<void> getAllMine() async {
    final apiResponse = await _roomsRepo.getAllMine(storageService.getString(Constants.id));
    RoomsModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);
    } else {
      responseModel = RoomsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    _myRoom = responseModel;
    notifyListeners();
  }

  Future<RoomsModel> getAllMyRecent() async {
    final apiResponse = await _roomsRepo.getAllMyRecent(storageService.getString(Constants.id));
    RoomsModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);
    } else {
      responseModel = RoomsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    recentRooms = responseModel.data??[];
    return responseModel;
  }

  Future<RoomsModel> getAllFollowingByMe() async {
    final apiResponse = await _roomsRepo.getAllFollowingByMe(storageService.getString(Constants.id));
    RoomsModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);
    } else {
      responseModel = RoomsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<RoomsModel> getAllGroups() async {
    final apiResponse = await _roomsRepo.getAllGroups(storageService.getString(Constants.id));
    RoomsModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);
    } else {
      responseModel = RoomsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<bool> getAllPopular(bool refresh) async {
    if(refresh){
      roomLoading = true;
      notifyListeners();
    }
    final apiResponse = await _roomsRepo.getAllPopular(selectedCountryCode, 1, 30);
    RoomsModel responseModel;

    roomLoading = false;
    if(refresh) notifyListeners();

    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);

      if(responseModel.status == 1){
        popularRooms = responseModel.data??[];
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> getAllNew(bool refresh) async {
    if(newRooms.isEmpty) roomLoading = true;
    if(refresh){
      notifyListeners();
    }
    final apiResponse = await _roomsRepo.getAllNew(selectedCountryCode, 1, 30);
    RoomsModel responseModel;

    roomLoading = false;
    if(refresh) notifyListeners();

    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);
      if(responseModel.status == 1){
        newRooms = responseModel.data??[];
        notifyListeners();
        return true;
      }
    }
    return false;
  }
}
