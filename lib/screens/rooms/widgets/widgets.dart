import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/rooms/widgets/contribution_bottomsheet.dart';
import 'package:live_app/screens/rooms/widgets/send_gifts_bottomsheet.dart';
import 'package:provider/provider.dart';
import '../../../subscreens/mess/usefuns_teams.dart';
import '../../../utils/utils_assets.dart';
import 'package:live_app/screens/rooms/widgets/emoji_bottomsheet.dart';
import 'package:live_app/subscreens/aristrocracy/tab_bar.dart';
import 'package:live_app/subscreens/playing_song/playlist.dart';
import 'package:live_app/subscreens/scree/theme.dart';
import 'package:live_app/subscreens/shop/shop.dart';
import 'package:live_app/subscreens/tasks/dailyTask.dart';
import '../../dashboard/message/activity.dart';
import '../../dashboard/message/system_notification.dart';
import '../../dashboard/message/usefuns_club_notifications.dart';
import 'active_bottomsheet.dart';
import 'group_members_bottomsheet.dart';
import 'income_expense_tabs.dart';
import 'invite_user_bottomsheet.dart';
import 'room_profile_bottomsheet.dart';
import 'treasures_bottomsheet.dart';

class RoomWidgets {
  final BuildContext context;

  RoomWidgets(this.context);

  bool isLocked = true;
  bool isPressed = true;

  final List<Map> notifications = [
    {
      "title": "System",
      "message":
      "Please Complete Your Profile, So that Other People Can Know You better, and You can get more followers",
      "color": 0xFFFF9933,
      "icon": Icons.notifications_none,
      "onTap": () {
        Get.to(() => System());
      },
    },
    {
      "title": "Usefuns Club",
      "message": "",
      "color": 0xff14ae80,
      "icon": Icons.people_alt_outlined,
      "onTap": () {
        Get.to(() => const UsefunsClubNotification());
      },
    },
    {
      "title": "Activity",
      "message": "Every Single gift has a rank, a greater chance",
      "color": 0xFFEE3074,
      "icon": Icons.outlined_flag,
      "onTap": () {
        Get.to(() => Activity());
      },
    },
    {
      "title": "Usefuns team",
      "message": "",
      "color": 0xff14ae80,
      "icon": Icons.headset_mic_outlined,
      "onTap": () {
        Get.to(() => const UsefunsTeam());
      },
    },
  ];
  final List<Map> gamesList = [
    {
      "image": 'assets/jackpot.gif',
      "name": "JackPot",
      "rank": "516",
    },
    {
      "image": 'assets/ludo.gif',
      "name": "Ludo",
      "rank": "412",
    },
    {
      "image": 'assets/777.png',
      "name": "777 game",
      "rank": "510",
    },
    {
      "image": 'assets/wheel.gif',
      "name": "Wheel",
      "rank": "524",
    },
    {
      "image": 'assets/dias.png',
      "name": "Ludo Dias",
      "rank": "440",
    },
    {
      "image": 'assets/star.gif',
      "name": "Calculator",
      "rank": "440",
    },
  ];
  final List<Map> roomList = [
    {
      "image": "assets/dummy/g1.png",
      "name": "DREAM GIRLS",
      "about": "Sabhi New Users Ka swagat",
      "rank": "16",
    },
    {
      "image": "assets/dummy/g2.png",
      "name": "Girl Friend.Com",
      "about": "Sabhi New Users Ka swagat",
      "rank": "12",
    },
    {
      "image": "assets/dummy/g3.png",
      "name": "FRIENDSHIP CLUB",
      "about": "Sabhi New Users Ka swagat",
      "rank": "10",
    },
    {
      "image": "assets/dummy/g4.png",
      "name": "Gf Bf Dating Eoom",
      "about": "Sabhi New Users Ka swagat",
      "rank": "24",
    },
    {
      "image": "assets/dummy/g5.png",
      "name": "Nisha Hosting....",
      "about": "Sabhi New Users Ka swagat",
      "rank": "40",
    },
  ];



