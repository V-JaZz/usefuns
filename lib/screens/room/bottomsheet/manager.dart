import 'package:flutter/material.dart';
import 'package:live_app/screens/room/bottomsheet/lucky_wheel.dart';
import 'package:live_app/screens/room/bottomsheet/share.dart';
import '../../../data/model/body/zego_stream_model.dart';
import '../../../data/model/response/user_data_model.dart';
import '../../dashboard/message/notifications.dart';
import 'admins.dart';
import 'income_expense_tabs.dart';
import 'bottom_more.dart';
import 'games.dart';
import 'invite_room.dart';
import 'send_gifts.dart';
import 'contribution.dart';
import 'active_users.dart';
import 'emoji.dart';
import 'group_members.dart';
import 'invite_user_bottomsheet.dart';
import 'all_seat_options.dart';
import 'room_profile.dart';
import 'send_message.dart';
import 'top_more.dart';
import 'treasures.dart';

class LiveRoomBottomSheets {
  final BuildContext context;
  LiveRoomBottomSheets(this.context);

  void showRoomProfileBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const RoomProfileBottomSheet();
        });
  }

  void showActiveUsersBottomSheet(String ownerId) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return ActiveUsersBottomSheet(ownerId: ownerId);
        });
  }

  void showRoomAdminsBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const AdminsBottomSheet();
        });
  }

  void showShareBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const ShareBottomSheet();
        });
  }

  void showTopMoreBottomSheet(bool owner) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return TopMore(owner: owner);
        });
  }

  void showGroupMemberBottomSheet(List<UserData>? members,String owner) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return GroupMembersBottomSheet(members: members, owner: owner);
        });
  }

  void showContributionBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const Contribution();
        });
  }

  void showSeatOptionsBottomSheet(int index) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return SeatOptions(index: index);
        });
  }

  void showMyProfileSeatBottomSheet(ZegoStreamExtended user) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return MyProfileSeatBottomSheet(user: user);
        });
  }



  void showOthersProfileSeatBottomSheet({required ZegoStreamExtended user, bool? owner, bool? admin}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return OthersProfileSeatBottomSheet(user: user, admin: admin??false, owner: owner??false);
        });
  }


  void showInviteBottomSheet(ownerId, seat) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return InviteUserBottomSheet(ownerId: ownerId,seat: seat);
        });
  }

  void showMessage({String? mention}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return SendMessageBottomSheet(mention: mention);
        });
  }

  void showEmojiBottomSheet() {
    showModalBottomSheet(
        backgroundColor: const Color(0x66000000),
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const EmojiBottomSheet();
        });
  }

  void showSendGiftsBottomSheet({String? selection}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
            return SendGiftsBottomSheet(selection: selection);
        });
  }

  void showGamesBottomSheet(bool owner) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return GamesBottomSheet(owner: owner);
        });
  }

  void showBottomMoreBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const BottomMoreBottomSheet();
        });
  }

  void showIncomeExpenseBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const IncomeExpense();
        });
  }

  void showTreasuresBottomSheet() {
    showModalBottomSheet(
        backgroundColor: const Color(0xFF9E26BC),
        shape: InputBorder.none,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const Treasures();
        });
  }

  void showLuckyWheelBottomSheet() {
    showModalBottomSheet(
        backgroundColor: const Color(0xFF9E26BC),
        shape: InputBorder.none,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const LuckyWheelBottomSheet();
        });
  }

  void showNotificationsBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const Notifications(showAppBar: false);
      },
    );
  }

  void inviteMemberSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return InviteRoomBottomSheet();
        });
  }
}