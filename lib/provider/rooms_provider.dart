import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/user_data_model.dart';
import 'package:live_app/data/repository/moments_repo.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/rooms/live_room.dart';
import 'package:live_app/utils/constants.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/create_room_model.dart';
import '../data/model/response/rooms_model.dart';
import '../data/repository/rooms_repo.dart';
import '../data/repository/user_data_repo.dart';

class RoomsProvider with ChangeNotifier {
  final storageService = StorageService();
  final RoomsRepo _roomsRepo = RoomsRepo();
  RoomsModel _recentRooms = RoomsModel(status: 1,message: '',data:[]);

  RoomsModel? _myRoom ;
  RoomsModel? get myRoom => _myRoom;
  set myRoom(RoomsModel? value) {
    _myRoom = value;
    notifyListeners();
  }

  bool creatingRoom = false;

  Future<CreateRoomModel> create(String name, String? path) async {
    creatingRoom = true;
    notifyListeners();
    final apiResponse = await _roomsRepo.create(storageService.getString(Constants.id),name,path);
    CreateRoomModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = createRoomModelFromJson(apiResponse.body);
    } else {
      responseModel = CreateRoomModel(status: 0,message: apiResponse.reasonPhrase);
    }
    getAllMine();
    creatingRoom = false;
    notifyListeners();
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

  joinRoom(Room room) async {
    if((_recentRooms.data!.where((e) => e.id == room.id)).isNotEmpty){
      _recentRooms.data!.removeWhere((e) => e.id == room.id);
      _recentRooms.data!.add(room);
    }else{
      _recentRooms.data!.add(room);
    }
    while (_recentRooms.data!.length > 10) {
      _recentRooms.data!.removeAt(0);
    }
    storageService.setString(Constants.recentRooms, roomsModelToJson(_recentRooms));
    final provider = Provider.of<ZegoRoomProvider>(Get.context!,listen: false);
    provider.room = room;
    provider.roomID = room.roomId!;
    Get.to(() => const LiveRoom());
    getAllRecent(refresh: true);
  }

  Future<CommonModel> delete(String roomId) async {
    final apiResponse = await _roomsRepo.delete(roomId);
    CommonModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = commonModelFromJson(apiResponse.body);
    } else {
      responseModel = CommonModel(status: 0,message: apiResponse.reasonPhrase);
    }
    getAllMine();
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

  Future<RoomsModel> getAllRecent({bool? refresh}) async {
    _recentRooms = roomsModelFromJson(storageService.getString(Constants.recentRooms,defaultValue: roomsModelToJson(RoomsModel(status: 1,message: 'empty',data:[]))));
    if(refresh==true) notifyListeners();
    return _recentRooms;
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

  Future<RoomsModel> getAllPopular() async {
    final apiResponse = await _roomsRepo.getAllPopular();
    RoomsModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);
    } else {
      responseModel = RoomsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

  Future<RoomsModel> getAllNew() async {
    final apiResponse = await _roomsRepo.getAllNew();
    RoomsModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);
    } else {
      responseModel = RoomsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    return responseModel;
  }

}
