import 'package:zego_express_engine/zego_express_engine.dart' show ZegoScenario;

class ZegoConfig {
  static final ZegoConfig instance = ZegoConfig._internal();
  ZegoConfig._internal();

  int appID = 1201749877;
  String roomKey= 'ROOM_EXTRA_INFO_KEY';

  //Callbacks Commands
  String roomMuteSeatKey= 'ROOM_MUTE_SEAT_KEY';
  String roomUnMuteSeatKey= 'ROOM_UNMUTE_SEAT_KEY';
  String roomLockSeatKey= 'ROOM_LOCK_SEAT_KEY';
  String roomBanChatKey= 'ROOM_BAN_CHAT_KEY';
  String roomUnBanChatKey= 'ROOM_UNBAN_CHAT_KEY';
  String roomKickSeatKey= 'ROOM_KICK_SEAT_KEY';
  String roomInviteSeatKey= 'ROOM_INVITE_SEAT_KEY';
  String roomResetCalculatorKey= 'ROOM_RESET_CALCULATOR_KEY';
  String refreshAdminKey= 'REFRESH_ADMIN_KEY';
  String refreshTreasureKey= 'REFRESH_TREASURE_KEY';
  String roomLockRoomUpdateKey= 'ROOM_LOCK_ROOM_UPDATE_KEY';

  // It is for native only, do not use it for web!
  String appSign = "da0d6214cf4ff6ca326fadf76e2802c0308a99cb0cb74ccfaf6798fb8aa21285";

  // It is required for web and is recommended for native but not required.
  String token = "";

  ZegoScenario scenario = ZegoScenario.HighQualityChatroom;
  bool enablePlatformView = false;

  String userID = "";
  String userName = "";

  bool isPreviewMirror = true;
  bool isPublishMirror = false;

  bool enableHardwareEncoder = false;
}