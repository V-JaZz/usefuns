import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/screens/room/live_room.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';

import '../../../provider/gifts_provider.dart';
import '../../../provider/user_data_provider.dart';
import '../../../provider/zego_room_provider.dart';

class RoomPreLoadingDialog extends StatefulWidget {
  const RoomPreLoadingDialog({super.key});

  @override
  State<RoomPreLoadingDialog> createState() => _RoomPreLoadingDialogState();
}

class _RoomPreLoadingDialogState extends State<RoomPreLoadingDialog> {
  late final ZegoRoomProvider zegoRoomProvider;

  String getGreeting(String? name, int i, String? owner){
    switch(i){
      case 0:
        return 'Hi! @$name \nNice to meet you here!';
      case 1:
        return 'Hello @$name \nNice to meet you, enjoy your time here!';
      case 2:
        return 'Hii! @$name \nThanks you so much for coming! you are welcomed!';
      case 3:
        return 'Hello @$name \nWelcome to my chatroom!';
      case 4:
        return 'Hey! @$name \nGreetings from @$owner, welcome to my chatroom!';
      default:
        return '';
    }
  }

  @override
  void initState() {
    zegoRoomProvider = Provider.of<ZegoRoomProvider>(Get.context!,listen: false);
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: Color(0xff9e26bc),
          ),
          SizedBox(height: 16),
          Text("Please wait..."),
        ],
      ),
    );
  }

  void start() async {
    final response = await Provider.of<RoomsProvider>(context,listen: false).addRoomUser(zegoRoomProvider.room!.id!);
    if(response.status==1){
      final me = Provider.of<UserDataProvider>(Get.context!,listen: false).userData;
      await zegoRoomProvider.init();
      if(zegoRoomProvider.isOwner) {
        if(me!.data!.roomWallpaper!.isNotEmpty) zegoRoomProvider.backgroundImage = me.data!.roomWallpaper!.first.images!.first;
      }else{
        final ownerData = await Provider.of<UserDataProvider>(Get.context!,listen: false).getUser(id: zegoRoomProvider.room!.userId!);
        if(ownerData.data!.roomWallpaper!.isNotEmpty) zegoRoomProvider.backgroundImage = ownerData.data!.roomWallpaper!.first.images!.first;
        zegoRoomProvider.addGreeting(getGreeting(me?.data?.name, Random().nextInt(5), ownerData.data?.name), ownerData);
      }
      Provider.of<GiftsProvider>(context, listen: false).generateSeries();
      Get.off(()=>const LiveRoom(),transition: Transition.size);
    }else {
      Get.back();
      showCustomSnackBar(response.message, context,isToaster: true);
    }
  }
}