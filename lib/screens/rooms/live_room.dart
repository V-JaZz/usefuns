import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/body/zego_broadcast_model.dart';
import 'package:live_app/screens/rooms/widgets/widgets.dart';
import 'package:live_app/subscreens/scree/live_record.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../../data/model/response/rooms_model.dart';
import '../../provider/zego_room_provider.dart';
import '../../utils/common_widgets.dart';

class LiveRoom extends StatefulWidget {
  const LiveRoom({Key? key}) : super(key: key);

  @override
  State<LiveRoom> createState() => _LiveRoomState();
}

bool isPressed = true;
String neImg = 'assets/plus.png';
String currentImag = 'assets/plus.png';

class _LiveRoomState extends State<LiveRoom> {

  bool isLocked = true;
  bool isPressed = true;

  late final ZegoRoomProvider zegoRoomProvider;

  bool _isMicrophonePermissionGranted = false;

  late final RoomWidgets w;
  final List<Map> rooms = [
    {'locked': false, 'name': 'Ariful islam', 'image': 'assets/dummy/b1.png'},
    {'locked': false, 'name': 'Liza', 'image': 'assets/dummy/g4.png'},
    {'locked': true},
    {'locked': true},
    {'locked': true},
    {'locked': true},
    {'locked': false, 'name': 'Rahul', 'image': 'assets/dummy/b2.png'},
    {'locked': true},
  ];

  void changeImage() {
    setState(() {
      // Update the image path variable to the desired image path
      currentImag = neImg;
    });
  }

  Future<void> requestMicrophonePermission() async {
    PermissionStatus microphoneStatus = await Permission.microphone.request();
    setState(() {
      _isMicrophonePermissionGranted = microphoneStatus.isGranted;
      zegoRoomProvider.isMicOn = true;
    });
  }

  @override
  void initState() {

    w = RoomWidgets(context);
    zegoInit();

    Permission.microphone.status.then((value) => setState(() =>
    _isMicrophonePermissionGranted = value == PermissionStatus.granted));

    super.initState();
  }


