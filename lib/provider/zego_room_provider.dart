import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/screens/dashboard/bottom_navigation.dart';
import 'package:on_audio_query/on_audio_query.dart';
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
    if(mediaPlayer!=null) ZegoExpressEngine.instance.destroyMediaPlayer(mediaPlayer!);
    clearZegoEventCallback();
    destroyEngine();
    Provider.of<GiftsProvider>(Get.context!,listen: false).clearContribution();
    heartBeat?.cancel();
    triggerTimer?.cancel();
    broadcastMessageList?.clear();
    for(var z in roomStreamList) {
      z.reactionController?.stop();
      z.reactionController?.dispose();
    }
    entryEffectController?.stop();
    entryEffectController?.dispose();
    foregroundSvgaController?.stop();
    foregroundSvgaController?.dispose();
    savedUsersData = [];
    roomUsersList = [];
    roomStreamList = [];
    chatBan = false;
    minimized = false;
    initLoading = true;
    mediaPlayer = null;
    activeCount = 0;
    onSeat=false;
    isOwner = false;
    _room= null;
    _loadedTrack = null;
    zegoRoom = null;
    foregroundSvgaController = null;
    entryEffectController = null;
    backgroundImage = null;
    foregroundImage = null;
    roomPassword = null;
    notifyListeners();
  }

  //Variables
  bool isOwner = false;
  bool onSeat = false;

  bool initLoading = true;

  bool isMicrophonePermissionGranted = false;
  ZegoRoomModel? zegoRoom;
  String? roomPassword;
  Timer? heartBeat;
  Timer? triggerTimer;
  String roomID = '';
  String userID = '';
  String userName = '';
  double treasureProgress = 0.0;
  bool chatBan = false;
  int activeCount = 1;

  UserData? _newUser;
  UserData? get newUser => _newUser;
  set newUser(UserData? value) {
    _newUser = value;
    notifyListeners();
  }

  List<UserData> savedUsersData = [];
  List<UserData> roomUsersList = [];
  List<ZegoStreamExtended> roomStreamList = [];
  final scrollController = ScrollController();
  FixedLengthQueue? broadcastMessageList = FixedLengthQueue<ZegoBroadcastMessageInfo>(50);

   // room foreground and background
  late TickerProvider vsync;
  String? backgroundImage;
  String? foregroundImage;
  AnimationController? entryEffectController;
  SVGAAnimationController? foregroundSvgaController;

   // room music
  bool _minimized = false;
  bool get minimized => _minimized;
  set minimized(bool value) {
    _minimized = value;
    notifyListeners();
  }
  ZegoMediaPlayer? mediaPlayer;
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }
  SongModel? _loadedTrack;
  SongModel? get loadedTrack => _loadedTrack;
  set loadedTrack(SongModel? value) {
    _loadedTrack = value;
    notifyListeners();
  }
  bool _inLoop = false;
  bool get inLoop => _inLoop;
  set inLoop(bool value) {
    _inLoop = value;
    notifyListeners();
    mediaPlayer?.enableRepeat(value);
  }
  int _trackVolume = 60;
  int get trackVolume => _trackVolume;
  set trackVolume(int value) {
    _trackVolume = value;
    notifyListeners();
    mediaPlayer?.setPlayVolume(value);
  }

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
    roomStreamList.where((e) => e.streamId == userID).first.micOn = value;
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

    ZegoUser user = ZegoUser(userID, userName);

      await ZegoExpressEngine.instance.loginRoom(roomID, user,config: zegoRoomConfig );

    roomUsersList.add(Provider.of<UserDataProvider>(Get.context!,listen: false).userData!.data!);
    activeCount = roomUsersList.length;
  }
  Future<void> logoutRoom() async {
   await ZegoExpressEngine.instance.logoutRoom(roomID);
  }
  Future<void> publishStream(int seat) async {
    if(roomStreamList.firstWhereOrNull((e) => e.seat == seat) != null) {
      showCustomSnackBar('Seat Already Occupied!', Get.context!, isToaster: true);
    }else if(onSeat) {
      updateSeat(seat);
    }else{
      final extraInfo = ZegoStreamExtended(owner: isOwner,streamId: userID,seat: seat,micOn: _isMicOn&&isMicrophonePermissionGranted);
      await ZegoExpressEngine.instance.setStreamExtraInfo(zegoStreamExtendedToJson(extraInfo));
      await ZegoExpressEngine.instance.startPublishingStream(userID);
      log('📤 Start publishing stream, streamID: $userID');
      extraInfo.userData = Provider.of<UserDataProvider>(Get.context!,listen: false).userData!.data!;
      roomStreamList.add(extraInfo);
      onSeat = true;
      notifyListeners();
    }
  }
  Future<void> stopPublishingStream() async {
    await ZegoExpressEngine.instance.stopPublishingStream();
    roomStreamList.removeWhere((element) => element.streamId == userID);
    onSeat=false;
    notifyListeners();
  }
  Future<void> startPlayingStream(String streamID) async {
    await ZegoExpressEngine.instance.startPlayingStream(streamID);
  }
  Future<void> stopPlayingStream(String streamID) async {
    await ZegoExpressEngine.instance.stopPlayingStream(streamID);
  }
  Future<void> initMediaPlayer() async {
    mediaPlayer = await ZegoExpressEngine.instance.createMediaPlayer();
    if (mediaPlayer != null) {
      log("init media player success");
      await mediaPlayer!.enableAux(true);
    } else {
      log("init media player failed");
    }
  }
  Future<bool> loadLocalMedia(SongModel song) async {
    mediaPlayer?.stop();
    final result = await mediaPlayer!.loadResourceWithConfig(ZegoMediaPlayerResource(ZegoMultimediaLoadType.FilePath,filePath: song.data));
    if(result.errorCode == 0){
      loadedTrack = song;
      return true;
    } else {
      loadedTrack = null;
      showCustomSnackBar('Error loading audio file!', Get.context!,isToaster: true);
      return false;
    }
  }
  void destroyEngine() async {
    await ZegoExpressEngine.destroyEngine()
        .then((ret) => log('already destroy engine'));
  }

  Future<UserData> getSavedUserData(String id) async {
    UserData userData;
    final provider = Provider.of<UserDataProvider>(Get.context!,listen: false);
    if(id == userID){
      userData = provider.userData!.data!;
    }else if(savedUsersData.firstWhereOrNull((e) => e.id == id) != null){
      userData = savedUsersData.firstWhere((e) => e.id == id);
    }else{
      final res = await provider.getUser(id: id);
      if(res.status==1){
        userData = res.data!;
        savedUsersData.add(userData);
      }else{
        return getSavedUserData(id);
      }
    }
    return userData;
  }
  
  //zego event callbacks
  void setZegoEventCallback() {

    ZegoExpressEngine.onRoomUserUpdate = (roomID, updateType, userList) async {
      for (var e in userList) {
        var userID = e.userID;
        var userName = e.userName;
        if(userName.contains('#icognito')) {

        }else{
          if(updateType == ZegoUpdateType.Add){
            final userData = await getSavedUserData(userID);
            roomUsersList.add(userData);
          }else if (updateType == ZegoUpdateType.Delete){
            roomUsersList.removeWhere((element) => element.id == userID);
          }
          activeCount = roomUsersList.length;
          notifyListeners();
          log('🚩 🚪 Room user update, roomID: $roomID, updateType: $updateType userID: $userID userName: $userName');
        }
      }
      if(initLoading) {
        Future.delayed(const Duration(milliseconds: 500),() {
          initLoading = false;
          notifyListeners();
        });
      }
    };

    ZegoExpressEngine.onRoomStreamUpdate = ((roomID, updateType, streamList, extendedData) async {
      for (var stream in streamList) {
        var streamID = stream.streamID;
        log('🚩 🚪 Room stream update, roomID: $roomID, updateType: $updateType streamID:$streamID');

        if (updateType == ZegoUpdateType.Add) {
          final extraInfo = zegoStreamExtendedFromJson(stream.extraInfo);
          extraInfo.userData = await getSavedUserData(streamID);
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

    ZegoExpressEngine.onRoomStreamExtraInfoUpdate = (roomID, streamList) async {
      for (ZegoStream stream in streamList) {
        var streamID = stream.streamID;
        log('🚩 🚪 Streamer ExtraInfo update, roomID: $roomID, streamID:$streamID');
        final extraInfo = zegoStreamExtendedFromJson(stream.extraInfo);
        extraInfo.userData = await getSavedUserData(streamID);
        roomStreamList[roomStreamList.indexWhere((e) => e.streamId == streamID)] = extraInfo;
      }
      notifyListeners();
    };

    ZegoExpressEngine.onIMRecvCustomCommand = (String roomID, ZegoUser fromUser, String command){

        if(command == ZegoConfig.instance.roomResetCalculatorKey){
          for (ZegoStreamExtended user in roomStreamList) {
            user.points = 0;
          }
        }else if(command == ZegoConfig.instance.roomMuteSeatKey){
          roomStreamList.firstWhere((e) => e.streamId == userID).micPermit = false;
          showCustomSnackBar('Muted by ${fromUser.userName}', Get.context!,isToaster: true);
          notifyStreamExtraInfoUpdate();
          isMicOn = false;
        }else if(command == ZegoConfig.instance.roomUnMuteSeatKey){
          roomStreamList.firstWhere((e) => e.streamId == userID).micPermit = true;
          showCustomSnackBar('Unmuted by ${fromUser.userName}', Get.context!,isToaster: true,isError: false);
          notifyStreamExtraInfoUpdate();
        }else if(command == ZegoConfig.instance.roomLockSeatKey){
          stopPublishingStream();
          showCustomSnackBar('Locked by ${fromUser.userName}', Get.context!,isToaster: true);
        }else if(command == ZegoConfig.instance.roomBanChatKey){
          chatBan = true;
          showCustomSnackBar('Banned Chat by ${fromUser.userName}', Get.context!,isToaster: true);
          notifyStreamExtraInfoUpdate();
        }else if(command == ZegoConfig.instance.roomKickSeatKey){
          Get.offAll(const BottomNavigator(),transition: Transition.noTransition);
          destroy();
          showCustomSnackBar('Kicked by ${fromUser.userName}', Get.context!,isToaster: true);
        }else if(command == ZegoConfig.instance.refreshAdminKey){
          refreshAdmins();
        }else if(command == ZegoConfig.instance.refreshTreasureKey){
          refreshTreasureBox();
        }else if(command == ZegoConfig.instance.refreshThemeKey){
          refreshTheme();
        }else if(command.contains(ZegoConfig.instance.roomInviteSeatKey)){
          if(!minimized) viewInviteToSeatDailog(command.substring(20),fromUser.userName);
        }else if(command.contains(ZegoConfig.instance.roomLockRoomUpdateKey)){
          if(command.length>25){
            roomPassword = command.substring(25);
            showCustomSnackBar('Room Lock Updated!', Get.context!, isToaster: true, isError: false);
          }else{
            roomPassword = null;
            showCustomSnackBar('Room Unlocked!', Get.context!, isToaster: true, isError: false);
          }
        }else if(command.contains(ZegoConfig.instance.roomEntry)){
          final splitText = command.split(' ');
          roomEntryEffect(userId: splitText[1], vehicle: splitText[2]);
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
          if(model.gift?.toId == userID){
            if(roomStreamList.firstWhereOrNull((e) => e.streamId == userID) != null){
              int points = (((model.gift?.count??1)*(model.gift?.giftPrice??1))*3).toInt();
              roomStreamList.firstWhereOrNull((e) => e.streamId == userID)?.points = (roomStreamList.firstWhere((e) => e.streamId == userID).points??0)+points;
              notifyStreamExtraInfoUpdate();
            }
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
    ZegoStreamExtended extraInfo = roomStreamList.firstWhere((e) => e.streamId == userID);
    ZegoExpressEngine.instance.setStreamExtraInfo(zegoStreamExtendedToJson(extraInfo));
  }
  Future<void> updateTotalSeats(int total) async {
    Provider.of<RoomsProvider>(Get.context!,listen:false).updateRoomTotalSeats(roomID,total);
    if(total == 8){
      final users = roomStreamList.where((e) => e.seat! > 7).toList();
      if(users.isNotEmpty){
        for(var user in users){
          final ud = await getSavedUserData(user.streamId!);
          lockStreamer(user.streamId!,ud.name!);
        }
      }
    }
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
      roomStreamList.firstWhere((e) => e.streamId == userID).seat = newSeat;
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
    refreshAdmins();
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.refreshAdminKey,
        []
    );
  }
  void updateRoomTheme(){
    refreshTheme();
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.refreshThemeKey,
        []
    );
  }
  void updateTreasureBox(){
    ZegoExpressEngine.instance.sendCustomCommand(
        roomID,
        ZegoConfig.instance.refreshTreasureKey,
        []
    );
    refreshTreasureBox();
  }

  Future<void> roomEntryEffect({required String userId, required String vehicle, bool mine = false}) async {

    UserData? userData;
    final udp = Provider.of<UserDataProvider>(Get.context!,listen: false);

    loadSvga() async {
      foregroundSvgaController = SVGAAnimationController(vsync: vsync);
      foregroundSvgaController?.videoItem = await SVGAParser.shared.decodeFromURL(vehicle);
    }

    if(mine){
      ZegoExpressEngine.instance.sendCustomCommand(
          roomID,
          '${ZegoConfig.instance.roomEntry} $userId $vehicle',
          []
      );
      await Future.delayed(const Duration(seconds: 1));
      if(vehicle.isNotEmpty) await loadSvga();
      userData = udp.userData!.data!;
    }else{
      if(vehicle.isNotEmpty) await loadSvga();
      final user = await udp.getUser(id: userId, isUsefunsId: true);
      userData = user.data;
    }

    if(userData!=null) {

      entryEffectController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 300),
      );
      if(!savedUsersData.contains(userData)) savedUsersData.add(userData);

      newUser = userData;

      //play entry animation
      entryEffectController?.reset();
      entryEffectController?.forward();
      entryEffectController?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(seconds: 2), () {
            entryEffectController?.reverse();
          });
        }
      });
      vehicle.isNotEmpty
          ? await foregroundSvgaController?.forward()
          : await Future.delayed(const Duration(seconds: 3));

    }

    newUser = null;
    entryEffectController?.dispose();
    entryEffectController = null;
    if(vehicle.isNotEmpty) foregroundSvgaController?.dispose();
    if(vehicle.isNotEmpty) foregroundSvgaController = null;

    notifyListeners();
  }

  //broadcast and barrage methods
  void sendBroadcastMessage(String message) {
    final user = Provider.of<UserDataProvider>(Get.context!,listen: false).userData;
    String body = zegoBroadcastModelToJson(ZegoBroadcastModel(message: message,userImage: user!.data!.images!.isNotEmpty? user.data!.images!.first:null, level:user.data!.level,type: "message",tags: [if(isOwner)'Owner',if(room!.admin!.contains(userID))'Admin'], bubble: userValidItemSelection(user.data?.chatBubble)));
    ZegoExpressEngine.instance.sendBroadcastMessage(roomID, body);
    broadcastMessageList?.enqueue(ZegoBroadcastMessageInfo(body,0,0,ZegoUser(userID,userName)));
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500),(){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
    });
  }
  Future<void> sendBroadcastGift(List<String> toName, String thumbnailPath, String giftPath, int giftPrice, int count) async {
    for (var receiverName in toName) {
      final user = Provider.of<UserDataProvider>(Get.context!,listen: false).userData;
      String body = zegoBroadcastModelToJson(ZegoBroadcastModel(userImage: user!.data!.images!.isNotEmpty? user.data!.images!.first:null, level:user.data!.level,type: "gift",gift: ZegoGift(toName: receiverName,count: count,thumbnailPath: thumbnailPath, giftPath: giftPath, toId: savedUsersData.firstWhereOrNull((e) => e.name == receiverName)?.id,giftPrice: giftPrice),tags: [if(isOwner)'Owner',if(room!.admin!.contains(userID))'Admin'], bubble: userValidItemSelection(user.data?.chatBubble)));
      ZegoExpressEngine.instance.sendBroadcastMessage(roomID, body);
      broadcastMessageList?.enqueue(ZegoBroadcastMessageInfo(body,0,0,ZegoUser(userID,userName)));
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
    roomStreamList[roomStreamList.indexWhere((e) => e.streamId == userID)].reactionController = controller;
    notifyListeners();
    roomStreamList[roomStreamList.indexWhere((e) => e.streamId == userID)].reactionController
        ?.forward()
        .whenComplete(() {
          if(roomStreamList[roomStreamList.indexWhere((e) => e.streamId == userID)].reactionController?.videoItem == controller.videoItem){
            roomStreamList[roomStreamList.indexWhere((e) => e.streamId == userID)].reactionController?.dispose();
            roomStreamList[roomStreamList.indexWhere((e) => e.streamId == userID)].reactionController = null;
            notifyListeners();
          }
      return;
    });
  }

  void addGreeting(String message, UserDataModel owner) {
    String body = zegoBroadcastModelToJson(ZegoBroadcastModel(message: message,userImage: owner.data!.images!.isNotEmpty? owner.data!.images!.first:null, level:owner.data!.level,type: "message",tags: ['Owner'], bubble: userValidItemSelection(owner.data?.chatBubble)));
    broadcastMessageList?.enqueue(ZegoBroadcastMessageInfo(body,0,0,ZegoUser(owner.data!.id!,owner.data!.name!.contains('#icognito')?owner.data!.name!.split('#').first:owner.data!.name!)));
  }

  Future<void> refreshTreasureBox() async {

    final data = await Provider.of<RoomsProvider>(Get.context!,listen: false).getTreasureBox(room!.id!);
      if(data!=null) {
        int newLevel = data.treasureBoxLevel!;
        if(room!.treasureBoxLevel!<newLevel && !minimized){
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

  Future<void> refreshTheme() async {
    final ownerData = await Provider.of<UserDataProvider>(Get.context!, listen: false)
        .getUser(id: room!.userId!);
    if (ownerData.data!.roomWallpaper!.isNotEmpty) {
      String image = userValidItemSelection(ownerData.data!.roomWallpaper!);
      backgroundImage = image.isNotEmpty?image:null;
      notifyListeners();
    }
  }

  void heartbeatJoin(){
    void rejoin() async {
      DateTime locale = DateTime.timestamp();
      print('Rejoined at UTC ${locale.hour}:${locale.minute}:${locale.second}');
      Provider.of<RoomsProvider>(Get.context!,listen: false).addRoomUser(room!.id!,password: roomPassword,retry: true);
    }
    const int heartBeatDelay = 5;
    DateTime now = DateTime.timestamp();

    // Calculate the next trigger time that is a multiple of 5 minutes and 0 second
    DateTime next = now.add(Duration(minutes: heartBeatDelay - now.minute % heartBeatDelay, seconds: 1 - now.second));
    // Calculate the delay in seconds between now and next
    int delayInSec = next.difference(now).inSeconds;

    triggerTimer = Timer(Duration(seconds: delayInSec), () {
      rejoin();
      heartBeat = Timer.periodic(const Duration(minutes: heartBeatDelay), (timer) {
        rejoin();
      });
    });
  }

}
