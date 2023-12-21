import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/room/widget/pre_loading_dailog.dart';
import 'package:live_app/utils/constants.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/body/zego_room_model.dart';
import '../data/model/response/common_model.dart';
import '../data/model/response/create_room_model.dart';
import '../data/model/response/rooms_model.dart';
import '../data/repository/rooms_repo.dart';

class RoomsProvider with ChangeNotifier {
  final storageService = StorageService();
  final RoomsRepo _roomsRepo = RoomsRepo();

  RoomsModel? _myRoom;
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

  Future<Room?> getRoom(String roomId) async {
    final apiResponse = await _roomsRepo.getRoom(roomId);
    Room? responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = Room.fromJson(jsonDecode(apiResponse.body)['data']);
    }
    return responseModel;
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

  joinRoom(Room room) async {
    final provider = Provider.of<ZegoRoomProvider>(Get.context!,listen: false);
    if(provider.room != null) await provider.destroy();
    bool isOwner = room.userId! == storageService.getString(Constants.id);
    provider.room = room;
    provider.roomID = room.roomId!;
    provider.isOwner = isOwner;
    provider.zegoRoom = ZegoRoomModel(totalSeats: room.noOfSeats??8,lockedSeats:[], viewCalculator: false);
    Get.dialog(const RoomPreLoadingDialog(),barrierDismissible: false);
  }

  Future<CommonModel> addRoomUser(String roomId) async {
    final apiResponse = await _roomsRepo.addUser(roomId,storageService.getString(Constants.id));
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

  Future<RoomsModel> getAllMyRecent({bool refresh = false}) async {
    final apiResponse = await _roomsRepo.getAllMyRecent(storageService.getString(Constants.id));
    RoomsModel responseModel;
    if (apiResponse.statusCode == 200) {
      responseModel = roomsModelFromJson(apiResponse.body);
    } else {
      responseModel = RoomsModel(status: 0,message: apiResponse.reasonPhrase);
    }
    if(refresh)notifyListeners();
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
