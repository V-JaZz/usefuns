import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:provider/provider.dart';
import '../../../data/model/body/zego_stream_model.dart';
import '../../../provider/user_data_provider.dart';
import '../../../provider/zego_room_provider.dart';
import '../../dashboard/me/profile/user_profile.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/utils_assets.dart';
import '../widget/kick_room.dart';
import 'manager.dart';

class SeatOptions extends StatelessWidget {
  final int index;
  const SeatOptions({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, _) {
        bool isLocked = value.zegoRoom!.lockedSeats.contains(index);
        bool isAllUnLocked = value.zegoRoom!.lockedSeats.isEmpty;
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
                      icon: Icon(isLocked ? Icons.lock_open : Icons.lock,
                          color: Colors.black, size: 24 * a),
                      onPressed: () {
                        List<int> list = value.zegoRoom!.lockedSeats;
                        if(isLocked){
                          list.remove(index);
                        }else{
                          list.add(index);
                        }
                        value.updateLockedSeats(list);
                        Get.back();
                      },
                    ),
                    Text(
                      isLocked ? 'UnLock' : 'Lock',
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
                      icon: Icon(isAllUnLocked ? Icons.lock : Icons.lock_open,
                          color: Colors.black, size: 24 * a),
                      onPressed: () {
                        if(isAllUnLocked){
                          value.updateLockedSeats(List.generate(value.zegoRoom!.totalSeats, (i) => i));
                        }else{
                          value.updateLockedSeats([]);
                        }
                        Get.back();
                      },
                    ),
                    Text(
                      isAllUnLocked ? 'Lock All' : 'UnLock All',
                      style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: Colors.black),
                    )
                  ],
                ),
                Consumer<ZegoRoomProvider>(
                  builder:(context, p, _) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.mic_external_on_rounded,
                            color: Colors.black, size: 24 * a),
                        onPressed: () {
                          if(!p.onSeat){
                            p.startPublishingStream(index);
                          }else{
                            p.stopPublishingStream();
                            p.startPublishingStream(index);
                          }
                          Get.back();
                        },
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
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (){
                        Get.back();
                        LiveRoomBottomSheets(context).showInviteBottomSheet(value.room!.userId!,index);
                      },
                      icon: Icon(Icons.person_add,
                          color: Colors.black, size: 24 * a),
                    ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyProfileSeatBottomSheet extends StatelessWidget {
  final ZegoStreamExtended user;
  const MyProfileSeatBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Consumer<UserDataProvider>(
      builder:(context, value, child) {
        final List<String> admins = Provider.of<ZegoRoomProvider>(context,listen: false).zegoRoom!.admins;
        return Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top : 42*a),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 54 * a),
                Text(
                  value.userData?.data?.name??'',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 17 * b,
                    fontWeight: FontWeight.w400,
                    height: 1 * b / a,
                    color: const Color(0xff000000),
                  ),
                ),
                SizedBox(height: 12 * a),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    userLevelTag(
                      user.level??0,
                      17 * a,
                      viewZero: true
                  ),
                    if(admins.contains(user.streamId)) SizedBox(
                      width: 6*a,
                    ),
                    if(admins.contains(user.streamId)) Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFF9933),
                        borderRadius: BorderRadius.circular(12*a)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                      child: Text(
                        'Admin',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w400,
                          height: 1 * b / a,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if(user.owner == true) SizedBox(
                      width: 6*a,
                    ),
                    if(user.owner == true) Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF138808),
                          borderRadius: BorderRadius.circular(12*a)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                      child: Text(
                        'Owner',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w400,
                          height: 1 * b / a,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if(user.owner != true && user.member == true) SizedBox(
                      width: 6*a,
                    ),
                    if(user.owner != true && user.member == true) Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF9E26BC),
                          borderRadius: BorderRadius.circular(12*a)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                      child: Text(
                        'Member',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w400,
                          height: 1 * b / a,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6*a,
                    ),
                    SizedBox(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
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
                              Icon(Icons.female,size: 16*a),
                            ]
                        )
                    ),
                    SizedBox(
                      width: 6*a,
                    ),
                  ],
                ),
                SizedBox(height: 12 * a),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' Usefuns Id - ${value.userData?.data?.userId??''}  ',
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
                      ' ${value.userData?.data?.followers?.length??''} - Followers',
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
                if((value.userData?.data?.bio??'') != '')SizedBox(height: 12 * a),
                if((value.userData?.data?.bio??'') != '')Text(
                  value.userData?.data?.bio??'',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 12 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    color: const Color(0x99000000),
                  ),
                ),
                SizedBox(height: 24 * a),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          InkWell(
                            onTap: (){
                              Get.to(() => const UserProfile());
                            },
                            child: Column(
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
                          ),
                          SizedBox(width: 40 * a),
                          InkWell(
                            onTap: (){
                              final p = Provider.of<ZegoRoomProvider>(context,listen: false);
                              p.stopPublishingStream();
                              Get.back();
                            },
                            child: Column(
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
                            ),
                          )
                        ]),
                      ],
                    ),
                    SizedBox(width: 10 * a),
                  ],
                ),
                SizedBox(height: 24 * a),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: (Get.width*0.5)-(42*a),
            child: GestureDetector(
              onTap: (){
                Get.back();
                Get.to(() => const UserProfile());
              },
              child: value.userData!.data!.images!.isEmpty
                  ?CircleAvatar(
                radius: 42 * a,
                foregroundImage: const AssetImage('assets/profile.png'),
              )
                  :CircleAvatar(
                radius: 42 * a,
                foregroundImage: NetworkImage(value.userData!.data!.images!.first),
              ),
            ),
          ),
        ],
      );
      },
    );
  }
}

