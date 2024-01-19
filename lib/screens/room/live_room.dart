import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/body/zego_broadcast_model.dart';
import 'package:live_app/screens/room/widget/power_options.dart';
import 'package:live_app/screens/room/widget/sound_visualizer.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../../data/model/body/zego_stream_model.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../data/model/response/room_gift_history_model.dart';
import '../../provider/gifts_provider.dart';
import '../../provider/user_data_provider.dart';
import '../../provider/zego_room_provider.dart';
import '../../utils/helper.dart';
import 'widget/live_record.dart';
import '../../utils/common_widgets.dart';
import '../../utils/zego_config.dart';
import '../dashboard/me/profile/user_profile.dart';
import 'bottomsheet/manager.dart';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class LiveRoom extends StatefulWidget {
  const LiveRoom({Key? key}) : super(key: key);

  @override
  State<LiveRoom> createState() => _LiveRoomState();
}

class _LiveRoomState extends State<LiveRoom> with TickerProviderStateMixin{

  late final LiveRoomBottomSheets bs;
  late final ZegoRoomProvider zegoRoomProvider;

  @override
  void initState() {
    WakelockPlus.enable();
    zegoRoomProvider = Provider.of<ZegoRoomProvider>(context,listen: false);
    bs = LiveRoomBottomSheets(context);
    Permission.microphone.status.then((value) => zegoRoomProvider.isMicrophonePermissionGranted = value == PermissionStatus.granted);
    zegoRoomProvider.vsync = this;
    Provider.of<GiftsProvider>(context,listen: false).getAllContribution(zegoRoomProvider.room!.id!);
    super.initState();
  }