  Container lvMemberAdmin(double a, double b) {
    return Container(
        width: 320 * a,
        height: 28 * a,
        child: Stack(children: <Widget>[
          Positioned(
            top: -15 * a,
            left: 20 * a,
            child: Container(
              width: 145 * a,
              height: 86 * a,
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 50 * a,
                        height: 55 * a,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/lv.png'),
                              fit: BoxFit.cover),
                        ))),
                // Positioned(
                //     top: 0 * a,
                //     left: 0 * a,
                //     child: Center(child: Image.asset('assets/owner.png'))),
              ]),
            ),
          ),
          Positioned(
              top: 5 * a,
              left: 180 * a,
              child: Container(
                  width: 63 * a,
                  height: 29 * a,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 2 * a,
                        left: 5 * a,
                        child: Container(
                            width: 49 * a,
                            height: 19 * a,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ))),
                    Positioned(
                        top: 3 * a,
                        left: 25.5 * a,
                        child: Center(
                          child: Text(
                            '28',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Poppins',
                                fontSize: 11 * a,
                                letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1 * a),
                          ),
                        )),
                    Positioned(
                        top: 4 * a,
                        left: 14 * a,
                        child: Container(
                          width: 14 * a,
                          height: 14 * a,
                          child: Icon(
                            Icons.male,
                            size: 12 * a,
                          ),
                        )),
                  ]))),
          Positioned(
            top: -20 * a,
            left: 66 * a,
            child: Container(
              width: 145 * a,
              height: 86 * a,
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 70 * a,
                        height: 65 * a,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/member.png'),
                              fit: BoxFit.cover),
                        ))),
                // Positioned(
                //     top: 0 * a,
                //     left: 0 * a,
                //     child: Center(child: Image.asset('assets/owner.png'))),
              ]),
            ),
          ),
          Positioned(
            top: -20 * a,
            left: 127 * a,
            child: Container(
              width: 145 * a,
              height: 86 * a,
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 70 * a,
                        height: 65 * a,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/admin.png'),
                              fit: BoxFit.cover),
                        ))),
                // Positioned(
                //     top: 0 * a,
                //     left: 0 * a,
                //     child: Center(child: Image.asset('assets/owner.png'))),
              ]),
            ),
          ),
        ]));
  }

  Container lvMemberAdmin1(double a, double b) {
    return Container(
        alignment: Alignment.center,
        width: 240 * a,
        height: 60 * a,
        child: Stack(children: <Widget>[
          Positioned(
              top: 5 * a,
              left: 10,
              child: Container(
                  width: 89 * a,
                  height: 126 * a,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0 * a,
                        left: 0,
                        child: Container(
                            width: 79 * a,
                            height: 40 * a,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/lv.png'),
                                  fit: BoxFit.cover),
                            ))),
                    Positioned(
                        top: 12.2 * a,
                        left: 34 * a,
                        child: Center(
                          child: Text(
                            'Lv.1',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color.fromRGBO(251, 250, 250, 1),
                                fontFamily: 'Poppins',
                                fontSize: 13.33 * a,
                                letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1.5 * b / a),
                          ),
                        )),
                  ]))),
          Positioned(
              top: 9 * a,
              left: 177 * a,
              child: Container(
                  width: 50 * a,
                  height: 30 * a,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 12 * a,
                        left: 20 * a,
                        child: Center(
                          child: Text(
                            '22',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Poppins',
                                fontSize: 14 * a,
                                letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1 * a),
                          ),
                        )),
                    Positioned(
                        top: 7.5 * a,
                        left: 1 * a,
                        child: Container(
                          width: 12 * a,
                          height: 12 * a,
                          child: const Icon(Icons.female),
                        )),
                  ]))),
          Positioned(
              top: -22 * a,
              left: 90 * a,
              child: Container(
                  width: 85 * a,
                  height: 90 * a,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 4 * a,
                        left: 0,
                        child: Container(
                            width: 85 * a,
                            height: 85 * a,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/owner.png'),
                                  fit: BoxFit.cover),
                            ))),
                    // Positioned(
                    //     top: 0 * a,
                    //     left: 0 * a,
                    //     child: Center(child: Image.asset('assets/owner.png'))),
                  ]))),
        ]));
  }

  Container iconTextRow(double a, double b, String t, String p) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * a, horizontal: 3 * a),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70 * a,
            height: 60 * a,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(p),
              ),
            ),
          ),
          // CircleAvatar(
          //   foregroundImage: AssetImage(p),
          //   radius: 15 * a,
          // ),
          SizedBox(height: 6 * a),
          SizedBox(
            // width: 57 * a,
            child: Text(
              t,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: SafeGoogleFont('Poppins',
                  fontSize: 12 * b,
                  fontWeight: FontWeight.w400,
                  height: 1 * b / a,
                  letterSpacing: 0.48 * a,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  void showNotifyBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        double baseWidth = 360;
        double a = Get.width / baseWidth;
        double b = a * 0.97;
        return Container(
          color: Colors.white,
          width: double.infinity,
          height: 300 * a,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 15 * a),
              Row(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                              height: 33 * a,
                              width: 36 * a,
                              color: const Color(0xFF4285F4),
                              child: const Icon(Icons.comment_sharp,
                                  color: Colors.white)),
                          SizedBox(height: 5 * a),
                          Text(
                            'Comments',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 15 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.6 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                              height: 33 * a,
                              width: 36 * a,
                              color: const Color(0xFFEE3074),
                              child: const Icon(Icons.thumb_up_off_alt,
                                  color: Colors.white)),
                          SizedBox(height: 5 * a),
                          Text(
                            'Likes',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 15 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.6 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                              height: 33 * a,
                              width: 36 * a,
                              color: const Color(0xFF34A853),
                              child: const Icon(Icons.people_alt_outlined,
                                  color: Colors.white)),
                          SizedBox(height: 5 * a),
                          Text(
                            'Followers',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 15 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.6 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 20 * a,
              ),
              for (Map m in notifications)
                ListTile(
                  onTap: m['onTap'],
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Color(m['color']),
                    radius: 15 * a,
                    child: Icon(
                      m['icon'],
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    m['title'],
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 15 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.6 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  subtitle: Divider(
                    height: 17 * a,
                    color: Colors.transparent,
                  ),
                )
            ]),
          ),
        );
      },
    );
  }

  void showMessage() {
    final controller = TextEditingController();
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 360;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return GestureDetector(
            onTap: () => Get.back(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 60 * a,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20 * a),
                          child: SizedBox(
                            height: 40 * a,
                            width: 220 * a,
                            child: Center(
                              child: TextField(
                                controller: controller,
                                maxLength: 333,
                                decoration: const InputDecoration(hintText: 'Type a message',counterText: ''),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image_rounded,
                            color: Colors.black,
                          ),
                          Text('SVIP',style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        width: 16 * a,
                      ),
                      Consumer<ZegoRoomProvider>(
                        builder: (context, value, child) => InkWell(
                          onTap: () {
                            if(controller.text.trim() != '') value.sendBroadcastMessage(controller.text.trim());
                            Get.back();
                            // final snackBar = SnackBar(
                            //   content: const Text('Hi, I am a SnackBar!'),
                            //   backgroundColor: (Colors.black12),
                            //   action: SnackBarAction(
                            //     label: 'dismiss',
                            //     onPressed: () {},
                            //   ),
                            // );
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);
                          },
                          child: Container(
                            height: 29,
                            width: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: const Center(
                              child: Text(
                                'SEND',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10 * a,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void showActiveBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const ViewActiveBottomSheet();
        });
  }

  void showGroupMemberBottomSheet(List<String> members) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return GroupMembersBottomSheet(members: members);
        });
  }

  void showClickLockedBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 360;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return Container(
            color: Colors.white,
            height: 80 * a,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0 * a),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(isLocked ? Icons.lock : Icons.lock_open,
                            color: Colors.black, size: 24 * a),
                        onPressed: () {
                          // context.setState(() {
                            isLocked = !isLocked;
                          // });
                        },
                      ),
                      Text(
                        isLocked ? 'Lock' : 'UnLock',
                        style: SafeGoogleFont('Poppins',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.48 * a,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(isLocked ? Icons.lock : Icons.lock_open,
                            color: Colors.black, size: 24 * a),
                        onPressed: () {
                          // setState(() {
                            isLocked = !isLocked;
                            isPressed = !isPressed;
                          // });
                        },
                      ),
                      Text(
                        isLocked ? 'Lock All' : 'UnLock All',
                        style: SafeGoogleFont('Poppins',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.48 * a,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.mic_external_on_rounded,
                            color: Colors.black, size: 24 * a),
                        onPressed: () {},
                      ),
                      Text(
                        'On mic',
                        style: SafeGoogleFont('Poppins',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.48 * a,
                            color: Colors.black),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: showInviteBottomSheet,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person_add,
                            color: Colors.black, size: 24 * a),
                        Text(
                          'Invite',
                          style: SafeGoogleFont('Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showMore1BottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 360;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0 * a),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 18 * a),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock, color: Colors.black, size: 24 * a),
                      SizedBox(width: 12 * a),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuilderContext) {
                                return AlertDialog(
                                  content: Container(
                                      color: Colors.white,
                                      height: 200 * a,
                                      width: 50 * a,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              'Room Lock',
                                              style: SafeGoogleFont('Poppins',
                                                  fontSize: 16 * b,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.5 * b / a,
                                                  letterSpacing: 0.48 * a,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 18 * a,
                                                left: 10 * a,
                                                right: 10 * a),
                                            child: Center(
                                              child: Text(
                                                'You haven\'t purchased Room Lock \n           yet. Confirm to buy? ',
                                                style: SafeGoogleFont('Poppins',
                                                    fontSize: 10 * b,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.5 * b / a,
                                                    letterSpacing: 0.48 * a,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => const Shop());
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 18 * a,
                                                  left: 10 * a,
                                                  right: 10 * a),
                                              child: Container(
                                                  width: 136 * a,
                                                  height: 27 * a,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          9 * a),
                                                      topRight: Radius.circular(
                                                          9 * a),
                                                      bottomLeft:
                                                      Radius.circular(
                                                          9 * a),
                                                      bottomRight:
                                                      Radius.circular(
                                                          9 * a),
                                                    ),
                                                    color: const Color.fromRGBO(
                                                        255, 229, 0, 1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'OK',
                                                      style: SafeGoogleFont(
                                                          'Poppins',
                                                          fontSize: 13 * a,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          height: 1.5 * b / a,
                                                          letterSpacing:
                                                          0.48 * a,
                                                          color: const Color.fromARGB(
                                                              255,
                                                              250,
                                                              249,
                                                              249)),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 18 * a,
                                                left: 10 * a,
                                                right: 10 * a),
                                            child: Text(
                                              'CANCEL',
                                              style: SafeGoogleFont('Poppins',
                                                  fontSize: 13 * a,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5 * b / a,
                                                  letterSpacing: 0.48 * a,
                                                  color: const Color.fromARGB(
                                                      255, 64, 63, 63)),
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              });
                        },
                        child: Text(
                          'Lock',
                          style: SafeGoogleFont('Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: const Color(0x66000000),
                    height: 20 * a,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const ThemePage());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.color_lens_rounded,
                            color: Colors.black, size: 24 * a),
                        SizedBox(width: 12 * a),
                        Text(
                          'Theme',
                          style: SafeGoogleFont('Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: const Color(0x66000000),
                    height: 20 * a,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      showShareBottomSheet();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.share, color: Colors.black, size: 24 * a),
                        SizedBox(width: 12 * a),
                        Text(
                          'Share',
                          style: SafeGoogleFont('Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: const Color(0x66000000),
                    height: 20 * a,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.people_alt, color: Colors.black, size: 24 * a),
                      SizedBox(width: 12 * a),
                      Text(
                        'Admin',
                        style: SafeGoogleFont('Poppins',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w500,
                            height: 1.5 * b / a,
                            letterSpacing: 0.48 * a,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Divider(
                    color: const Color(0x66000000),
                    height: 20 * a,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          content:
                          const Text("Do you want to increase seats??"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {},
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                child: const Text("YES"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.people_alt,
                            color: Colors.black, size: 24 * a),
                        SizedBox(width: 12 * a),
                        Text(
                          'Extra Seat',
                          style: SafeGoogleFont('Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: const Color(0x66000000),
                    height: 20 * a,
                  ),
                  Text(
                    'Cancel',
                    style: SafeGoogleFont('Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.48 * a,
                        color: Colors.black),
                  ),
                  SizedBox(height: 18 * a),
                ],
              ),
            ),
          );
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
          double baseWidth = 360;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return Container(
            color: Colors.white,
            height: 80 * a,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0 * a),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        foregroundImage:
                        const AssetImage('assets/icons/club.png'),
                        radius: 21 * a,
                      ),
                      Text(
                        'Use fun Friends',
                        style: SafeGoogleFont('Poppins',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.48 * a,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(width: 18 * a),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        foregroundImage:
                        const AssetImage('assets/room_icons/ic_wa.png'),
                        radius: 21 * a,
                      ),
                      Text(
                        'Whatsapp',
                        style: SafeGoogleFont('Poppins',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.48 * a,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showMore2BottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 420;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 19.0 * a, vertical: 15 * a),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 10 * a,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const DailyTask());
                    },
                    child: iconTextRow(
                        a, b, 'Daily\nTasks', 'assets/room_icons/b1.png'),
                  ),
                  SizedBox(
                    width: 20 * a,
                  ),
                  InkWell(
                    onTap: showIncomeExpenseBottomSheet,
                    child: iconTextRow(a, b, 'Income &\nExpenditure',
                        'assets/room_icons/b2.png'),
                  ),
                  SizedBox(
                    width: 20 * a,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Shop());
                    },
                    child: iconTextRow(a, b, 'Shop', 'assets/homeim.png'),
                  ),
                  SizedBox(
                    width: 20 * a,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const TabsBar());
                    },
                    child: iconTextRow(
                        a, b, 'Aristocracy', 'assets/room_icons/b4.png'),
                  ),
                  SizedBox(
                    width: 10 * a,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Playlist1());
                    },
                    child: iconTextRow(a, b, 'Music', 'assets/musicc.png'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void inviteMemberSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          double baseWidth = 400;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return SizedBox(
            width: double.infinity,
            height: 700 * a,
            child: Column(
              children: [
                SizedBox(height: 10 * a),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.arrow_back_rounded),
                    Center(
                      child: Text(
                        'Invite PK                                  ',
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(6, 6, 6, 1),
                            'Lato',
                            fontSize: 22 * a,
                            letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.w700,
                            height: 1 * a),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10 * a),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffd9d9d9),
                      borderRadius: BorderRadius.circular(20 * a),
                    ),
                    height: 40 * a,
                    child: const TextField(
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '   Search Room',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30 * a),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '   Recommended Rooms',
                    textAlign: TextAlign.left,
                    style: SafeGoogleFont(
                        color: const Color.fromRGBO(6, 6, 6, 1),
                        'Lato',
                        fontSize: 20 * a,
                        letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.w700,
                        height: 1 * a),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18 * a, vertical: 8 * a),
                    child: Column(
                      children: [
                        for (Map club in roomList.take(3))
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: ListTile(
                                      leading: Image.asset(
                                        club["image"],
                                        fit: BoxFit.contain,
                                        width: 64 * a,
                                        height: 64 * a,
                                      ),
                                      title: Text(
                                        club["name"],
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 16 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.64 * a,
                                          color: const Color(0xff000000),
                                        ),
                                      ),
                                      subtitle: Text(
                                        club["about"],
                                        overflow: TextOverflow.ellipsis,
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 12 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.48 * a,
                                          color: const Color(0x99000000),
                                        ),
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 25 * a,
                                          width: 50 * a,
                                          decoration: const BoxDecoration(
                                            color: Colors.orange,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Invite',
                                              style: SafeGoogleFont(
                                                'Poppins',
                                                fontSize: 12 * b,
                                                fontWeight: FontWeight.w800,
                                                height: 1.5 * b / a,
                                                letterSpacing: 0.48 * a,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                              ]),
                      ],
                    )),
              ],
            ),
          );
        });
  }

  void showMemberProfileBottomSheet(String name, String dp) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 300;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return SizedBox(
            width: double.infinity,
            height: 600 * a,
            child: Stack(
              children: [
                Positioned(
                  top: 20 * a,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 700,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 45 * a),
                        Text(
                          name,
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 17 * b,
                            fontWeight: FontWeight.w400,
                            height: 1 * b / a,
                            color: const Color(0xff000000),
                          ),
                        ),
                        SizedBox(height: 12 * a),
                        lvMemberAdmin(a, b),
                        SizedBox(height: 22 * a),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' Use funs Id - 58948762  ',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 10 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                color: const Color(0x99000000),
                              ),
                            ),
                            Image.asset('assets/people.png'),
                            Text(
                              ' 5 - Followers',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 10 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                color: const Color(0x99000000),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18 * a),
                        Text(
                          'Make a good World without selfishness',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            color: const Color(0x99000000),
                          ),
                        ),
                        SizedBox(height: 38 * a),
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(children: [
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.person_3_rounded,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        'Profile',
                                        textAlign: TextAlign.left,
                                        style: SafeGoogleFont(
                                            color: const Color.fromRGBO(0, 0, 0, 1),
                                            'Poppins',
                                            fontSize: 12 * a,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 40 * a),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.chair_rounded,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        'Leave the seat',
                                        textAlign: TextAlign.left,
                                        style: SafeGoogleFont(
                                            color: const Color.fromRGBO(0, 0, 0, 1),
                                            'Poppins',
                                            fontSize: 12 * a,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                    ],
                                  )
                                ]),
                              ],
                            ),
                            SizedBox(width: 10 * a),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -1,
                  left: Get.width / 2 - 25 * a,
                  child: CircleAvatar(
                    radius: 30 * a,
                    foregroundImage: AssetImage(dp),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showMemberProfileBottomSheet1(String name, String dpp) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 400;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return SizedBox(
            width: double.infinity,
            height: 800 * a,
            child: Stack(
              children: [
                Positioned(
                  top: 20 * a,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 30 * a),
                        Text(
                          name,
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 20 * b,
                            fontWeight: FontWeight.w400,
                            height: 1 * b / a,
                            color: const Color(0xff000000),
                          ),
                        ),
                        SizedBox(height: 12 * a),
                        lvMemberAdmin1(a, b),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' Use funs Id - 58948762  ',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 10 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                color: const Color(0x99000000),
                              ),
                            ),
                            Image.asset('assets/people.png'),
                            Text(
                              ' 0 - Followers',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 10 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                color: const Color(0x99000000),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18 * a),
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 12 * a,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/b2.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(height: 10 * a),
                                Text(
                                  'Profile',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont('Poppins',
                                      fontSize: 14 * b,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * b / a,
                                      letterSpacing: 0.48 * a,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            SizedBox(width: 30 * a),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 12 * a,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.chat,
                                    size: 21 * a,
                                  ),
                                ),
                                SizedBox(height: 10 * a),
                                Text(
                                  'Chat',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont('Poppins',
                                      fontSize: 14 * b,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * b / a,
                                      letterSpacing: 0.48 * a,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(width: 30 * a),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 12 * a,
                                  backgroundColor: Colors.white,
                                  child: Image.asset('assets/@.png'),
                                ),
                                SizedBox(height: 10 * a),
                                Text(
                                  'Mention',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont('Poppins',
                                      fontSize: 14 * b,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5 * b / a,
                                      letterSpacing: 0.48 * a,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20 * a),
                        Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.lock),
                                    onPressed: () {},
                                  ),
                                  const Text('Lock'),
                                ],
                              ),
                              SizedBox(width: 60 * a),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.mic_off_sharp),
                                    onPressed: () {},
                                  ),
                                  const Text('Mute'),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.chair),
                                    onPressed: () {},
                                  ),
                                  const Text('Remove'),
                                ],
                              ),
                              SizedBox(width: 60 * a),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.person),
                                    onPressed: () {},
                                  ),
                                  const Text('Invite'),
                                ],
                              ),
                            ],
                          )
                        ]),
                        SizedBox(height: 30 * a),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 90 * a,
                                height: 26 * a,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromRGBO(255, 153, 51, 1),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12 * a),
                                    topRight: Radius.circular(12 * a),
                                    bottomLeft: Radius.circular(12 * a),
                                    bottomRight: Radius.circular(12 * a),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    'Follow',
                                    textAlign: TextAlign.left,
                                    style: SafeGoogleFont(
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        'Poppins',
                                        fontSize: 12 * a,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                )),
                            Container(
                                width: 90 * a,
                                height: 26 * a,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12 * a),
                                    topRight: Radius.circular(12 * a),
                                    bottomLeft: Radius.circular(12 * a),
                                    bottomRight: Radius.circular(12 * a),
                                  ),
                                  color: const Color.fromRGBO(255, 153, 51, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    'Send Gifts',
                                    textAlign: TextAlign.left,
                                    style: SafeGoogleFont(
                                        color: const Color.fromRGBO(250, 248, 248, 1),
                                        'Poppins',
                                        fontSize: 12 * a,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -3 * a,
                  left: Get.width / 2 - 30 * a,
                  child: CircleAvatar(
                    radius: 40 * a,
                    foregroundImage: AssetImage(dpp),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showMemberProfileBottomSheet2(String name, String dp) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 360;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return Container(
            width: double.infinity,
            height: 800 * a,
            child: Stack(
              children: [
                Positioned(
                  top: 20 * a,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 1000 * a,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 55 * a),
                          Text(
                            name,
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 20 * b,
                              fontWeight: FontWeight.w400,
                              height: 1 * b / a,
                              color: const Color(0xff000000),
                            ),
                          ),
                          SizedBox(height: 12 * a),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' Use funs Id - 58948762  ',
                                style: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 14 * b,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * b / a,
                                  color: const Color(0x99000000),
                                ),
                              ),
                              Image.asset('assets/people.png'),
                              Text(
                                ' 10- Followers',
                                style: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 14 * b,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * b / a,
                                  color: const Color(0x99000000),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18 * a),
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 12 * a,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      'assets/b2.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(height: 10 * a),
                                  Text(
                                    'Profile',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont('Poppins',
                                        fontSize: 14 * b,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5 * b / a,
                                        letterSpacing: 0.48 * a,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(width: 30 * a),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 12 * a,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.chat,
                                      size: 21 * a,
                                    ),
                                  ),
                                  SizedBox(height: 10 * a),
                                  Text(
                                    'Chat',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont('Poppins',
                                        fontSize: 14 * b,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5 * b / a,
                                        letterSpacing: 0.48 * a,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(width: 30 * a),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 12 * a,
                                    backgroundColor: Colors.white,
                                    child: Image.asset('assets/@.png'),
                                  ),
                                  SizedBox(height: 10 * a),
                                  Text(
                                    'Mention',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont('Poppins',
                                        fontSize: 14 * b,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5 * b / a,
                                        letterSpacing: 0.48 * a,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20 * a),
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.mark_chat_read_outlined),
                                      onPressed: () {},
                                    ),
                                    const Text('Ban Chat'),
                                  ],
                                ),
                                SizedBox(width: 60 * a),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.mic_off_sharp),
                                      onPressed: () {},
                                    ),
                                    const Text('Mute'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 60 * a),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.person),
                                  onPressed: () {},
                                ),
                                const Text('Invite'),
                              ],
                            )
                          ]),
                          SizedBox(height: 30 * a),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: 90 * a,
                                  height: 26 * a,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(255, 153, 51, 1),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12 * a),
                                      topRight: Radius.circular(12 * a),
                                      bottomLeft: Radius.circular(12 * a),
                                      bottomRight: Radius.circular(12 * a),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Follow',
                                      textAlign: TextAlign.left,
                                      style: SafeGoogleFont(
                                          color: const Color.fromRGBO(0, 0, 0, 1),
                                          'Poppins',
                                          fontSize: 12 * a,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  )),
                              Container(
                                  width: 90 * a,
                                  height: 26 * a,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12 * a),
                                      topRight: Radius.circular(12 * a),
                                      bottomLeft: Radius.circular(12 * a),
                                      bottomRight: Radius.circular(12 * a),
                                    ),
                                    color: const Color.fromRGBO(255, 153, 51, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Send Gifts',
                                      textAlign: TextAlign.left,
                                      style: SafeGoogleFont(
                                          color:
                                          const Color.fromRGBO(250, 248, 248, 1),
                                          'Poppins',
                                          fontSize: 12 * a,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -3 * a,
                  left: Get.width / 2 - 40 * a,
                  child: CircleAvatar(
                    radius: 35 * a,
                    foregroundImage: AssetImage(dp),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showBottomBar() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 360;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return Container(
              color: Colors.white,
              width: double.infinity,
              height: 90 * a,
              child: Column(children: [
                SizedBox(height: 10 * a),
                Text(
                  'Reset',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w400,
                    height: 1 * b / a,
                    letterSpacing: 0.64 * a,
                    color: const Color(0xff000000),
                  ),
                ),
                Divider(
                  height: 25 * a,
                ),
                Text(
                  '  Update',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 14 * b,
                    fontWeight: FontWeight.w400,
                    height: 1 * b / a,
                    letterSpacing: 0.64 * a,
                    color: const Color(0xff000000),
                  ),
                ),
              ]));
        });
  }

  void showGamesBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 360;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16.0 * a, vertical: 9 * a),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PLAY WITH ANYONE',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 16 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.64 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) => GridView.count(
                        padding: EdgeInsets.all(22 * a),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 3 / 4,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          gamesList.length,
                              (index) => InkWell(
                            onTap: () {
                              if (index == 5) {
                                showBottomBar();
                              }
                              ;
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 6 * a),
                                CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 20,
                                    foregroundImage:
                                    AssetImage(gamesList[index]["image"])),
                                SizedBox(width: 6 * a),
                                Text(
                                  gamesList[index]["name"],
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 14 * b,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.64 * a,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 12 * a,
                                      height: 12 * a,
                                      child: Image.asset(
                                        'assets/icons/ic_game.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 9 * a),
                                    SizedBox(
                                      width: 21 * a,
                                      height: 18 * a,
                                      child: Text(
                                        gamesList[index]["rank"],
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 12 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.48 * a,
                                          color: const Color(0x99000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

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

  void showSendGiftsBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const SendGifts();
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

  void showEmojiBottomSheet() {
    showModalBottomSheet(
        backgroundColor: const Color(0x66000000),
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const Emoji();
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

  void showInviteBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return const InviteUserBottomSheet();
        });
  }
}
