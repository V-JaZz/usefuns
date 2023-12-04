import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/screens/dashboard/bottom_navigation.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../data/model/body/zego_broadcast_model.dart';
import '../data/model/body/zego_room_model.dart';
import '../data/model/body/zego_stream_model.dart';
import '../data/model/response/rooms_model.dart';
import '../data/model/response/user_data_model.dart';
import '../data/repository/rooms_repo.dart';
import '../screens/room/widget/seat_invitation.dart';
import '../utils/common_widgets.dart';
import '../utils/helper.dart';
import '../utils/zego_config.dart';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class ZegoRoomProvider with ChangeNotifier {
  final storageService = StorageService();
  final RoomsRepo _roomsRepo = RoomsRepo();

  // zego init
  Future<void> init() async {
    await createEngine();
    await loginRoom();
    setZegoEventCallback();
    _isMicOn = !await ZegoExpressEngine.instance.isMicrophoneMuted();
    _isSoundOn = !await ZegoExpressEngine.instance.isSpeakerMuted();
    // await ZegoExpressEngine.instance.startSoundLevelMonitor();
  }

  // zego dispose
  Future<void> destroy() async {
    Provider.of<RoomsProvider>(Get.context!,listen: false).removeRoomUser(_room!.id!);
    logoutRoom();
    destroyEngine();
    clearZegoEventCallback();
    roomUsersList = [];
    roomStreamList = [];
    broadcastMessageList?.clear();
    activeCount = 0;
    onSeat=false;
    isOwner = false;
    _room= null;
    zegoRoom = null;
  }

  //Variables
  bool isOwner = false;
  bool onSeat = false;
  late TickerProvider vsync;
  ZegoRoomModel? zegoRoom;
  String roomID = '';
  bool isMicrophonePermissionGranted = false;
  double treasureProgress = 0.0;
  int activeCount = 1;
  List<ZegoUser> roomUsersList = [];
  final scrollController = ScrollController();
  List<ZegoStreamExtended> roomStreamList = [];
  FixedLengthQueue? broadcastMessageList = FixedLengthQueue<ZegoBroadcastMessageInfo>(50);

  //Getter Setters
  Room? _room;
  Room? get room => _room;
  set room(Room? value) {
    _room = value;
    notifyListeners();
  }
  bool _isMicOn = false;
  bool get isMicOn => _isMicOn;
  set isMicOn(bool value) {
    _isMicOn = value;
    roomStreamList.where((e) => e.streamId == ZegoConfig.instance.streamID).first.micOn = value;
    notifyListeners();
    ZegoExpressEngine.instance.muteMicrophone(!value);
  }
  bool _isSoundOn = false;
  bool get isSoundOn => _isSoundOn;
  set isSoundOn(bool value) {
    _isSoundOn = value;
    notifyListeners();
    ZegoExpressEngine.instance.muteSpeaker(!value);
  }

  Future<void> createEngine() async {
    ZegoEngineProfile profile = ZegoEngineProfile(
        ZegoConfig.instance.appID, ZegoConfig.instance.scenario,
        enablePlatformView: ZegoConfig.instance.enablePlatformView,
        appSign: ZegoConfig.instance.appSign);

    await ZegoExpressEngine.createEngineWithProfile(profile);
  }
  Future<void> loginRoom() async {
    final zegoRoomConfig = ZegoRoomConfig(
        99, true, ZegoConfig.instance.token);

    ZegoUser user = ZegoUser(
        ZegoConfig.instance.userID,
        ZegoConfig.instance.userName.isEmpty
            ? ZegoConfig.instance.userID
            : ZegoConfig.instance.userName);

      await ZegoExpressEngine.instance.loginRoom(roomID, user,config: zegoRoomConfig );

    roomUsersList.add(ZegoUser(ZegoConfig.instance.userID,ZegoConfig.instance.userName));
    activeCount = roomUsersList.length;
  }
  Future<void> logoutRoom() async {
   await ZegoExpressEngine.instance.logoutRoom(roomID);
  }
  Future<void> startPublishingStream(int seat) async {
    if(roomStreamList.firstWhereOrNull((e) => e.seat == seat) == null) {
      final user = Provider.of<UserDataProvider>(Get.context!,listen: false).userData;
      final extraInfo = ZegoStreamExtended(vip: 0,id: user?.data?.userId ,owner: isOwner,age: AgeCalculator.calculateAge(user?.data?.dob??DateTime.now()),followers: user?.data?.followers?.length??0,gender: user?.data?.gender,level: user?.data?.level,streamId: ZegoConfig.instance.streamID,userName: ZegoConfig.instance.userName,image: user!.data!.images!.isNotEmpty ? (user.data?.images?.first??''):'',seat: seat,micOn: _isMicOn&&isMicrophonePermissionGranted);
      await ZegoExpressEngine.instance.setStreamExtraInfo(zegoStreamExtendedToJson(extraInfo));
      await ZegoExpressEngine.instance.startPublishingStream(ZegoConfig.instance.streamID);
      log('📤 Start publishing stream, streamID: ${ZegoConfig.instance.streamID}');
      roomStreamList.add(extraInfo);
      onSeat=true;
      notifyListeners();
    }else{
      showCustomSnackBar('Seat Already Occupied!', Get.context!, isToaster: true);
    }
  }
  Future<void> stopPublishingStream() async {
    await ZegoExpressEngine.instance.stopPublishingStream();
    roomStreamList.removeWhere((element) => element.streamId == ZegoConfig.instance.streamID);
    onSeat=false;
    notifyListeners();
  }
  Future<void> startPlayingStream(String streamID) async {
    Future<void> startPlayingStream(int viewID, String streamID) async {
      ZegoCanvas canvas = ZegoCanvas.view(viewID);
      await ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
    }
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      startPlayingStream(viewID, streamID);
    });
  }
  Future<void> stopPlayingStream(String streamID) async {
    await ZegoExpressEngine.instance.stopPlayingStream(streamID);
  }

  void destroyEngine() async {
    await ZegoExpressEngine.destroyEngine()
        .then((ret) => log('already destroy engine'));
  }

  //zego event callbacks
  void setZegoEventCallback() {

    ZegoExpressEngine.onRoomUserUpdate = (roomID, updateType, userList) {
      for (var e in userList) {
        var userID = e.userID;
        var userName = e.userName;
        if(updateType == ZegoUpdateType.Add){
          roomUsersList.add(e);
        }else if (updateType == ZegoUpdateType.Delete){
          roomUsersList.removeWhere((element) => element.userID == userID);
        }
        activeCount = roomUsersList.length;
        notifyListeners();
        log('🚩 🚪 Room user update, roomID: $roomID, updateType: $updateType userID: $userID userName: $userName');
      }
    };

    ZegoExpressEngine.onRoomStreamUpdate = ((roomID, updateType, streamList, extendedData) {
      for (var stream in streamList) {
        var streamID = stream.streamID;
        log('🚩 🚪 Room stream update, roomID: $roomID, updateType: $updateType streamID:$streamID');

        if (updateType == ZegoUpdateType.Add) {
          print('extraInfo11 ${stream.extraInfo}');
          final extraInfo = zegoStreamExtendedFromJson(stream.extraInfo);
          roomStreamList.add(extraInfo);
          startPlayingStream(streamID);
          notifyListeners();
        }else if(updateType == ZegoUpdateType.Delete){
          roomStreamList.removeWhere((element) => element.streamId == streamID);
          notifyListeners();
        }
      }
    });

    ZegoExpressEngine.onRoomExtraInfoUpdate = (String roomID, List<ZegoRoomExtraInfo> infoList) {
      print('🚩🚩🚩 onRoomExtraInfoUpdate');
      for (ZegoRoomExtraInfo i in infoList) {
        if(i.key == ZegoConfig.instance.roomKey){
          log("value: ${i.value}");
          zegoRoom = zegoRoomModelFromJson(i.value);
        }
      }
      notifyListeners();
    };

    ZegoExpressEngine.onRoomStreamExtraInfoUpdate = (roomID, streamList) {
      for (ZegoStream stream in streamList) {
        var streamID = stream.streamID;
        log('🚩 🚪 Streamer ExtraInfo update, roomID: $roomID, streamID:$streamID');
        roomStreamList[roomStreamList.indexWhere((e) => e.streamId == streamID)] = zegoStreamExtendedFromJson(stream.extraInfo);
      }
      notifyListeners();
    };

    ZegoExpressEngine.onIMRecvCustomCommand = (String roomID, ZegoUser fromUser, String command){
      print('🚩🚩🚩 onIMRecvCustomCommand');
        log(command);
        if(command == ZegoConfig.instance.roomResetCalculatorKey){
          for (ZegoStreamExtended user in roomStreamList) {
            user.points = 0;
          }
        }else if(command == ZegoConfig.instance.roomMuteSeatKey){
          roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.streamID).micPermit = false;
          showCustomSnackBar('Muted by ${fromUser.userName}', Get.context!,isToaster: true);
          notifyStreamExtraInfoUpdate();
          isMicOn = false;
        }else if(command == ZegoConfig.instance.roomUnMuteSeatKey){
          roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.streamID).micPermit = true;
          showCustomSnackBar('Unmuted by ${fromUser.userName}', Get.context!,isToaster: true,isError: false);
          notifyStreamExtraInfoUpdate();
        }else if(command == ZegoConfig.instance.roomLockSeatKey){
          stopPublishingStream();
          showCustomSnackBar('Locked by ${fromUser.userName}', Get.context!,isToaster: true);
        }else if(command == ZegoConfig.instance.roomBanChatKey){
          roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.streamID).chatBan = true;
          showCustomSnackBar('Banned Chat by ${fromUser.userName}', Get.context!,isToaster: true);
          notifyStreamExtraInfoUpdate();
        }else if(command == ZegoConfig.instance.roomUnBanChatKey){
          roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.streamID).chatBan = false;
          showCustomSnackBar('Unbanned Chat by ${fromUser.userName}', Get.context!,isToaster: true,isError: false);
          notifyStreamExtraInfoUpdate();
        }else if(command == ZegoConfig.instance.roomKickSeatKey){
          destroy();
          Get.offAll(const BottomNavigator(),transition: Transition.noTransition);
          showCustomSnackBar('Kicked by ${fromUser.userName}', Get.context!,isToaster: true);
        }else if(command.contains(ZegoConfig.instance.roomInviteSeatKey)){
          viewInviteToSeatDailog(command.substring(20),fromUser.userName);
        }
      notifyListeners();
    };

    ZegoExpressEngine.onIMRecvBroadcastMessage = (roomID, messageList) {
      print('🚪🚪 onIMRecvBroadcastMessage');
      for (var m in messageList) {
        // log('🚩  Broadcast message: ${m.message}, userName: ${m.fromUser.userName}');
        broadcastMessageList?.enqueue(m);
      }
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 500),(){
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
      });
    };

    ZegoExpressEngine.onIMRecvBarrageMessage = (roomID, messageList) async {
      print('🚪🚪 onIMRecvBarrageMessage');
      for (var m in messageList) {
        final controller = SVGAAnimationController(vsync: vsync);
        controller.videoItem = await SVGAParser.shared.decodeFromAssets(m.message);
        roomStreamList[roomStreamList.indexWhere((e) => e.streamId == m.fromUser.userID)].reactionController = controller;
        notifyListeners();
        roomStreamList[roomStreamList.indexWhere((e) => e.streamId == m.fromUser.userID)].reactionController
            ?.forward()
            .whenComplete(() {
              if(roomStreamList[roomStreamList.indexWhere((e) => e.streamId == m.fromUser.userID)].reactionController?.videoItem == controller.videoItem){
                roomStreamList[roomStreamList.indexWhere((e) => e.streamId == m.fromUser.userID)].reactionController?.dispose();
                roomStreamList[roomStreamList.indexWhere((e) => e.streamId == m.fromUser.userID)].reactionController = null;
                notifyListeners();
              }
        });
      }
    };

    ZegoExpressEngine.onRemoteMicStateUpdate = (String streamID,ZegoRemoteDeviceState state) {
      print('🚪🚪 onRemoteMicStateUpdate - $state');
      roomStreamList.where((e) => e.streamId == streamID).first.micOn = state == ZegoRemoteDeviceState.Open;
      notifyListeners();
    };

    // ZegoExpressEngine.onCapturedSoundLevelUpdate = (double soundLevel){
    //   print('local sl : $soundLevel');
    // };
    // ZegoExpressEngine.onRemoteSoundLevelUpdate = (Map<String, double> soundLevels){
    //   print('remote sl : $soundLevels');
    // };
  }

  void clearZegoEventCallback() {
    // ZegoExpressEngine.onCapturedSoundLevelUpdate = null;
    // ZegoExpressEngine.onRemoteSoundLevelUpdate = null;
    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onIMRecvCustomCommand = null;
    ZegoExpressEngine.onIMRecvBarrageMessage = null;
    ZegoExpressEngine.onIMRecvBroadcastMessage = null;
    ZegoExpressEngine.onRoomExtraInfoUpdate = null;
    ZegoExpressEngine.onRoomStreamExtraInfoUpdate = null;
    ZegoExpressEngine.onRemoteMicStateUpdate = null;
  }

  //room data update methods
  void notifyRoomUpdate(){
    ZegoExpressEngine.instance.setRoomExtraInfo(
        roomID,
        ZegoConfig.instance.roomKey,
        zegoRoomModelToJson(zegoRoom!)
    );
  }
  //notify stream user data update
  void notifyStreamExtraInfoUpdate(){
    final extraInfo =roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.streamID);
    ZegoExpressEngine.instance.setStreamExtraInfo(zegoStreamExtendedToJson(extraInfo));
  }
  void updateAdmin(List<String> list) {
    zegoRoom!.admins = list;
    notifyListeners();
    notifyRoomUpdate();
  }
  void updateTotalSeats(int total) {
    zegoRoom!.totalSeats = total;
    notifyListeners();
    notifyRoomUpdate();
  }
  void updateLockedSeats(List<int> locked) {
    zegoRoom!.lockedSeats = locked;
    notifyListeners();
    notifyRoomUpdate();
  }
  void updateViewCalculator() {
    zegoRoom!.viewCalculator = !zegoRoom!.viewCalculator;
    notifyListeners();
    notifyRoomUpdate();
  }

  //room callback commands
  void muteStreamer(String userID, String userName){
    ZegoExpressEngine.instance.sendCustomCommand(
      roomID,
      ZegoConfig.instance.roomMuteSeatKey,
      [ZegoUser(userID, userName)]
    );
  }
  void unMuteStreamer(String userID, String userName){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.roomUnMuteSeatKey,
        [ZegoUser(userID, userName)]
    );
  }
  void lockStreamer(String userID, String userName){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.roomLockSeatKey,
        [ZegoUser(userID, userName)]
    );
  }
  void banChat(String userID, String userName){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.roomBanChatKey,
        [ZegoUser(userID, userName)]
    );
  }
  void unbanChat(String userID, String userName){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.roomUnBanChatKey,
        [ZegoUser(userID, userName)]
    );
  }
  void kickStreamer(String userID, String userName){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.roomKickSeatKey,
        [ZegoUser(userID, userName)]
    );
  }
  void inviteSeat(String userID, String userName, String seat){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.roomInviteSeatKey+seat,
        [ZegoUser(userID, userName)]
    );
  }
  void resetCalculator(){
    for (ZegoStreamExtended user in roomStreamList) {
      user.points = 0;
    }
    notifyListeners();
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.roomResetCalculatorKey,
      []
    );
  }

  //broadcast and barrage methods
  void sendBroadcastMessage(String message) {
    final user = Provider.of<UserDataProvider>(Get.context!,listen: false).userData;
    String body = zegoBroadcastModelToJson(ZegoBroadcastModel(message: message,image: user!.data!.images!.isNotEmpty? user.data!.images!.first:null, level:user.data!.level,type: "message",tags: [if(isOwner)'Owner',if(zegoRoom!.admins.contains(ZegoConfig.instance.streamID))'Admin']));
    ZegoExpressEngine.instance.sendBroadcastMessage(roomID, body);
    broadcastMessageList?.enqueue(ZegoBroadcastMessageInfo(body,0,0,ZegoUser(ZegoConfig.instance.userID,ZegoConfig.instance.userName)));
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500),(){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
    });
  }
  void sendBroadcastGift(List<String> to, String giftPath, int count) {
    for (var receiver in to) {
      final user = Provider.of<UserDataProvider>(Get.context!,listen: false).userData;
      String body = zegoBroadcastModelToJson(ZegoBroadcastModel(image: user!.data!.images!.isNotEmpty? user.data!.images!.first:null, level:user.data!.level,type: "gift",gift: Gift(to: receiver,count: count,giftPath: giftPath),tags: [if(isOwner)'Owner',if(zegoRoom!.admins.contains(ZegoConfig.instance.streamID))'Admin']));
      ZegoExpressEngine.instance.sendBroadcastMessage(roomID, body);
      broadcastMessageList?.enqueue(ZegoBroadcastMessageInfo(body,0,0,ZegoUser(ZegoConfig.instance.userID,ZegoConfig.instance.userName)));
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 500),(){
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
      });
    }
  }
  void sendBarrageMessage(String message) {
    ZegoExpressEngine.instance.sendBarrageMessage(roomID, message);
  }

  Future<void> reactEmoji(String emoji) async {
    sendBarrageMessage(emoji);
    final controller = SVGAAnimationController(vsync: vsync);
    controller.videoItem = await SVGAParser.shared.decodeFromAssets(emoji);
    roomStreamList[roomStreamList.indexWhere((e) => e.streamId == ZegoConfig.instance.userID)].reactionController = controller;
    notifyListeners();
    roomStreamList[roomStreamList.indexWhere((e) => e.streamId == ZegoConfig.instance.userID)].reactionController
        ?.forward()
        .whenComplete(() {
          if(roomStreamList[roomStreamList.indexWhere((e) => e.streamId == ZegoConfig.instance.userID)].reactionController?.videoItem == controller.videoItem){
            roomStreamList[roomStreamList.indexWhere((e) => e.streamId == ZegoConfig.instance.userID)].reactionController?.dispose();
            roomStreamList[roomStreamList.indexWhere((e) => e.streamId == ZegoConfig.instance.userID)].reactionController = null;
            notifyListeners();
          }
      return;
    });
  }

  void addGreeting(String message, UserDataModel owner) {
    String body = zegoBroadcastModelToJson(ZegoBroadcastModel(message: message,image: owner.data!.images!.isNotEmpty? owner.data!.images!.first:null, level:owner.data!.level,type: "message",tags: ['Owner']));
    broadcastMessageList?.enqueue(ZegoBroadcastMessageInfo(body,0,0,ZegoUser(owner.data!.id!,owner.data!.name!)));
  }
}
