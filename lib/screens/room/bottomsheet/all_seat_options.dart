import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:provider/provider.dart';
import '../../../data/model/body/zego_stream_model.dart';
import '../../../data/model/response/user_data_model.dart';
import '../../../provider/user_data_provider.dart';
import '../../../provider/zego_room_provider.dart';
import '../../../utils/helper.dart';
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
                      style: safeGoogleFont('Poppins',
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
                      style: safeGoogleFont(
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
                          p.publishStream(index);
                          Get.back();
                        },
                      ),
                      Text(
                        'On mic',
                        style: safeGoogleFont('Poppins',
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
                      style: safeGoogleFont('Poppins',
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
        final List<String> admins = Provider.of<ZegoRoomProvider>(context,listen: false).room!.admin!;
        return Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top : 50*a),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 54 * a),
                Text(
                  value.userData?.data?.name??'',
                  style: safeGoogleFont(
                    'Poppins',
                    fontSize: 17 * b,
                    fontWeight: FontWeight.w400,
                    height: 1 * b / a,
                    color: const Color(0xff000000),
                  ),
                ),
                SizedBox(height: 12 * a),
                Wrap(
                  children: [
                    userLevelTag(
                        value.userData?.data?.level??0,
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
                        style: safeGoogleFont(
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
                        style: safeGoogleFont(
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
                        style: safeGoogleFont(
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
                    for(var v in value.userData!.data!.tags!)
                      Padding(
                        padding: EdgeInsets.only(right: 6*a),
                        child: SvgPicture.network(
                          v.images!.first,
                          fit: BoxFit.fitHeight,
                          height: 19 * a,
                        ),
                      ),
                    SizedBox(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AgeCalculator.calculateAge(value.userData!.data!.dob!).toString(),
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
                      style: safeGoogleFont(
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
                      style: safeGoogleFont(
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
                if((value.userData?.data?.bio??'') != '')Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36 * a),
                  child: Text(
                    value.userData?.data?.bio?.trim()??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: safeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      color: const Color(0x99000000),
                    ),
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
                                  style: safeGoogleFont(
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
                                  style: safeGoogleFont(
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
            left: (Get.width*0.5)-(50*a),
            child: userProfileDisplay(
                size: 100*a,
                image: value.userData!.data!.images!.isEmpty?'':value.userData!.data!.images?.first??'',
                frame: userValidItemSelection(value.userData!.data!.frame),
                onTap: (){
                  Get.back();
                  Get.to(()=>const UserProfile());
                },
            ),
          ),
        ],
      );
      },
    );
  }
}

class OthersProfileSeatBottomSheet extends StatefulWidget {
  final ZegoStreamExtended user;
  final bool owner;
  final bool admin;
  const OthersProfileSeatBottomSheet({super.key, required this.user, required this.owner, required this.admin});

  @override
  State<OthersProfileSeatBottomSheet> createState() => _OthersProfileSeatBottomSheetState();
}

class _OthersProfileSeatBottomSheetState extends State<OthersProfileSeatBottomSheet> {
  late final UserDataProvider userDataProvider;
  late bool follow;
  late bool followBack;
  @override
  void initState() {
    userDataProvider = Provider.of<UserDataProvider>(context,listen: false);
    follow = Provider.of<UserDataProvider>(context,listen: false).userData!.data!.following!.firstWhereOrNull((element) => element == widget.user.streamId)!=null;
    followBack = Provider.of<UserDataProvider>(context,listen: false).userData!.data!.followers!.firstWhereOrNull((element) => element == widget.user.streamId)!=null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bs = LiveRoomBottomSheets(context);
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Consumer<ZegoRoomProvider>(
      builder: (context, value, _) {
        final user = widget.user.userData;
        return Stack(
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
                      user?.name??'',
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 20 * b,
                        fontWeight: FontWeight.w400,
                        height: 1 * b / a,
                        color: const Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 6 * a),
                    Wrap(
                        children: <Widget>[
                          userLevelTag(
                              user?.level??0,
                              17 * a,
                              viewZero: true
                          ),
                          if(value.room!.admin!.contains(widget.user.streamId)) SizedBox(
                            width: 6*a,
                          ),
                          if(value.room!.admin!.contains(widget.user.streamId)) Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffFF9933),
                                borderRadius: BorderRadius.circular(12*a)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                            child: Text(
                              'Admin',
                              style: safeGoogleFont(
                                'Poppins',
                                fontSize: 14 * b,
                                fontWeight: FontWeight.w400,
                                height: 1 * b / a,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if(widget.user.owner == true) SizedBox(
                            width: 6*a,
                          ),
                          if(widget.user.owner == true) Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF138808),
                                borderRadius: BorderRadius.circular(12*a)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                            child: Text(
                              'Owner',
                              style: safeGoogleFont(
                                'Poppins',
                                fontSize: 14 * b,
                                fontWeight: FontWeight.w400,
                                height: 1 * b / a,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if(widget.user.owner == true||widget.user.member == true) SizedBox(
                            width: 6*a,
                          ),
                          if(widget.user.owner != true && widget.user.member == true) Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF9E26BC),
                                borderRadius: BorderRadius.circular(12*a)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                            child: Text(
                              'Member',
                              style: safeGoogleFont(
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
                          for(var v in user!.tags!)
                            Padding(
                              padding: EdgeInsets.only(right: 6*a),
                              child: SvgPicture.network(
                                v.images!.first,
                                fit: BoxFit.fitHeight,
                                height: 19 * a,
                              ),
                            ),
                          SizedBox(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AgeCalculator.calculateAge(user.dob!).toString(),
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
                          ' Usefuns Id - ${user.userId}  ',
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 14 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            color: const Color(0x99000000),
                          ),
                        ),
                        Image.asset('assets/people.png'),
                        Text(
                          '  ${user.followers?.length}- Followers',
                          style: safeGoogleFont(
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
                              Provider.of<UserDataProvider>(context,listen: false).addVisitor(widget.user.streamId!);
                              Get.to(()=>UserProfile(userData: widget.user.userData!));
                            }),
                        iconTextWidget(
                            text: 'Chat',
                            path: 'assets/icon_p/chat.png',
                            onTap: (){
                              Get.back();
                              if(!follow || !followBack){
                                showCustomSnackBar('Must follow from both sides!',context,isToaster: true,isError: false);
                              }else{
                                bs.showNotificationsBottomSheet();
                              }
                            }),
                        iconTextWidget(
                            text: 'Mention',
                            path: 'assets/icon_p/mention.png',
                            onTap: (){
                              Get.back();
                              bs.showMessage(mention: user.name);
                            }),
                        if((widget.owner || widget.admin)&& widget.user.owner == false) iconTextWidget(
                            text: 'Lock',
                            path: 'assets/icon_p/lock.png',
                            onTap: (){
                              value.lockStreamer(widget.user.streamId!,user.name!);
                              Get.back();
                            }),
                        if((widget.owner || widget.admin)&& widget.user.owner == false) iconTextWidget(
                            text:  value.roomStreamList.where((e) => e.streamId == widget.user.streamId).first.micPermit == false ? 'Unmute Mic': 'Mute Mic',
                            path: 'assets/icon_p/mute_mic.png',
                            onTap: (){
                              if(value.roomStreamList.where((e) => e.streamId == widget.user.streamId).first.micPermit == false) {
                                value.unMuteStreamer(widget.user.streamId!,user.name!);
                                showCustomSnackBar('Permitted to use mic',context,isToaster: true,isError: false);
                              } else{
                                value.muteStreamer(widget.user.streamId!,user.name!);
                              }
                              Get.back();
                            }),
                        if((widget.owner || widget.admin)&& widget.user.owner == false) iconTextWidget(
                            text: 'Ban Chat',
                            path: 'assets/icon_p/ban.png',
                            onTap: (){
                              value.banChat(widget.user.streamId!,user.name!);
                              Get.back();
                            }),
                        if((widget.owner || widget.admin)&& widget.user.owner == false) iconTextWidget(
                            text: 'Kick',
                            path: 'assets/icon_p/kick.png',
                            onTap: (){
                              kickRoomWidget(context, user.name, widget.user.streamId);
                            }),
                        if((widget.owner || widget.admin)&& widget.user.owner == false) iconTextWidget(
                            text: 'Invite',
                            path: 'assets/icon_p/invite.png',
                            onTap: (){}
                        ),
                        if(widget.owner==true) iconTextWidget(
                            text: value.room!.admin!.contains(widget.user.streamId) ? 'Remove Admin':'Set Admin',
                            path: 'assets/icon_p/set_admin.png',
                            onTap: () async {
                              final p = Provider.of<RoomsProvider>(context,listen: false);
                              Get.back();
                              if(value.room!.admin!.contains(widget.user.streamId)){
                                value.room!.admin!.remove(widget.user.streamId);
                                await p.removeAdmin(value.room!.id!, widget.user.streamId!);
                                value.updateAdminList();
                              }else if(value.room!.admin!.length >= 20){
                                showCustomSnackBar('Maximum admin limit is 20!', Get.context!);
                              }else{
                                value.room!.admin!.add(widget.user.streamId!);
                                await p.addAdmin(value.room!.id!, widget.user.streamId!);
                                value.updateAdminList();
                              }
                            }),
                      ],
                    ),
                    SizedBox(height: 24 * a),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<UserDataProvider>(
                            builder:(context, up , _) =>
                                GestureDetector(
                                  onTap: () async {
                                    if(follow){
                                      final res = await up.unFollowUser(userId: widget.user.streamId!);
                                      if(res.status == 1){
                                        setState(() {
                                          follow = false;
                                        });
                                      }else{
                                        showCustomSnackBar('error unfollowing user!', Get.context!, isToaster: true);
                                      }
                                    }else{
                                      final res = await up.followUser(userId: widget.user.streamId!);
                                      if(res.status == 1){
                                        setState(() {
                                          follow = true;
                                        });
                                      }else{
                                        showCustomSnackBar('error following user!', Get.context!, isToaster: true);
                                      }
                                    }
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
                                        child: up.isFollowLoading
                                            ? Padding(
                                          padding: EdgeInsets.all(3*a),
                                          child: const AspectRatio(
                                              aspectRatio: 1,
                                              child: CircularProgressIndicator(color: Color.fromRGBO(255, 153, 51, 1))
                                          ),
                                        )
                                            : Text(
                                          follow?'Unfollow':'Follow',
                                          textAlign: TextAlign.left,
                                          style: safeGoogleFont(
                                              color: const Color.fromRGBO(0, 0, 0, 1),
                                              'Poppins',
                                              fontSize: 12 * a,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      )),
                                )
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.back();
                            bs.showSendGiftsBottomSheet(selection: user);
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
                                  style: safeGoogleFont(
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
              top: 0,
              left: (Get.width*0.5)-(40*a),
              child: userProfileDisplay(
                size: 80*a,
                image: user.images?.first??'',
                frame: userValidItemSelection(user.frame),
                onTap: () async {
                  Get.back();
                  Provider.of<UserDataProvider>(context,listen: false).addVisitor(widget.user.streamId!);
                  Get.to(()=>UserProfile(userData: widget.user.userData!));
                },
              ),
            ),
          ],
        );
      },
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
              style: safeGoogleFont('Poppins',
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


class AudienceBottomSheet extends StatefulWidget {
  final UserData user;
  final bool owner;
  final bool admin;
  const AudienceBottomSheet({super.key, required this.user, required this.owner, required this.admin});

  @override
  State<AudienceBottomSheet> createState() => _AudienceBottomSheetState();
}

class _AudienceBottomSheetState extends State<AudienceBottomSheet> {
  late final UserDataProvider userDataProvider;
  late bool follow;
    late bool followBack;

  @override
  void initState() {
    userDataProvider = Provider.of<UserDataProvider>(context,listen: false);
    follow = Provider.of<UserDataProvider>(context,listen: false).userData!.data!.following!.firstWhereOrNull((element) => element == widget.user.id)!=null;
    followBack = Provider.of<UserDataProvider>(context,listen: false).userData!.data!.followers!.firstWhereOrNull((element) => element == widget.user.id)!=null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bs = LiveRoomBottomSheets(context);
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Consumer<ZegoRoomProvider>(
      builder: (context, value, _) {
        final user = widget.user;
        return Stack(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 52 * a),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 45 * a),
                    Text(
                      user.name??'',
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 20 * b,
                        fontWeight: FontWeight.w400,
                        height: 1 * b / a,
                        color: const Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 6 * a),
                    Wrap(
                        children: <Widget>[
                          userLevelTag(
                              user.level??0,
                              17 * a,
                              viewZero: true
                          ),
                          if(value.room!.admin!.contains(widget.user.id)) SizedBox(
                            width: 6*a,
                          ),
                          if(value.room!.admin!.contains(widget.user.id)) Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffFF9933),
                                borderRadius: BorderRadius.circular(12*a)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                            child: Text(
                              'Admin',
                              style: safeGoogleFont(
                                'Poppins',
                                fontSize: 14 * b,
                                fontWeight: FontWeight.w400,
                                height: 1 * b / a,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if(widget.user.id == value.room?.userId) SizedBox(
                            width: 6*a,
                          ),
                          if(widget.user.id == value.room?.userId) Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF138808),
                                borderRadius: BorderRadius.circular(12*a)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                            child: Text(
                              'Owner',
                              style: safeGoogleFont(
                                'Poppins',
                                fontSize: 14 * b,
                                fontWeight: FontWeight.w400,
                                height: 1 * b / a,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if(widget.user.id != value.room?.userId || value.room!.groupMembers!.contains(value.room!.userId)) SizedBox(
                            width: 6*a,
                          ),
                          if(widget.user.id != value.room?.userId && value.room!.groupMembers!.contains(widget.user.id)) Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF9E26BC),
                                borderRadius: BorderRadius.circular(12*a)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 6 *a , vertical: 2*a),
                            child: Text(
                              'Member',
                              style: safeGoogleFont(
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
                          for(var v in user.tags!)
                            Padding(
                              padding: EdgeInsets.only(right: 6*a),
                              child: SvgPicture.network(
                                v.images!.first,
                                fit: BoxFit.fitHeight,
                                height: 19 * a,
                              ),
                            ),
                          SizedBox(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AgeCalculator.calculateAge(user.dob!).toString(),
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
                          ' Usefuns Id - ${user.userId}  ',
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 14 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            color: const Color(0x99000000),
                          ),
                        ),
                        Image.asset('assets/people.png'),
                        Text(
                          '  ${user.followers?.length}- Followers',
                          style: safeGoogleFont(
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
                              Provider.of<UserDataProvider>(context,listen: false).addVisitor(widget.user.id!);
                              Get.to(()=>UserProfile(userData: widget.user));
                            }),
                        iconTextWidget(
                            text: 'Chat',
                            path: 'assets/icon_p/chat.png',
                            onTap: (){
                              Get.back();
                              if(!follow || !followBack){
                                showCustomSnackBar('Must follow from both sides!',context,isToaster: true,isError: false);
                              }else{
                                bs.showNotificationsBottomSheet();
                              }
                            }),
                        iconTextWidget(
                            text: 'Mention',
                            path: 'assets/icon_p/mention.png',
                            onTap: (){
                              Get.back();
                              bs.showMessage(mention: user.name);
                            }),
                        if((widget.owner || widget.admin)&& widget.user.id != value.room?.userId) iconTextWidget(
                            text: 'Ban Chat',
                            path: 'assets/icon_p/ban.png',
                            onTap: (){
                              value.banChat(widget.user.id!,user.name!);
                              Get.back();
                            }),
                        if((widget.owner || widget.admin) && widget.user.id != value.room?.userId) iconTextWidget(
                            text: 'Kick',
                            path: 'assets/icon_p/kick.png',
                            onTap: (){
                              kickRoomWidget(context, user.name, widget.user.id);
                            }),
                        if(widget.owner==true) iconTextWidget(
                            text: value.room!.admin!.contains(widget.user.id) ? 'Remove Admin':'Set Admin',
                            path: 'assets/icon_p/set_admin.png',
                            onTap: () async {
                              final p = Provider.of<RoomsProvider>(context,listen: false);
                              Get.back();
                              if(value.room!.admin!.contains(widget.user.id)){
                                value.room!.admin!.remove(widget.user.id);
                                await p.removeAdmin(value.room!.id!, widget.user.id!);
                                value.updateAdminList();
                              }else if(value.room!.admin!.length >= 20){
                                showCustomSnackBar('Maximum admin limit is 20!', Get.context!);
                              }else{
                                value.room!.admin!.add(widget.user.id!);
                                await p.addAdmin(value.room!.id!, widget.user.id!);
                                value.updateAdminList();
                              }
                            }),
                      ],
                    ),
                    SizedBox(height: 24 * a),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<UserDataProvider>(
                            builder:(context, up , _) =>
                                GestureDetector(
                                  onTap: () async {
                                    if(follow){
                                      final res = await up.unFollowUser(userId: widget.user.id!);
                                      if(res.status == 1){
                                        setState(() {
                                          follow = false;
                                        });
                                      }else{
                                        showCustomSnackBar('error unfollowing user!', Get.context!, isToaster: true);
                                      }
                                    }else{
                                      final res = await up.followUser(userId: widget.user.id!);
                                      if(res.status == 1){
                                        setState(() {
                                          follow = true;
                                        });
                                      }else{
                                        showCustomSnackBar('error following user!', Get.context!, isToaster: true);
                                      }
                                    }
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
                                        child: up.isFollowLoading
                                            ? Padding(
                                          padding: EdgeInsets.all(3*a),
                                          child: const AspectRatio(
                                              aspectRatio: 1,
                                              child: CircularProgressIndicator(color: Color.fromRGBO(255, 153, 51, 1))
                                          ),
                                        )
                                            : Text(
                                          follow?'Unfollow':'Follow',
                                          textAlign: TextAlign.left,
                                          style: safeGoogleFont(
                                              color: const Color.fromRGBO(0, 0, 0, 1),
                                              'Poppins',
                                              fontSize: 12 * a,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      )),
                                )
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.back();
                            bs.showSendGiftsBottomSheet(selection: user);
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
                                  style: safeGoogleFont(
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
              top: 0,
              left: (Get.width*0.5)-(50*a),
              child: userProfileDisplay(
                size: 100*a,
                image: user.images?.first??'',
                frame: userValidItemSelection(user.frame),
                onTap: () async {
                  Get.back();
                  Provider.of<UserDataProvider>(context,listen: false).addVisitor(widget.user.id!);
                  Get.to(()=>UserProfile(userData: widget.user));
                },
              ),
            ),
          ],
        );
      },
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
              style: safeGoogleFont('Poppins',
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

