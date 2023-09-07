import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../utils/zego_config.dart';

class ZegoProvider with ChangeNotifier {
  final storageService = StorageService();

  int _previewViewID = -1;
  int _playViewID = -1;
  Widget? _previewViewWidget;
  Widget? _playViewWidget;
  static const double viewRatio = 3.0 / 4.0;
  final String _roomID = 'QuickStartRoom-1';
  List<ZegoUser>? roomUsersList;
  List<ZegoStream>? roomStreamList;

  ZegoMediaPlayer? mediaPlayer;

  bool _isEngineActive = false;
  ZegoRoomState _roomState = ZegoRoomState.Disconnected;
  ZegoPublisherState _publisherState = ZegoPublisherState.NoPublish;
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
    ZegoExpressEngine.instance.startPublishingStream(ZegoConfig.instance.streamID);
    log('📤 Start publishing stream, streamID: ${ZegoConfig.instance.streamID}');
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
      _publisherState = ZegoPublisherState.NoPublish;
      _playerState = ZegoPlayerState.NoPlay;
  }

  // MARK: - Zego Event

  void setZegoEventCallback() {
    ZegoExpressEngine.onRoomStateUpdate = (String roomID, ZegoRoomState state,
        int errorCode, Map<String, dynamic> extendedData) {
      log(
          '🚩 🚪 Room state update, state: $state, errorCode: $errorCode, roomID: $roomID');
      _roomState = state;
    };

    ZegoExpressEngine.onPublisherStateUpdate = (String streamID,
        ZegoPublisherState state,
        int errorCode,
        Map<String, dynamic> extendedData) {
      log(
          '🚩 📤 Publisher state update, state: $state, errorCode: $errorCode, streamID: $streamID');
      _publisherState = state;
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
      for (var e in userList) {
        var userID = e.userID;
        var userName = e.userName;
        log(
            '🚩 🚪 Room user update, roomID: $roomID, updateType: $updateType userID: $userID userName: $userName');
      }
    };

    ZegoExpressEngine.onRoomStreamUpdate =
    ((roomID, updateType, streamList, extendedData) {
      roomStreamList = streamList;
      for (var stream in streamList) {
        var streamID = stream.streamID;
        log(
            '🚩 🚪 Room stream update, roomID: $roomID, updateType: $updateType streamID:$streamID');

        if (updateType == ZegoPlayerState.NoPlay) {
          stopPlayingStream(_playingStreamIDController.text.trim());
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
}