  @override
  void dispose() {
    zegoRoomProvider.broadcastMessageList?.clear();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return WillPopScope(
      onWillPop: () async {
        viewPowerDailog();
        return false;
      },
      child: Consumer<ZegoRoomProvider>(
        builder: (context, value, _) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SvgPicture.asset(
                'assets/room_bg.svg',
                height: Get.height,
                width: Get.width,
                fit: BoxFit.fill,
              ),
              if(value.backgroundImage!=null)Image.network(
                value.backgroundImage!,
                height: Get.height,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              SafeArea(
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
                                      onTap: bs.showRoomProfileBottomSheet,
                                      child: Container(
                                        height: 38 * a,
                                        width: 38 * a,
                                        padding: const EdgeInsets.only(right: 4, bottom: 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          image: value.room!.images!.isEmpty
                                              ? const DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'assets/room_icons/ic_room_dp.png',
                                            ),
                                          )
                                              : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              value.room!.images!.first,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.bottomRight,
                                        child: value.roomPassword != null
                                            ?SizedBox(
                                              width: 12 * a,
                                              height: 15 * a,
                                              child: Image.asset(
                                                'assets/room_icons/lock.png',
                                                fit: BoxFit.fitHeight,
                                              ),
                                            )
                                            :null,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            7 * a, 4 * a, 0 * a, 0 * a),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                          children: [
                                            MarqueeText(
                                              text : TextSpan(text:value.room?.name??''),
                                              style: SafeGoogleFont(
                                                'Lato',
                                                fontSize: 15 * b,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2000000817 * b / a,
                                                color: const Color(0xfffdf9f9),
                                              ),
                                              speed: 12
                                            ),
                                            SizedBox(height: 1*a),
                                            Expanded(
                                              child: Text(
                                                'ID ${value.room?.roomId}',
                                                overflow: TextOverflow.ellipsis,
                                                style: SafeGoogleFont(
                                                  'Lato',
                                                  fontSize: 11 * b,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2 * b / a,
                                                  color: const Color(0x99fcf3f3),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                TextButton(
                                  onPressed: (){bs.showActiveUsersBottomSheet(value.room!.userId!);},
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
                                      color: Colors.white70,
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
                                            0 * a, 0 * a, 0 * a, 6 * a),
                                        child: IconButton(
                                          onPressed: bs.showShareBottomSheet,
                                          icon: Icon(
                                              Icons.share_outlined,
                                              color: Colors.white70,
                                              size: 21 * a),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0 * a, 0 * a, 0 * a, 6 * a),
                                        child: InkWell(
                                          onTap: (){
                                            bs.showTopMoreBottomSheet(
                                                value.isOwner);
                                            },
                                          child: Icon(Icons.more_horiz_outlined,
                                              color: Colors.white70,
                                              size: 24 * a),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0 * a, 0 * a, 0 * a, 6 * a),
                                        child: IconButton(
                                          icon: Icon(
                                              Icons.power_settings_new_rounded,
                                              color: Colors.white70,
                                              size: 21 * a),
                                          onPressed: viewPowerDailog,
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
                            height: 28 * a,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    //todo
                                    // if(value.isOwner) bs.showGroupMemberBottomSheet(value.room!.groupMembers,value.room!.userId!);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0 * a, 4 * a, 0 * a, 9 * a),
                                    height: double.infinity,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * a, horizontal: 6 * a),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6 * a),
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
                                          SizedBox(width: 3 * a),
                                          Text(
                                            value.room?.groupName ?? 'GP1',
                                            style: SafeGoogleFont(
                                              'Poppins',
                                              fontSize: 9 * b,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5 * b / a,
                                              letterSpacing: 0.36 * a,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                          SizedBox(width: 6 * a),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15 * a),
                                if(value.isOwner)GestureDetector(
                                  onTap: () {
                                    Get.to(() => const LiveRecord());
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0 * a, 4 * a, 0 * a, 9 * a),
                                    height: double.infinity,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1 * a, horizontal: 6 * a),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6 * a),
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
                                          SizedBox(width: 3 * a),
                                          Text(
                                            'Bonus',
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
                                const Spacer(flex: 2),
                                Consumer<GiftsProvider>(
                                  builder: (context, gp, child) {
                                    final list = gp.todayRoomContribution;
                                    return GestureDetector(
                                      onTap: bs.showContributionBottomSheet,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            4 * a, 4 * a, 9 * a, 4 * a),
                                        decoration: BoxDecoration(
                                          color: const Color(0x33000000),
                                          borderRadius: BorderRadius.circular(12 * a),
                                        ),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              list.isNotEmpty
                                                  ? Row(
                                                  children: List.generate(
                                                    list.length>2?3:list.length,
                                                        (i) {
                                                      final userId = list.keys.elementAt(i);
                                                      final List<GiftHistory> history = list[userId]!;
                                                      int diamondsSum = 0;
                                                      for(var g in history){
                                                        diamondsSum = diamondsSum+g.gift!.coin!;
                                                      }
                                                      return FutureBuilder(
                                                        future: Provider.of<UserDataProvider>(context,listen: false).getUser(id: userId),
                                                        builder: (context, snapshot) {
                                                          switch (snapshot.connectionState) {
                                                            case ConnectionState.none:
                                                              return const Text('none...');
                                                            case ConnectionState.active:
                                                              return const Text('active...');
                                                            case ConnectionState.waiting:
                                                              return Shimmer.fromColors(
                                                                baseColor: Colors.white12,
                                                                highlightColor: Colors.transparent,
                                                                period: const Duration(seconds: 1),
                                                                child: Container(
                                                                  margin: EdgeInsets.fromLTRB(
                                                                      0 * a, 0 * a, 4 * a, 0 * a),
                                                                  width: 24 * a,
                                                                  height: 24 * a,
                                                                  decoration: const BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: Colors.white
                                                                  ),
                                                                ),
                                                              );
                                                            case ConnectionState.done:
                                                              if(snapshot.hasError || snapshot.data?.data == null){
                                                                return const SizedBox.shrink();
                                                              }
                                                              return Container(
                                                                  margin: EdgeInsets.fromLTRB(
                                                                      0 * a, 0 * a, 4 * a, 0 * a),
                                                                  width: 24 * a,
                                                                  height: 24 * a,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    image: snapshot.data!.data!.images!.isNotEmpty
                                                                        ? DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: NetworkImage(snapshot.data!.data!.images!.first),
                                                                    )
                                                                        : const DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: AssetImage('assets/profile.png'),
                                                                    ),
                                                                  ),
                                                                );
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                                )
                                                  : Row(
                                                children: List.generate(
                                                  1,
                                                      (i) {
                                                        return Container(
                                                          margin: EdgeInsets.fromLTRB(
                                                              0 * a, 0 * a, 0 * a, 0 * a),
                                                          width: 24 * a,
                                                          height: 24 * a,
                                                          decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage('assets/profile.png'),
                                                            ),
                                                          ),
                                                        );
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3 * a,
                                              ),
                                              Icon(
                                                Icons.chevron_right_rounded,
                                                color: Colors.white70,
                                                size: 21 * a,
                                              )
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          value.zegoRoom!.totalSeats < 9
                              ?SizedBox(height: 15*a)
                              :SizedBox(height: 6*a),
                          SizedBox(
                            width: 320 * a,
                            child: GridView.count(
                                crossAxisCount: 4,
                                childAspectRatio: value.zegoRoom!.viewCalculator? 0.73: 0.84,
                                crossAxisSpacing: 4*a,
                                mainAxisSpacing: 0,
                                shrinkWrap: true,
                                children: List.generate(
                                  value.zegoRoom!.totalSeats,
                                  (i) {

                                    final ZegoStreamExtended? user = value.roomStreamList.firstWhereOrNull((e) => e.seat == i);

                                    if(user!=null) {
                                      return GestureDetector(
                                    onTap: () {
                                      if (user.streamId == ZegoConfig.instance.userID) {
                                        bs.showMyProfileSeatBottomSheet(user);
                                      } else {
                                          bs.showOthersProfileSeatBottomSheet(user: user, owner: value.isOwner, admin: value.room!.admin!.contains(ZegoConfig.instance.userID));
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 76 * a,
                                          height: 72 * a,
                                          child: Stack(
                                            children: [
                                              if(user.micOn == true)Center(
                                                child: SizedBox(
                                                  width: 72 * a,
                                                  height: 72 * a,
                                                  child: const SoundVisualizer(),
                                                ),
                                              ),
                                              Center(
                                                child: userProfileDisplay(
                                                  size: 72 * a,
                                                  image: user.image??'',
                                                  frame: user.frame??'',
                                                  child: !user.micOn!
                                                      ? Container(
                                                    width: 52 * a,
                                                    height: 52 * a,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.black26,
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: Icon(Icons.mic_off,color: Colors.white.withOpacity(0.8),size: 18*a),
                                                  ):null,
                                                ),
                                              ),
                                              if(user.reactionController!=null)
                                                Center(
                                                  child: SizedBox(
                                                      width: 76 * a,
                                                      height: 72 * a,
                                                      child: SVGAImage(user.reactionController!)
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 72 * a,
                                          child: Text(
                                            user.userName ?? '',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Poppins',
                                              fontSize: 11 * b,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.4 * a,
                                              color: const Color(0xffffffff),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if(value.zegoRoom!.viewCalculator) SizedBox(height: 3 * a),
                                        if(value.zegoRoom!.viewCalculator) Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius: BorderRadius.circular(12)
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(CupertinoIcons.star_circle_fill,size: 11*a,color: Colors.white),
                                              SizedBox(width: 2 * a),
                                              Text(
                                                formatNumber(user.points??0),
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 10 * b,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.5 * b / a,
                                                  letterSpacing: 0.4 * a,
                                                  color: Colors.white.withOpacity(0.9),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                          if(value.isOwner || value.room!.admin!.contains(ZegoConfig.instance.userID)) {
                                            bs.showSeatOptionsBottomSheet(i);
                                          }else if(!value.zegoRoom!.lockedSeats.contains(i)){
                                            value.startPublishingStream(i);
                                          }else{
                                            showCustomSnackBar('Seat Locked!',context,isToaster: true);
                                          }
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 9*a),
                                          value.zegoRoom!.lockedSeats.contains(i)
                                              ? Container(
                                                  width: 52 * a,
                                                  height: 52 * a,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white24.withOpacity(0.4),
                                                      border: Border.all(color: Colors.white12,width: 1.5)
                                                  ),
                                            child: const Icon(Icons.lock,color: Colors.white54),
                                                  )
                                              :Container(
                                                width: 52 * a,
                                                height: 52 * a,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white24,
                                                    border: Border.all(color: Colors.white12,width: 1.5)
                                                ),
                                            child: const Icon(Icons.add,color: Colors.white54),
                                              ),
                                        ],
                                      ),
                                    );
                                  },
                                )),
                          ),
                          if(value.isOwner) Expanded(
                            child: Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 36*a,
                                    width: 54*a,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        backgroundColor: Colors.white12,
                                        surfaceTintColor: Colors.black26,
                                        elevation: 0,
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: (){
                                        // showDialog(
                                        //   context: context,
                                        //   barrierColor: Colors.transparent,
                                        //   builder: (BuildContext context) {
                                        //     return AlertDialog(
                                        //       insetPadding: const EdgeInsets.only(left: 18, right: 18, top: 0,bottom: 0),
                                        //       actionsPadding: EdgeInsets.zero,
                                        //       contentPadding: EdgeInsets.zero,
                                        //       titlePadding: EdgeInsets.zero,
                                        //       buttonPadding: EdgeInsets.zero,
                                        //       iconPadding: EdgeInsets.zero,
                                        //       backgroundColor: const Color(0xBF9e26bc),
                                        //       shape: ShapeBorder.lerp(
                                        //           InputBorder.none, InputBorder.none, 0),
                                        //       content: Container(
                                        //         padding: EdgeInsets.only(bottom: 14*a,top: 7*a),
                                        //         width: 400 * a,
                                        //         child: Column(
                                        //           mainAxisAlignment: MainAxisAlignment.start,
                                        //           crossAxisAlignment: CrossAxisAlignment.center,
                                        //           mainAxisSize: MainAxisSize.min,
                                        //           children: [
                                        //             Row(
                                        //               mainAxisAlignment:
                                        //               MainAxisAlignment.spaceBetween,
                                        //               children: [
                                        //                 Padding(
                                        //                   padding:
                                        //                   EdgeInsets.only(left: 8 * a),
                                        //                   child: Icon(
                                        //                       CupertinoIcons.question_circle,
                                        //                       color: Colors.white,
                                        //                       size: 12 * a),
                                        //                 ),
                                        //                 const Spacer()
                                        //               ],
                                        //             ),
                                        //             Row(
                                        //               children: [
                                        //                 const Spacer(flex: 2),
                                        //                 Container(
                                        //                   width: 64 * a,
                                        //                   height: 17 * a,
                                        //                   decoration: BoxDecoration(
                                        //                     borderRadius:
                                        //                     BorderRadius.circular(9 * a),
                                        //                     color: const Color(0xffffe500),
                                        //                   ),
                                        //                   child: Center(
                                        //                     child: Row(
                                        //                       mainAxisSize: MainAxisSize.min,
                                        //                       children: [
                                        //                         Icon(
                                        //                             CupertinoIcons.heart_fill,
                                        //                             size: 12 * a),
                                        //                         Text(
                                        //                           ' Match',
                                        //                           style: SafeGoogleFont(
                                        //                             'Poppins',
                                        //                             fontSize: 9 * b,
                                        //                             fontWeight:
                                        //                             FontWeight.w400,
                                        //                             height: 1.5 * b / a,
                                        //                             letterSpacing: 0.36 * a,
                                        //                             color: const Color(
                                        //                                 0xff000000),
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 const Spacer(flex: 1),
                                        //                 GestureDetector(
                                        //                   onTap: () {
                                        //                     bs.inviteMemberSheet();
                                        //                   },
                                        //                   child: Container(
                                        //                     width: 64 * a,
                                        //                     height: 17 * a,
                                        //                     decoration: BoxDecoration(
                                        //                       borderRadius:
                                        //                       BorderRadius.circular(
                                        //                           9 * a),
                                        //                       color: const Color(0xffffe500),
                                        //                     ),
                                        //                     child: Center(
                                        //                       child: Row(
                                        //                         mainAxisSize:
                                        //                         MainAxisSize.min,
                                        //                         children: [
                                        //                           Icon(Icons.person_add,
                                        //                               size: 12 * a),
                                        //                           Text(
                                        //                             ' Invite',
                                        //                             style: SafeGoogleFont(
                                        //                               'Poppins',
                                        //                               fontSize: 9 * b,
                                        //                               fontWeight:
                                        //                               FontWeight.w400,
                                        //                               height: 1.5 * b / a,
                                        //                               letterSpacing: 0.36 * a,
                                        //                               color: const Color(
                                        //                                   0xff000000),
                                        //                             ),
                                        //                           ),
                                        //                         ],
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 const Spacer(flex: 2),
                                        //               ],
                                        //             ),
                                        //             SizedBox(height: 5*a),
                                        //             Text(
                                        //               'Participating in PK will Help to gather Your room Members',
                                        //               style: SafeGoogleFont(
                                        //                 'Poppins',
                                        //                 fontSize: 9 * b,
                                        //                 fontWeight: FontWeight.w400,
                                        //                 height: 1.5 * b / a,
                                        //                 letterSpacing: 0.24 * a,
                                        //                 color: const Color(0xffffffff),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        // );
                                      },
                                      child: Text(
                                        'PK',
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 18 * b,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.48 * a,
                                          color: const Color.fromARGB(255, 225, 198, 159),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: AnimatedContainer(
                                    margin: EdgeInsets.only(left: 12*a),
                                    duration: const Duration(milliseconds: 500),
                                    width: value.newUser==null?0:120,
                                    height: 27 * a,
                                    padding: EdgeInsets.fromLTRB(
                                        11 * a, 5 * a, 11 * a, 5 * a),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color(0x66090000)
                                    ),
                                    child: Text(
                                      value.newUser==null?'':'${value.newUser}',
                                      overflow: TextOverflow.ellipsis,
                                      style: SafeGoogleFont(
                                        'Poppins',
                                        fontSize: 10.5 * b,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFFFFE57C),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.all(12*a),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView(
                                      controller: value.scrollController,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 6 * a),
                                          padding: EdgeInsets.fromLTRB(
                                              11 * a, 7 * a, 11 * a, 7 * a),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0x66090000),
                                          ),
                                          child: Text(
                                            'Please Respect each other and chat in friendly manner. Abuse, sexual and violent contents are not allowed. All violators will be banned.',
                                            style: SafeGoogleFont(
                                              'Poppins',
                                              fontSize: 10.5 * b,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFFFFE57C),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 6 * a),
                                          padding: EdgeInsets.fromLTRB(
                                              11 * a, 5 * a, 11 * a, 5 * a),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color(0x66090000),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Announcement : ',
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontSize: 10.5 * b,
                                                  letterSpacing: 0.48 * a,
                                                  color: const Color(0xFFFFE57C),
                                                ),
                                              ),
                                              Text(
                                                (value.room?.announcement??'')==''?'Hii! Welcome to my room.':value.room!.announcement!,
                                                style: SafeGoogleFont(
                                                  'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11 * b,
                                                  letterSpacing: 0.48 * a,
                                                  color: const Color(0xFFFFE57C),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(
                                        value.broadcastMessageList?.length??0,
                                            (index) {
                                          final ZegoBroadcastMessageInfo message = value.broadcastMessageList![index];
                                          final ZegoBroadcastModel body = zegoBroadcastModelFromJson(message.message);
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 6 * a),
                                            child: GestureDetector(
                                              onTap: () async {
                                                final myId = ZegoConfig.instance.userID;
                                                if(message.fromUser.userID == myId){
                                                  Get.to(()=>const UserProfile());
                                                }else{
                                                  final u = await Provider.of<UserDataProvider>(context,listen: false).addVisitor(message.fromUser.userID);
                                                  Get.to(()=>UserProfile(userData: u.data!));
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    8 * a, 4 * a, 8 * a, 4 * a),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: const Color(0x66090000),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 6 * a),
                                                      child:
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
                                                    ),
                                                    SizedBox(width: 6 * a),
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.fromLTRB(
                                                            0 * a, 5 * a, 0 * a, 4 * a),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
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
                                                                    color: const Color(0xFFFFE57C),
                                                                  ),
                                                                ),
                                                                SizedBox(width: 6*a),
                                                                if(body.tags!.isNotEmpty) Container(
                                                                  height: 12 * a,
                                                                  padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 4),
                                                                  decoration: BoxDecoration(
                                                                    color: const Color(0xff9e26bc),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        9 * a),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      body.tags!.first,
                                                                      style: SafeGoogleFont(
                                                                        'Poppins',
                                                                        fontSize: 7 * b,
                                                                        fontWeight: FontWeight.w500,
                                                                        height: 1.5 * b / a,
                                                                        letterSpacing: 0.24 * a,
                                                                        color:
                                                                        const Color(0xffffffff),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            userLevelTag(body.level??0,10 * a),
                                                            SizedBox(height: 3*a),
                                                            if(body.type == 'message')
                                                              buildRichText(body.message!),
                                                            if(body.type == 'gift') SizedBox(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  buildRichText('Sent to @${body.gift?.toName}'),
                                                                  SizedBox(height: 9*a),
                                                                  Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Image.network(
                                                                          body.gift!.thumbnailPath!,
                                                                        height: 45*a,
                                                                        width: 45*a,
                                                                        errorBuilder: (context, error, stackTrace) {
                                                                          return SizedBox(
                                                                            height: 45*a,
                                                                            width: 45*a);
                                                                        },
                                                                      ),
                                                                      Expanded(
                                                                        child: Text(' X ${body.gift?.count}',
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: SafeGoogleFont(
                                                                            'Poppins',
                                                                            fontSize: 16 * b,
                                                                            fontWeight:
                                                                            FontWeight.w600,
                                                                            height: 1.5 * b / a,
                                                                            letterSpacing: 0.48 * a,
                                                                            color: const Color(0xFFFFE57C),
                                                                          ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(height: 3*a)
                                                                ],
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
                                        )
                                      ]
                                    ),
                                  ),
                                  SizedBox(
                                    width: 85*a,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 63 * a,
                                          height: 63 * a,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            image: const DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage('assets/room_icons/win_rewards.png'))
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 47 * a,
                                          padding: EdgeInsets.symmetric(horizontal: 3*a),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: bs.showTreasuresBottomSheet,
                                                child: Image.asset(
                                                  'assets/ic_treasure_box/${value.room!.treasureBoxLevel! == 5 ?5 :(value.room!.treasureBoxLevel!+1)}.png',
                                                  width: double.infinity,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(4*a),
                                                child: LinearProgressIndicator(
                                                  value: setTreasureBoxValue(value.room!.treasureBoxLevel!,value.room!.usedDaimonds!),
                                                  backgroundColor: Colors.white24,
                                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 6 * a),
                                        IconButton(
                                          onPressed: bs.showNotificationsBottomSheet,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer<ZegoRoomProvider>(
                      builder: (context, zegoRoomProvider, _) => Container(
                        margin: EdgeInsets.fromLTRB(13 * a, 0 * a, 11 * a, 0 * a),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                  zegoRoomProvider.isSoundOn = !zegoRoomProvider.isSoundOn;
                              },
                              style: IconButton.styleFrom(
                                backgroundColor:zegoRoomProvider.isSoundOn?null: Colors.white12,
                              ),
                              icon: Icon(
                                  zegoRoomProvider.isSoundOn
                                      ? Icons.volume_up_outlined
                                      : Icons.volume_off_outlined,
                                  color: zegoRoomProvider.isSoundOn
                                      ? Colors.white.withOpacity(0.9)
                                      : Colors.white70,
                                  size: 27 * a
                              ),
                            ),
                            if(zegoRoomProvider.onSeat) IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor:zegoRoomProvider.isMicOn && value.isMicrophonePermissionGranted?null: Colors.white12,
                              ),
                              onPressed: () {
                                if(value.roomStreamList.firstWhere((e) => e.streamId == ZegoConfig.instance.userID).micPermit == false){
                                  showCustomSnackBar('Muted by Admin/Owner', context,isToaster: true);
                                }else if(!value.isMicrophonePermissionGranted){
                                  requestMicrophonePermission();
                                }else{
                                  zegoRoomProvider.isMicOn = !zegoRoomProvider.isMicOn;
                                }
                              },
                              icon: Icon(
                                  zegoRoomProvider.isMicOn && value.isMicrophonePermissionGranted ? Icons.mic_rounded : Icons.mic_off_rounded,
                                  color: zegoRoomProvider.isMicOn && value.isMicrophonePermissionGranted ? Colors.white.withOpacity(0.9) : Colors.white70,
                                  size: 27 * a),
                            ),
                            IconButton(
                              onPressed: bs.showMessage,
                              icon: Icon(Icons.messenger_outline_rounded,
                                  color: Colors.white.withOpacity(0.9), size: 27 * a),
                            ),
                            if(zegoRoomProvider.onSeat) IconButton(
                              onPressed: bs.showEmojiBottomSheet,
                              icon: Icon(CupertinoIcons.smiley,
                                  color: Colors.white.withOpacity(0.9), size: 27 * a),
                            ),
                            IconButton(
                              onPressed: bs.showSendGiftsBottomSheet,
                              icon: SizedBox(
                                width: 27 * a,
                                height: 36 * a,
                                child: Image.asset(
                                  'assets/gift.gif',
                                  fit: BoxFit.cover,
                                  isAntiAlias: true,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed:(){bs.showGamesBottomSheet(value.isOwner);},
                              icon: SizedBox(
                                width: 30 * a,
                                height: 27 * a,
                                child: Image.asset(
                                  'assets/game.gif',
                                  fit: BoxFit.cover,
                                  isAntiAlias: true,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: bs.showBottomMoreBottomSheet,
                              icon: Icon(
                                CupertinoIcons.line_horizontal_3,
                                color: Colors.white.withOpacity(0.9),
                                size: 27 * a,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6*a)
                  ],
                ),
              ),
              if(value.foregroundSvgaController!=null)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Get.height/4),
                    child: SVGAImage(
                      value.foregroundSvgaController!,
                      clearsAfterStop: true,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
              ),
              if(value.foregroundImage!=null)
                Center(
                  child: Image.network(
                    value.foregroundImage!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRichText(String text) {
    // double baseWidth = 360;
    // double a = Get.width / baseWidth;
    // double b = a * 0.97;

    final List<TextSpan> textSpans = [];
    List<String> parts = text.split('@');

    for (int i = 0; i < parts.length; i++) {
      if (i == 0) {
        // Text before '@' or text without '@'
        textSpans.add(TextSpan(
          text: parts[i],
          style:
          SafeGoogleFont(
            'Poppins',
            fontSize: 11,
            fontWeight:
            FontWeight.w400,
            color: const Color(0xFFFFE57C),
          ), // Default color
        ));
      } else {
        // Split the text after '@' by space and take the first part
        String partAfterAt = parts[i].split(' ')[0];

        // Text after '@' with different color
        textSpans.add(TextSpan(
          text: '@$partAfterAt',
          style:
          SafeGoogleFont(
            'Poppins',
            fontSize: 11,
            fontWeight:
            FontWeight.w400,
            color: const Color(0xFFFF7CFD),
          ), // Different color for text after '@'
        ));

        // Add remaining text after '@' without styling
        textSpans.add(TextSpan(
          text: parts[i].substring(partAfterAt.length), // Exclude the first part
          style:
          SafeGoogleFont(
            'Poppins',
            fontSize: 11,
            fontWeight:
            FontWeight.w400,
            color: const Color(0xFFFFE57C),
          ), // Default color for the remaining text
        ));
      }
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }

  double setTreasureBoxValue(int boxLevel, int usedDiamonds) {
    int b1 = 10000;
    int b2 = 30000;
    int b3 = 70000;
    int b4 = 130000;
    int b5 = 230000;
    switch(boxLevel){
      case 0:
        if(usedDiamonds>=b1) return 1.0;
        return usedDiamonds/b1;
      case 1:
        if(usedDiamonds>=b2) return 1.0;
        return (usedDiamonds-b1)/b2;
      case 2:
        if(usedDiamonds>=b3) return 1.0;
        return (usedDiamonds-b2)/b3;
      case 3:
        if(usedDiamonds>=b4) return 1.0;
        return (usedDiamonds-b3)/b4;
      case 4:
        if(usedDiamonds>=b5) return 1.0;
        return (usedDiamonds-b4)/b5;
      case 5:
        return 1.0;
    }
    return 0;
  }

  Future<void> requestMicrophonePermission() async {
    PermissionStatus microphoneStatus = await Permission.microphone.request();
    if(microphoneStatus.isGranted){
      zegoRoomProvider.isMicrophonePermissionGranted = true;
      zegoRoomProvider.isMicOn = true;
    }
  }

}