  @override
  void dispose() {
    zegoDispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: const Color(0xFF26436b),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
            padding: EdgeInsets.fromLTRB(0 * a, 15 * a, 0 * a, 15 * a),
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(12 * a, 0 * a, 12 * a, 18 * a),
                        height: 38 * a,
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: w.showRoomProfileBottomSheet,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        13 * a, 23 * a, 1 * a, 1 * a),
                                    height: 38 * a,
                                    width: 38 * a,
                                    decoration: BoxDecoration(
                                      image: value.room!.images!.isEmpty
                                          ? const DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          'assets/room_icons/ic_room_dp.png',
                                        ),
                                      )
                                          : DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                          value.room!.images!.first,
                                        ),
                                      ),
                                    ),
                                    child: value.room!.isLocked == true
                                        ?Align(
                                      alignment: Alignment.bottomRight,
                                      child: SizedBox(
                                        width: 24 * a,
                                        height: 14 * a,
                                        child: Image.asset(
                                          'assets/room_icons/lock.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    )
                                        :null,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        5 * a, 4 * a, 0 * a, 0 * a),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        MarqueeText(
                                          text : TextSpan(text:value.room?.name??''),
                                          style: SafeGoogleFont(
                                            'Lato',
                                            fontSize: 14 * b,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2000000817 * b / a,
                                            color: const Color(0xfffdf9f9),
                                          ),
                                          speed: 12
                                        ),
                                        Text(
                                          'ID ${value.room?.roomId}',
                                          style: SafeGoogleFont(
                                            'Lato',
                                            fontSize: 9 * b,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2 * b / a,
                                            color: const Color(0x99fcf3f3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            TextButton(
                              onPressed: w.showActiveBottomSheet,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Online\n${value.activeCount}',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2000000477,
                                  color: const Color(0x99ffffff),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * a, 0 * a, 9 * a, 6 * a),
                                    width: 18 * a,
                                    height: 18 * a,
                                    child: InkWell(
                                      onTap: w.showShareBottomSheet,
                                      child: Image.asset(
                                        'assets/room_icons/ic_share.png',
                                        color: Colors.white,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * a, 0 * a, 0 * a, 6 * a),
                                    child: InkWell(
                                      onTap: w.showMore1BottomSheet,
                                      child: Icon(Icons.more_horiz_outlined,
                                          color: Colors.white,
                                          size: 24 * a),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * a, 0 * a, 0 * a, 6 * a),
                                    child: IconButton(
                                      icon: Icon(
                                          Icons.power_settings_new_rounded,
                                          color: Colors.white,
                                          size: 21 * a),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                Colors.transparent,
                                                content: Container(
                                                  color: Colors.transparent,
                                                  height: 350,
                                                  width: 5,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                          height: 5 * a),
                                                      Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              55),
                                                          color:
                                                          Colors.amber,
                                                        ),
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons
                                                                  .arrow_upward_rounded,
                                                              size: 70 * a),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 120 * a),
                                                      Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              55),
                                                          color:
                                                          Colors.amber,
                                                        ),
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons
                                                                  .power_settings_new_sharp,
                                                              size: 70 * a),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.fromLTRB(20 * a, 0 * a, 20 * a, 20 * a),
                        width: double.infinity,
                        height: 25 * a,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                w.showGroupMemberBottomSheet(value.room?.groupMembers??[]);
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(0 * a, 8 * a, 0 * a, 3 * a),
                                height: double.infinity,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0 * a, horizontal: 6 * a),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9 * a),
                                    color: const Color(0xff9e26bc),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/room_icons/ic_heart_arrow.png',
                                        fit: BoxFit.cover,
                                        width: 9 * a,
                                        height: 9 * a,
                                      ),
                                      SizedBox(width: 1 * a),
                                      Text(
                                        'Group ${value.room?.groupName ?? '1'}',
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 9 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.36 * a,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const LiveRecord());
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0 * a, 8 * a, 0 * a, 3 * a),
                                width: 80 * a,
                                height: double.infinity,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0 * a, horizontal: 6 * a),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9 * a),
                                    color: const Color(0xff9e26bc),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/room_icons/pink_diamond.png',
                                        fit: BoxFit.cover,
                                        width: 9 * a,
                                        height: 9 * a,
                                      ),
                                      SizedBox(width: 1 * a),
                                      Text(
                                        'RoomBonus',
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 9 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.36 * a,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  12 * a, 4 * a, 9 * a, 4 * a),
                              decoration: BoxDecoration(
                                color: const Color(0x33000000),
                                borderRadius: BorderRadius.circular(12 * a),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: w.showContributionBottomSheet,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * a, 0 * a, 12 * a, 0 * a),
                                      width: 21 * a,
                                      height: 21 * a,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(9 * a),
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/dummy/b1.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: w.showContributionBottomSheet,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * a, 0 * a, 12 * a, 0 * a),
                                      width: 21 * a,
                                      height: 21 * a,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(9 * a),
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/dummy/b2.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: w.showContributionBottomSheet,
                                    child: Container(
                                      width: 21 * a,
                                      height: 21 * a,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(9 * a),
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/dummy/b3.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3 * a,
                                  ),
                                  InkWell(
                                    onTap: w.showContributionBottomSheet,
                                    child: Icon(
                                      Icons.chevron_right_rounded,
                                      color: Colors.white,
                                      size: 18 * a,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 170 * a,
                        width: 270 * a,
                        child: GridView.count(
                            crossAxisCount: 4,
                            childAspectRatio: 4 / 5,
                            children: List.generate(
                              8,
                              (i) {
                                if((value.roomStreamList.length??0)>i) {
                                  return GestureDetector(
                                onTap: () {
                                  if (rooms[i]['locked']) {
                                    w.showClickLockedBottomSheet();
                                  } else {
                                    if (i == 1) {
                                      w.showMemberProfileBottomSheet1(
                                          rooms[1]['name'], rooms[1]['image']);
                                    } else if (i == 0) {
                                      w.showMemberProfileBottomSheet2(
                                          rooms[0]['name'], rooms[0]['image']);
                                    } else {
                                      w.showMemberProfileBottomSheet(
                                          rooms[i]['name'], rooms[i]['image']);
                                    }
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 50 * a,
                                      height: 50 * a,
                                      decoration: BoxDecoration(
                                          image: (value.roomStreamList[i].zegoStream.extraInfo??'')== '' ?DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/profile.png' ??
                                                  (isPressed
                                                      ? currentImag
                                                      : neImg),
                                            ),
                                            scale: 3,
                                            alignment: Alignment.center,
                                          )
                                              :DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              value.roomStreamList[i].zegoStream.extraInfo??'',
                                            ),
                                            scale: 3,
                                            alignment: Alignment.center,
                                          ),
                                          shape: BoxShape.circle),
                                      child: Visibility(
                                        visible: (value.roomStreamList[i].reaction??'')!='',
                                        child: Builder(
                                          builder:(context) {
                                            value.emojiTimer(i,value.roomStreamList[i].reaction!);
                                            return CircleAvatar(
                                              radius: 25*a,
                                              foregroundImage: AssetImage('assets/emoji/${value.roomStreamList[i].reaction}.png'),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5 * a),
                                    SizedBox(
                                      width: 60 * a,
                                      child: Text(
                                        value.roomStreamList[i].zegoStream.user.userName ?? '',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 10 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.4 * a,
                                          color: const Color(0xffffffff),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              );
                                }
                                return GestureDetector(
                                  onTap: () {
                                    log(value.roomUsersList.length.toString()??'null');
                                    log(value.roomStreamList.length.toString()??'null');
                                      w.showClickLockedBottomSheet();
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 50 * a,
                                        height: 50 * a,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                isPressed
                                                        ? currentImag
                                                        : neImg,
                                              ),
                                              scale: 3,
                                              alignment: Alignment.center,
                                            ),
                                            shape: BoxShape.circle),
                                      ),
                                      SizedBox(height: 5 * a),
                                      SizedBox(
                                        width: 60 * a,
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 10 * b,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * b / a,
                                            letterSpacing: 0.4 * a,
                                            color: const Color(0xffffffff),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                insetPadding: const EdgeInsets.only(
                                    bottom: 60, left: 10, right: 10),
                                backgroundColor: const Color(0x669e26bc),
                                shape: ShapeBorder.lerp(
                                    InputBorder.none, InputBorder.none, 0),
                                content: Container(
                                  width: 400 * a,
                                  padding: EdgeInsets.only(bottom: 70 * a),
                                  child: SizedBox(
                                    height: 48 * a,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8 * a),
                                              child: Icon(
                                                  CupertinoIcons.question_circle,
                                                  color: Colors.white,
                                                  size: 12 * a),
                                            ),
                                            Text(
                                              'Rahul ',
                                              style: SafeGoogleFont(
                                                'Poppins',
                                                fontSize: 10 * b,
                                                fontWeight: FontWeight.w400,
                                                height: 1.5 * b / a,
                                                letterSpacing: 0.4 * a,
                                                color: const Color(0xffffffff),
                                              ),
                                            ),
                                            SizedBox(width: 20 * a),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Spacer(flex: 2),
                                            Container(
                                              width: 64 * a,
                                              height: 17 * a,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(9 * a),
                                                color: const Color(0xffffe500),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                        CupertinoIcons.heart_fill,
                                                        size: 12 * a),
                                                    Text(
                                                      ' Match',
                                                      style: SafeGoogleFont(
                                                        'Poppins',
                                                        fontSize: 9 * b,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.5 * b / a,
                                                        letterSpacing: 0.36 * a,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(flex: 1),
                                            GestureDetector(
                                              onTap: () {
                                                w.inviteMemberSheet();
                                              },
                                              child: Container(
                                                width: 64 * a,
                                                height: 17 * a,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9 * a),
                                                  color: const Color(0xffffe500),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons.person_add,
                                                          size: 12 * a),
                                                      Text(
                                                        ' Invite',
                                                        style: SafeGoogleFont(
                                                          'Poppins',
                                                          fontSize: 9 * b,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.5 * b / a,
                                                          letterSpacing: 0.36 * a,
                                                          color: const Color(
                                                              0xff000000),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Spacer(flex: 2),
                                          ],
                                        ),
                                        Text(
                                          'Participating in PK will Help to gather Your room Members',
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 6 * b,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * b / a,
                                            letterSpacing: 0.24 * a,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 70 * a,
                          height: 25 * a,
                          margin: EdgeInsets.only(top: 8 * a),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              'PK',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 20 * b,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                letterSpacing: 0.48 * a,
                                color: const Color.fromARGB(255, 225, 198, 159),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 210 * a,
                            height: 270 * a,
                            child: ListView(
                              controller: value.scrollController,
                              children: List.generate(
                                value.broadcastMessageList?.length??0,
                                (index) {
                                  final ZegoBroadcastMessageInfo message = value.broadcastMessageList![index];
                                  final ZegoBroadcastModel body = zegoBroadcastModelFromJson(message.message);
                                  return Container(
                                    width: 210*a,
                                  margin: EdgeInsets.only(bottom: 6 * a),
                                  child: GestureDetector(
                                    onTap: () {
                                      // showModalBottomSheet(
                                      //     context: context,
                                      //     builder: (BuildContext context) {
                                      //       return Container();
                                      //     });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          11 * a, 2 * a, 11 * a, 2 * a),
                                      decoration: const BoxDecoration(
                                        color: Color(0x66090000),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          body.image == null
                                              ?CircleAvatar(
                                            foregroundImage: const AssetImage(
                                              'assets/profile.png',
                                            ),
                                            radius: 15 * a,
                                          )
                                              :CircleAvatar(
                                            foregroundImage: NetworkImage(
                                              body.image!,
                                            ),
                                            radius: 15 * a,
                                          ),
                                          SizedBox(width: 3 * a),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0 * a, 11 * a, 6 * a, 0 * a),
                                            padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 3),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff9e26bc),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      9 * a),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Member',
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 6 * b,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5 * b / a,
                                                  letterSpacing: 0.24 * a,
                                                  color:
                                                      const Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * a, 5 * a, 0 * a, 4 * a),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    message.fromUser.userName,
                                                    style: SafeGoogleFont(
                                                      'Poppins',
                                                      fontSize: 12 * b,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.5 * b / a,
                                                      letterSpacing: 0.48 * a,
                                                      color: const Color(
                                                          0xffffffff),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 10 * a,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9 * a),
                                                      color: const Color(
                                                          0xff4285f4),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                            width: 3 * a),
                                                        Image.asset(
                                                          'assets/room_icons/blue_diamond.png',
                                                          fit: BoxFit.cover,
                                                          width: 8 * a,
                                                          height: 8 * a,
                                                        ),
                                                        SizedBox(
                                                            width: 4 * a),
                                                        Text(
                                                          'lv.${body.level}',
                                                          style:
                                                              SafeGoogleFont(
                                                            'Poppins',
                                                            fontSize: 8 * b,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                            height:
                                                                1.5 * b / a,
                                                            letterSpacing:
                                                                0.32 * a,
                                                            color: const Color(
                                                                0xffffffff),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: 5 * a),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      body.message!,
                                                      style: SafeGoogleFont(
                                                        'Poppins',
                                                        fontSize: 12 * b,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.5 * b / a,
                                                        letterSpacing: 0.48 * a,
                                                        color: const Color(
                                                            0xffffffff),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 12*a),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/room_icons/win_rewards.png',
                                  fit: BoxFit.cover,
                                  width: 45 * a,
                                  height: 42 * a,
                                ),
                                SizedBox(height: 18 * a),
                                IconButton(
                                  onPressed : (){},
                                  icon: Image.asset(
                                    'assets/room_icons/ic_cards.png',
                                    fit: BoxFit.cover,
                                    width: 28 * a,
                                    height: 28 * a,
                                  ),
                                ),
                                SizedBox(height: 9 * a),
                                IconButton(
                                  onPressed : (){},
                                  icon: Image.asset(
                                    'assets/room_icons/ic_rose.png',
                                    fit: BoxFit.cover,
                                    width: 27 * a,
                                    height: 27 * a,
                                  ),
                                ),
                                SizedBox(height: 9 * a),
                                IconButton(
                                  onPressed: w.showTreasuresBottomSheet,
                                  icon: Image.asset(
                                    'assets/room_icons/ic_treasure.png',
                                    width: 27 * a,
                                    height: 27 * a,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 9 * a),
                                IconButton(
                                  onPressed: w.showNotifyBottomSheet,
                                  icon: Image.asset(
                                    'assets/room_icons/ic_messages.png',
                                    fit: BoxFit.cover,
                                    width: 27 * a,
                                    height: 27 * a,
                                  ),
                                ),
                                SizedBox(height: 9 * a),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(13 * a, 0 * a, 11 * a, 0 * a),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                            zegoRoomProvider.muteAudio(zegoRoomProvider.isSoundOn);
                        },
                        icon: Icon(
                            zegoRoomProvider.isSoundOn
                                ? Icons.volume_up_outlined
                                : Icons.volume_off_outlined,
                            color: Colors.white,
                            size: 27 * a),
                      ),
                      IconButton(
                        onPressed: () {
                          if(_isMicrophonePermissionGranted){
                              zegoRoomProvider.muteMicrophone(zegoRoomProvider.isMicOn);
                          }else{
                            requestMicrophonePermission();
                          }
                        },
                        icon: Icon(
                            zegoRoomProvider.isMicOn && _isMicrophonePermissionGranted ? Icons.mic_rounded : Icons.mic_off_rounded,
                            color: Colors.white,
                            size: 27 * a),
                      ),
                      IconButton(
                        onPressed: w.showMessage,
                        icon: Icon(Icons.messenger_outline_rounded,
                            color: Colors.white, size: 28 * a),
                      ),
                      IconButton(
                        onPressed: w.showEmojiBottomSheet,
                        icon: Icon(CupertinoIcons.smiley,
                            color: Colors.white, size: 28 * a),
                      ),
                      IconButton(
                        onPressed: w.showSendGiftsBottomSheet,
                        icon: SizedBox(
                          width: 27 * a,
                          height: 27 * a,
                          child: Image.asset(
                            'assets/room_icons/ic_gift.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: w.showGamesBottomSheet,
                        icon: SizedBox(
                          width: 27 * a,
                          height: 27 * a,
                          child: Image.asset(
                            'assets/room_icons/ic_game_c.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: w.showMore2BottomSheet,
                        icon: Icon(
                          CupertinoIcons.line_horizontal_3,
                          color: Colors.white,
                          size: 27 * a,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void zegoInit() {
    zegoRoomProvider = Provider.of<ZegoRoomProvider>(context,listen: false);
    zegoRoomProvider.setZegoEventCallback();
    zegoRoomProvider.createEngine();
    zegoRoomProvider.loginRoom();
    zegoRoomProvider.startPublishingStream();
    zegoRoomProvider.init();
  }

  void zegoDispose() async {
    zegoRoomProvider.destroyEngine();
    zegoRoomProvider.clearZegoEventCallback();
    zegoRoomProvider.roomUsersList = [];
    zegoRoomProvider.roomStreamList = [];
    zegoRoomProvider.broadcastMessageList?.clear();
    zegoRoomProvider.activeCount = 0;
  }
}
