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
import '../screens/room/widget/seat_invitation.dart';
import '../screens/room/widget/unlock_treasure_box.dart';
import '../utils/common_widgets.dart';
import '../utils/helper.dart';
import '../utils/zego_config.dart';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'gifts_provider.dart';

class ZegoRoomProvider with ChangeNotifier {
  final storageService = StorageService();

  // zego init
  Future<void> init() async {
    await createEngine();
    await loginRoom();
    setZegoEventCallback();
    _isMicOn = !await ZegoExpressEngine.instance.isMicrophoneMuted();
    _isSoundOn = !await ZegoExpressEngine.instance.isSpeakerMuted();
    heartbeatJoin();
    // await ZegoExpressEngine.instance.startSoundLevelMonitor();
  }

  // zego dispose
  Future<void> destroy() async {
    await Provider.of<RoomsProvider>(Get.context!,listen: false).removeRoomUser(_room!.id!);
    await logoutRoom();
    clearZegoEventCallback();
    destroyEngine();
    heartBeat?.cancel();
    triggerTimer?.cancel();
    broadcastMessageList?.clear();
    foregroundSvgaController?.dispose();
    roomUsersList = [];
    roomStreamList = [];
    activeCount = 0;
    onSeat=false;
    isOwner = false;
    _room= null;
    zegoRoom = null;
    foregroundSvgaController = null;
    backgroundImage = null;
    foregroundImage = null;
    roomPassword = null;
    notifyListeners();
  }

