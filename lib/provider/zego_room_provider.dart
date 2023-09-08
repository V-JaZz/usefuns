import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../data/model/response/rooms_model.dart';
import '../utils/zego_config.dart';

class ZegoRoomProvider with ChangeNotifier {
  final storageService = StorageService();
  Room? room;
  int _previewViewID = -1;
  int _playViewID = -1;
  Widget? _previewViewWidget;
  Widget? _playViewWidget;

  bool isMicOn = false;
  bool isSoundOn = false;

  static const double viewRatio = 3.0 / 4.0;
  final String _roomID = 'QuickStartRoom-1';

  List<ZegoUser> roomUsersList = [];
  List<ZegoStream> roomStreamList = [];

  int activeCount = 1;

  ZegoMediaPlayer? mediaPlayer;
  bool _isEngineActive = false;
  ZegoRoomState _roomState = ZegoRoomState.Disconnected;

  ZegoRoomState get roomState => _roomState;

  set roomState(ZegoRoomState value) {
    _roomState = value;
    notifyListeners();
  }

  ZegoPublisherState publisherState = ZegoPublisherState.NoPublish;
  ZegoPlayerState _playerState = ZegoPlayerState.NoPlay;

  final TextEditingController _publishingStreamIDController = TextEditingController();
  final TextEditingController _playingStreamIDController = TextEditingController();

  // MARK: - Step 1: CreateEngine

  void createEngine() {
    ZegoEngineProfile profile = ZegoEngineProfile(
        ZegoConfig.instance.appID, ZegoConfig.instance.scenario,
        enablePlatformView: ZegoConfig.instance.enablePlatformView,
        appSign: ZegoConfig.instance.appSign);

    ZegoExpressEngine.createEngineWithProfile(profile);

    // Notify View that engine state changed
    _isEngineActive = true;

    log('🚀 Create ZegoExpressEngine');
  }

  // MARK: - Step 2: LoginRoom

  void loginRoom() {
    // Instantiate a ZegoUser object
    ZegoUser user = ZegoUser(
        ZegoConfig.instance.userID,
        ZegoConfig.instance.userName.isEmpty
            ? ZegoConfig.instance.userID
            : ZegoConfig.instance.userName);

      ZegoExpressEngine.instance.loginRoom(_roomID, user);

    log('🚪 Start login room, roomID: $_roomID');

  }

  void logoutRoom() {
    // Logout room will automatically stop publishing/playing stream.
    //
    // But directly logout room without destroying the [PlatformView]
    // or [TextureRenderer] may cause a memory leak.
    ZegoExpressEngine.instance.logoutRoom(_roomID);
    log('🚪 logout room, roomID: $_roomID');

    clearPreviewView();
    clearPlayView();
  }

  // MARK: - Step 3: StartPublishingStream
  void startPreview() {
    Future<void> _startPreview(int viewID) async {
      ZegoCanvas canvas = ZegoCanvas.view(viewID);
      await ZegoExpressEngine.instance.startPreview(canvas: canvas);
      log('🔌 Start preview, viewID: $viewID');
    }

    if (Platform.isIOS ||
        Platform.isAndroid ||
        Platform.isWindows ||
        Platform.isMacOS ||
        kIsWeb) {
      ZegoExpressEngine.instance.createCanvasView((viewID) {
        _previewViewID = viewID;
        _startPreview(viewID);
      }).then((widget) {
          _previewViewWidget = widget;
      });
    } else {
      ZegoExpressEngine.instance.startPreview();
    }
  }

  void stopPreview() {
    if (!Platform.isAndroid &&
        !Platform.isIOS &&
        !Platform.isMacOS &&
        !kIsWeb) {
      return;
    }

    if (_previewViewWidget == null) {
      return;
    }

    ZegoExpressEngine.instance.stopPreview();
    clearPreviewView();
  }

  void startPublishingStream() {
    final user = Provider.of<UserDataProvider>(Get.context!).userData;
    if(user!.data!.images!.isNotEmpty)ZegoExpressEngine.instance.setStreamExtraInfo(user.data?.images?.first??'');
    ZegoExpressEngine.instance.startPublishingStream(ZegoConfig.instance.streamID);
    log('📤 Start publishing stream, streamID: ${ZegoConfig.instance.streamID}');
    roomStreamList.add(ZegoStream(ZegoUser(ZegoConfig.instance.userID,ZegoConfig.instance.userName), ZegoConfig.instance.streamID, user.data?.images?.first??''));
  }

  void stopPublishingStream() {
    ZegoExpressEngine.instance.stopPublishingStream();
  }

  // MARK: - Step 4: StartPlayingStream

  void startPlayingStream(String streamID) {
    void _startPlayingStream(int viewID, String streamID) {
      ZegoCanvas canvas = ZegoCanvas.view(viewID);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
      log('📥 Start playing stream, streamID: $streamID, viewID: $viewID');
    }

    if (Platform.isIOS ||
        Platform.isAndroid ||
        Platform.isWindows ||
        Platform.isMacOS ||
        kIsWeb) {
      log('📥 Start playing stream, streamID');
      ZegoExpressEngine.instance.createCanvasView((viewID) {
        _playViewID = viewID;
        _startPlayingStream(viewID, streamID);
      }).then((widget) {
          _playViewWidget = widget;
      });
    } else {
      ZegoExpressEngine.instance.startPlayingStream(streamID);
    }
  }

