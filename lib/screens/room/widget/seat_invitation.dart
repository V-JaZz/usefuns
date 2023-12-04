import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/common_widgets.dart';

void viewInviteToSeatDailog(String seatInfo, String from){
  Get.defaultDialog(
    title: 'Invitation',
    content: Text('$from invited you to join seat'),
    confirm: Consumer<ZegoRoomProvider>(
      builder: (context, value, child) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white
        ),
          onPressed: (){
          value.startPublishingStream(int.parse(seatInfo));
          Get.back();
          },
          child: const Text('Accept')),
    ),
    cancel: TextButton(
      onPressed: (){Get.back();},
        child: const Text('Cancel',style: TextStyle(color: Color(0xFF9E26BC)))),
  );
}