  //Variables
  bool isOwner = false;
  bool onSeat = false;
  SVGAAnimationController? foregroundSvgaController;
  String? backgroundImage;
  String? foregroundImage;
  String? roomPassword;
  String roomCountry = '';
  late TickerProvider vsync;
  Timer? heartBeat;
  Timer? triggerTimer;
  ZegoRoomModel? zegoRoom;
  String roomID = '';
  bool isMicrophonePermissionGranted = false;
  double treasureProgress = 0.0;
  int activeCount = 1;
  String? newUser;
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
    roomStreamList.where((e) => e.streamId == ZegoConfig.instance.userID).first.micOn = value;
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
      final extraInfo = ZegoStreamExtended(vip: 0,id: user?.data?.userId ,owner: isOwner,age: AgeCalculator.calculateAge(user?.data?.dob??DateTime.now()),followers: user?.data?.followers?.length??0,gender: user?.data?.gender,level: user?.data?.level,streamId: ZegoConfig.instance.userID,userName: ZegoConfig.instance.userName,image: user!.data!.images!.isNotEmpty ? (user.data?.images?.first??''):'',seat: seat,micOn: _isMicOn&&isMicrophonePermissionGranted,frame: userFrameViewPath(user.data?.frame));
      await ZegoExpressEngine.instance.setStreamExtraInfo(zegoStreamExtendedToJson(extraInfo));
      await ZegoExpressEngine.instance.startPublishingStream(ZegoConfig.instance.userID);
      log('📤 Start publishing stream, streamID: ${ZegoConfig.instance.userID}');
      roomStreamList.add(extraInfo);
      onSeat=true;
      notifyListeners();
    }else{
      showCustomSnackBar('Seat Already Occupied!', Get.context!, isToaster: true);
    }
  }
  Future<void> stopPublishingStream() async {
    await ZegoExpressEngine.instance.stopPublishingStream();
    roomStreamList.removeWhere((element) => element.streamId == ZegoConfig.instance.userID);
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
          newUser = '$userName joined!';
          Future.delayed(const Duration(seconds: 3),() {
            newUser = null;
            notifyListeners();
          });
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
          stopPlayingStream(streamID);
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
          roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID).micPermit = false;
          showCustomSnackBar('Muted by ${fromUser.userName}', Get.context!,isToaster: true);
          notifyStreamExtraInfoUpdate();
          isMicOn = false;
        }else if(command == ZegoConfig.instance.roomUnMuteSeatKey){
          roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID).micPermit = true;
          showCustomSnackBar('Unmuted by ${fromUser.userName}', Get.context!,isToaster: true,isError: false);
          notifyStreamExtraInfoUpdate();
        }else if(command == ZegoConfig.instance.roomLockSeatKey){
          stopPublishingStream();
          showCustomSnackBar('Locked by ${fromUser.userName}', Get.context!,isToaster: true);
        }else if(command == ZegoConfig.instance.roomBanChatKey){
          roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID).chatBan = true;
          showCustomSnackBar('Banned Chat by ${fromUser.userName}', Get.context!,isToaster: true);
          notifyStreamExtraInfoUpdate();
        }else if(command == ZegoConfig.instance.roomUnBanChatKey){
          roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID).chatBan = false;
          showCustomSnackBar('Unbanned Chat by ${fromUser.userName}', Get.context!,isToaster: true,isError: false);
          notifyStreamExtraInfoUpdate();
        }else if(command == ZegoConfig.instance.roomKickSeatKey){
          Get.offAll(const BottomNavigator(),transition: Transition.noTransition);
          destroy();
          showCustomSnackBar('Kicked by ${fromUser.userName}', Get.context!,isToaster: true);
        }else if(command.contains(ZegoConfig.instance.roomInviteSeatKey)){
          viewInviteToSeatDailog(command.substring(20),fromUser.userName);
        }else if(command.contains(ZegoConfig.instance.roomLockRoomUpdateKey)){
          if(command.length>25){
            roomPassword = command.substring(25);
            showCustomSnackBar('Room Lock Updated!', Get.context!,isToaster: true,isError: false);
          }else{
            roomPassword = null;
            showCustomSnackBar('Room Unlocked!', Get.context!,isToaster: true,isError: false);
          }
        }else if(command == ZegoConfig.instance.refreshAdminKey){
          refreshAdmins();
        }else if(command == ZegoConfig.instance.refreshTreasureKey){
          refreshTreasureBox();
        }
      notifyListeners();
    };

    ZegoExpressEngine.onIMRecvBroadcastMessage = (roomID, messageList) {
      print('🚪🚪 onIMRecvBroadcastMessage');
      for (var m in messageList) {
        // log('🚩  Broadcast message: ${m.message}, userName: ${m.fromUser.userName}');
        broadcastMessageList?.enqueue(m);
        final model = zegoBroadcastModelFromJson(m.message);
        if(model.type == 'gift'){
          updateRoomForeground(model.gift?.giftPath??'');
          if(model.gift?.toId == ZegoConfig.instance.userID){
            int points = (((model.gift?.count??1)*(model.gift?.giftPrice??1))*3).toInt();
            roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID).points = (roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID).points??0)+points;
            notifyStreamExtraInfoUpdate();
          }
        }
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
    final extraInfo = roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID);
    ZegoExpressEngine.instance.setStreamExtraInfo(zegoStreamExtendedToJson(extraInfo));
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
  void updateRoomLock(String? password){
    Provider.of<RoomsProvider>(Get.context!,listen:false).updateRoomLock(room!.id!,password: password);
    roomPassword = password;
    notifyListeners();
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        '${ZegoConfig.instance.roomLockRoomUpdateKey}${password??''}',
        []
    );
  }
  void updateSeat(int newSeat){
    if(roomStreamList.firstWhereOrNull((e) => e.seat == newSeat) == null) {
      roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID).seat = newSeat;
      notifyStreamExtraInfoUpdate();
      notifyListeners();
    }else{
      showCustomSnackBar('Seat Already Occupied!', Get.context!, isToaster: true);
    }
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
  void updateAdminList(){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.refreshAdminKey,
        []
    );
    refreshAdmins();
  }
  void updateTreasureBox(){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.refreshTreasureKey,
        []
    );
    refreshTreasureBox();
  }

  //broadcast and barrage methods
  void sendBroadcastMessage(String message) {
    final user = Provider.of<UserDataProvider>(Get.context!,listen: false).userData;
    String body = zegoBroadcastModelToJson(ZegoBroadcastModel(message: message,image: user!.data!.images!.isNotEmpty? user.data!.images!.first:null, level:user.data!.level,type: "message",tags: [if(isOwner)'Owner',if(room!.admin!.contains(ZegoConfig.instance.userID))'Admin']));
    ZegoExpressEngine.instance.sendBroadcastMessage(roomID, body);
    broadcastMessageList?.enqueue(ZegoBroadcastMessageInfo(body,0,0,ZegoUser(ZegoConfig.instance.userID,ZegoConfig.instance.userName)));
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500),(){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
    });
  }
  Future<void> sendBroadcastGift(List<String> toName, String thumbnailPath, String giftPath, int giftPrice, int count) async {
    for (var receiverName in toName) {
      final user = Provider.of<UserDataProvider>(Get.context!,listen: false).userData;
      String body = zegoBroadcastModelToJson(ZegoBroadcastModel(image: user!.data!.images!.isNotEmpty? user.data!.images!.first:null, level:user.data!.level,type: "gift",gift: ZegoGift(toName: receiverName,count: count,thumbnailPath: thumbnailPath, giftPath: giftPath, toId: roomUsersList.firstWhere((e) => e.userName == receiverName).userID,giftPrice: giftPrice),tags: [if(isOwner)'Owner',if(room!.admin!.contains(ZegoConfig.instance.userID))'Admin']));
      ZegoExpressEngine.instance.sendBroadcastMessage(roomID, body);
      broadcastMessageList?.enqueue(ZegoBroadcastMessageInfo(body,0,0,ZegoUser(ZegoConfig.instance.userID,ZegoConfig.instance.userName)));
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 500),(){
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
      });
      await updateRoomForeground(giftPath);
    }
  }
  void sendBarrageMessage(String message) {
    ZegoExpressEngine.instance.sendBarrageMessage(roomID, message);
  }

  Future<void> updateRoomForeground(String url) async {
    if(url.split('.').last.toLowerCase() == 'svga'){
          foregroundSvgaController = SVGAAnimationController(vsync: vsync);
          foregroundSvgaController?.videoItem = await SVGAParser.shared.decodeFromURL(url);
          notifyListeners();
          await foregroundSvgaController?.forward();
          foregroundSvgaController?.dispose();
          foregroundSvgaController = null;
          notifyListeners();

    }else{
        foregroundImage = url;
        notifyListeners();
        await Future.delayed(const Duration(seconds: 3),() {
          foregroundImage = null;
          notifyListeners();
        });
        await Future.delayed(const Duration(seconds: 1));
    }
    return;
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

  Future<void> refreshTreasureBox() async {

    final data = await Provider.of<RoomsProvider>(Get.context!,listen: false).getTreasureBox(room!.id!);
      if(data!=null) {
        int newLevel = data.treasureBoxLevel!;
        if(room!.treasureBoxLevel!<newLevel){
          do{
            room!.treasureBoxLevel = room!.treasureBoxLevel!+1;
            room = room?.copyWith(usedDaimonds: data.usedDaimonds, totalDiamonds: data.totalDiamonds);
            await Get.dialog(
                UnlockTreasureBox(level: room!.treasureBoxLevel!),
                barrierDismissible: false,
              barrierColor: Colors.transparent
            );
          }while(room!.treasureBoxLevel!<newLevel);
        }
        room = room?.copyWith(treasureBoxLevel: newLevel, usedDaimonds: data.usedDaimonds, totalDiamonds: data.totalDiamonds);
      }
    Provider.of<GiftsProvider>(Get.context!,listen: false).getAllContribution(room!.id!);
  }

  Future<void> refreshAdmins() async {
    final data = await Provider.of<RoomsProvider>(Get.context!,listen: false).getAdmins(room!.id!);
    if(data!=null) room = room?.copyWith(admin: data.admin);
  }

  void heartbeatJoin(){

    DateTime now = DateTime.now();
    int currentMinute = now.minute;

    // Calculate the delay until the next multiple of 5 minutes
    int delayInMinutes = 5 - (currentMinute % 5);

    // Calculate the target time for triggering the function
    DateTime targetTime = now.add(Duration(minutes: delayInMinutes));
    targetTime = DateTime(targetTime.year, targetTime.month, targetTime.day,
        targetTime.hour, targetTime.minute, 1);

    // Use Future.delayed to execute the function at the calculated time
    Duration delay = targetTime.difference(now);
    triggerTimer = Timer(delay, () {
      // Check if the minute is still a multiple of 5 to ensure accuracy
      DateTime currentTime = DateTime.now();
      // Perform your action here
      log('Function triggered at ${currentTime.hour}:${currentTime.minute}:${currentTime.second}');
      // Call your function here
      Provider.of<RoomsProvider>(Get.context!,listen: false).addRoomUser(room!.id!,password: roomPassword);
      heartBeat = Timer.periodic(const Duration(minutes: 5), (timer) {
        Provider.of<RoomsProvider>(Get.context!,listen: false).addRoomUser(room!.id!,password: roomPassword);
      });
    });
  }
}