  void stopPlayingStream(String streamID) {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);

    clearPlayView();
  }

  // MARK: - Exit

  void destroyEngine() async {
    stopPreview();
    clearPreviewView();
    clearPlayView();

    // Can destroy the engine when you don't need audio and video calls
    //
    // Destroy engine will automatically logout room and stop publishing/playing stream.
    ZegoExpressEngine.destroyEngine()
        .then((ret) => log('already destroy engine'));

    log('🏳️ Destroy ZegoExpressEngine');

    // Notify View that engine state changed

      _isEngineActive = false;
      _roomState = ZegoRoomState.Disconnected;
      publisherState = ZegoPublisherState.NoPublish;
      _playerState = ZegoPlayerState.NoPlay;
  }

  // MARK: - Zego Event

  void setZegoEventCallback() {
    ZegoExpressEngine.onRoomStateUpdate = (String roomID, ZegoRoomState state,
        int errorCode, Map<String, dynamic> extendedData) {
      log(
          '🚩 🚪 Room state update, state: $state, errorCode: $errorCode, roomID: $roomID');
      roomState = state;
    };

    ZegoExpressEngine.onPublisherStateUpdate = (String streamID,
        ZegoPublisherState state,
        int errorCode,
        Map<String, dynamic> extendedData) {
      log(
          '🚩 📤 Publisher state update, state: $state, errorCode: $errorCode, streamID: $streamID');
      publisherState = state;
    };

    ZegoExpressEngine.onPlayerStateUpdate = (String streamID,
        ZegoPlayerState state,
        int errorCode,
        Map<String, dynamic> extendedData) {
      log(
          '🚩 📥 Player state update, state: $state, errorCode: $errorCode, streamID: $streamID');
      _playerState = state;
    };

    ZegoExpressEngine.onRoomUserUpdate = (roomID, updateType, userList) {
      roomUsersList = userList;
      notifyListeners();
      for (var e in userList) {
        var userID = e.userID;
        var userName = e.userName;
        log(
            '🚩 🚩 🚩 🚪 Room user update, roomID: $roomID, updateType: $updateType userID: $userID userName: $userName');
      }
    };

    ZegoExpressEngine.onRoomOnlineUserCountUpdate = (roomID, count) {
      activeCount = count;
      notifyListeners();
    };

    ZegoExpressEngine.onRoomStreamUpdate =
    ((roomID, updateType, streamList, extendedData) {
      roomStreamList.addAll(streamList) ;
      notifyListeners();
      for (var stream in streamList) {
        var streamID = stream.streamID;
        log('🚩 🚪 Room stream update, roomID: $roomID, updateType: $updateType streamID:$streamID');

        if (updateType == ZegoUpdateType.Add) {
          startPlayingStream(streamID);
        }else if(updateType == ZegoUpdateType.Delete){
          roomStreamList.removeWhere((element) => element.streamID == streamID);
          notifyListeners();
        }
      }
    });


  }

  void clearZegoEventCallback() {
    ZegoExpressEngine.onRoomStateUpdate = null;
    ZegoExpressEngine.onPublisherStateUpdate = null;
    ZegoExpressEngine.onPlayerStateUpdate = null;
  }

  void clearPreviewView() {
    if (!Platform.isAndroid &&
        !Platform.isIOS &&
        !Platform.isMacOS &&
        !Platform.isWindows &&
        !kIsWeb) {
      return;
    }

    if (_previewViewWidget == null) {
      return;
    }

    // Developers should destroy the [CanvasView] after
    // [stopPublishingStream] or [stopPreview] to release resource and avoid memory leaks
    ZegoExpressEngine.instance.destroyCanvasView(_previewViewID);
    _previewViewWidget = null;
  }

  void clearPlayView() {
    if (!Platform.isAndroid &&
        !Platform.isIOS &&
        !Platform.isMacOS &&
        !Platform.isWindows &&
        !kIsWeb) {
      return;
    }

    if (_playViewWidget == null) {
      return;
    }

    // Developers should destroy the [CanvasView]
    // after [stopPlayingStream] to release resource and avoid memory leaks
    ZegoExpressEngine.instance.destroyCanvasView(_playViewID);
    _playViewWidget = null;
  }

  void init() async {
    isMicOn = !await ZegoExpressEngine.instance.isMicrophoneMuted();
    isSoundOn = !await ZegoExpressEngine.instance.isSpeakerMuted();
  }
  void muteMicrophone(bool b){
    isMicOn = !b;
    notifyListeners();
    ZegoExpressEngine.instance.muteMicrophone(b);
  }
  void muteAudio(bool b){
    isSoundOn = !b;
    notifyListeners();
    ZegoExpressEngine.instance.muteSpeaker(b);
  }
}