class OthersProfileSeatBottomSheet extends StatelessWidget {
  final ZegoStreamExtended user;
  final bool owner;
  final bool admin;
  const OthersProfileSeatBottomSheet({super.key, required this.user, required this.owner, required this.admin});

  @override
  Widget build(BuildContext context) {
    final bs = LiveRoomBottomSheets(context);
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) => Stack(
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 36 * a),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 45 * a),
                  Text(
                    user.userName??'',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 20 * b,
                      fontWeight: FontWeight.w400,
                      height: 1 * b / a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(height: 6 * a),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        userLevelTag(
                          user.level??0,
                          17 * a,
                          viewZero: true
                      ),
                        if(value.zegoRoom!.admins.contains(user.streamId)) SizedBox(
                          width: 6*a,
                        ),
                        if(value.zegoRoom!.admins.contains(user.streamId)) Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffFF9933),
                              borderRadius: BorderRadius.circular(12*a)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                          child: Text(
                            'Admin',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 14 * b,
                              fontWeight: FontWeight.w400,
                              height: 1 * b / a,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if(user.owner == true) SizedBox(
                          width: 6*a,
                        ),
                        if(user.owner == true) Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF138808),
                            borderRadius: BorderRadius.circular(12*a)
                        ),
                          padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                          child: Text(
                            'Owner',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 14 * b,
                              fontWeight: FontWeight.w400,
                              height: 1 * b / a,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if(user.owner == true||user.member == true) SizedBox(
                          width: 6*a,
                        ),
                        if(user.owner != true && user.member == true) Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFF9E26BC),
                              borderRadius: BorderRadius.circular(12*a)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                          child: Text(
                            'Member',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 14 * b,
                              fontWeight: FontWeight.w400,
                              height: 1 * b / a,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6*a,
                        ),
                        SizedBox(
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
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
                                  Icon(Icons.female,size: 16*a),
                                ]
                            )
                        ),
                        SizedBox(
                          width: 6*a,
                        ),
                      ]),
                  SizedBox(height: 6 * a),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Usefuns Id - ${user.id}  ',
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
                        '  ${user.followers}- Followers',
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
                  SizedBox(height: 24 * a),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 18*a,
                    runSpacing: 24*a,
                    children: [
                      iconTextWidget(
                          text: 'Profile',
                          path: 'assets/icon_p/profile.png',
                          onTap: () async {
                            Get.back();
                            final data = await Provider.of<UserDataProvider>(context,listen: false).addVisitor(user.streamId!);
                            Get.to(()=>UserProfile(userData: data.data));
                          }),
                      iconTextWidget(
                          text: 'Chat',
                          path: 'assets/icon_p/chat.png',
                          onTap: (){
                            Get.back();
                            bs.showMessage();
                          }),
                      iconTextWidget(
                          text: 'Mention',
                          path: 'assets/icon_p/mention.png',
                          onTap: (){
                            Get.back();

                            bs.showMessage(mention: user.userName);
                          }),
                      if((owner || admin)&& user.owner == false) iconTextWidget(
                          text: 'Lock',
                          path: 'assets/icon_p/lock.png',
                          onTap: (){
                            value.lockStreamer(user.streamId!,user.userName!);
                            Get.back();
                          }),
                      if((owner || admin)&& user.owner == false) iconTextWidget(
                          text:  value.roomStreamList.where((e) => e.streamId == user.streamId).first.micPermit == false ? 'Unmute Mic': 'Mute Mic',
                          path: 'assets/icon_p/mute_mic.png',
                          onTap: (){
                            if(value.roomStreamList.where((e) => e.streamId == user.streamId).first.micPermit == false) {
                              value.unMuteStreamer(user.streamId!,user.userName!);
                              showCustomSnackBar('Permitted to use mic',context,isToaster: true,isError: false);
                            } else{
                              value.muteStreamer(user.streamId!,user.userName!);
                            }
                            Get.back();
                          }),
                      if((owner || admin)&& user.owner == false) iconTextWidget(
                          text: value.roomStreamList.where((e) => e.streamId == user.streamId).first.chatBan == true?'Unban Chat':'Ban Chat',
                          path: 'assets/icon_p/ban.png',
                          onTap: (){
                            if(value.roomStreamList.where((e) => e.streamId == user.streamId).first.chatBan == true){
                              value.unbanChat(user.streamId!,user.userName!);
                            }else{
                              value.banChat(user.streamId!,user.userName!);
                            }
                            Get.back();
                          }),
                      if((owner || admin)&& user.owner == false) iconTextWidget(
                          text: 'Kick',
                          path: 'assets/icon_p/kick.png',
                          onTap: (){
                            kickRoomWidget(context, user.userName, user.streamId);
                          }),
                      if((owner || admin)&& user.owner == false) iconTextWidget(
                          text: 'Invite',
                          path: 'assets/icon_p/invite.png',
                          onTap: (){}
                      ),
                      if(owner==true) iconTextWidget(
                          text: value.zegoRoom!.admins.contains(user.streamId) ? 'Remove Admin':'Set Admin',
                          path: 'assets/icon_p/set_admin.png',
                          onTap: () async {
                            final p = Provider.of<RoomsProvider>(context,listen: false);
                            final list = value.zegoRoom!.admins;
                            Get.back();
                            if(value.zegoRoom!.admins.contains(user.streamId)){
                              list.remove(user.streamId);
                              value.updateAdmin(list);
                              await p.removeAdmin(value.room!.id!, user.streamId!);
                            }else if(list.length>3){
                              showCustomSnackBar('Max Admin limit is 4!', context,isToaster: true);
                            }else{
                              list.add(user.streamId!);
                              value.updateAdmin(list);
                              await p.addAdmin(value.room!.id!, user.streamId!);
                            }
                            p.getAllMine();
                          }),
                    ],
                  ),
                  SizedBox(height: 24 * a),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Provider.
                        },
                        child: Container(
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
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                          bs.showSendGiftsBottomSheet(selection: user.userName);
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                  SizedBox(height: 18 * a),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0 * a,
            left: Get.width / 2 - 40 * a,
            child:GestureDetector(
              onTap: () async {
                Get.back();
                final data = await Provider.of<UserDataProvider>(context,listen: false).addVisitor(user.streamId!);
                Get.to(()=>UserProfile(userData: data.data));
              },
              child:  (user.image??'') == ''
                  ? CircleAvatar(
                radius: 36 * a,
                foregroundImage: const AssetImage('assets/profile.png'),
              )
                  : CircleAvatar(
                radius: 36 * a,
                foregroundImage: NetworkImage(user.image??''),
              ),
            )
          ),
        ],
      ),
    );
  }
  iconTextWidget({required String text, required String path,void Function()? onTap}) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: Get.width * 0.27,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 9 * a,
              backgroundColor: Colors.white,
              child: Image.asset(path),
            ),
            SizedBox(height: 6 * a),
            Text(
              text,
              textAlign: TextAlign.center,
              style: SafeGoogleFont('Poppins',
                  fontSize: 14 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  letterSpacing: 0.48 * a,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}


