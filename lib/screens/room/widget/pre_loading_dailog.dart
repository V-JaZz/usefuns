import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/datasource/local/sharedpreferences/storage_service.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/screens/room/live_room.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';
import 'package:live_app/utils/constants.dart';
import '../../../data/model/body/zego_room_model.dart';
import '../../../data/model/response/rooms_model.dart';
import '../../../provider/gifts_provider.dart';
import '../../../provider/user_data_provider.dart';
import '../../../provider/zego_room_provider.dart';
import '../../../utils/helper.dart';
import '../../../utils/utils_assets.dart';

class RoomPreLoadingDialog extends StatefulWidget {
  final Room room;
  const RoomPreLoadingDialog({super.key, required this.room});

  @override
  State<RoomPreLoadingDialog> createState() => _RoomPreLoadingDialogState();
}

class _RoomPreLoadingDialogState extends State<RoomPreLoadingDialog> {
  late final ZegoRoomProvider zegoRoomProvider;
  late bool locked;
  bool loading = true;
  final TextEditingController textEditingController = TextEditingController();
  String errorText = '';

  String getGreeting(String? name, int i, String? owner) {
    switch (i) {
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
    locked = widget.room.isLocked ?? false;
    zegoRoomProvider = Provider.of<ZegoRoomProvider>(context, listen: false);
    if (locked) {
      loading = false;
      if(widget.room.userId! == StorageService().getString(Constants.id) || Provider.of<UserDataProvider>(Get.context!, listen: false).userData!.data!.name!.contains('#icognito')){
        textEditingController.text = widget.room.password??'';
        joinLockedRoom();
      }
    } else {
      join();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          locked
              ? Column(
                  children: [
                    const SizedBox(height: 9),
                    SizedBox(
                      width: 190,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: textEditingController,
                        style: safeGoogleFont(
                          'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: const Color(0x99000000),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        maxLength: 4,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            counter: const SizedBox.shrink(),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: 'Enter PIN',
                            alignLabelWithHint: false),
                        onFieldSubmitted: (value) {
                          joinLockedRoom();
                        },
                      ),
                    ),
                    const SizedBox(height: 1),
                    errorText.isNotEmpty
                        ?Text(errorText,
                        style: TextStyle(color: Theme.of(context).primaryColor))
                        :const SizedBox(height: 9),
                    const SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel')
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white),
                            onPressed: () {
                              joinLockedRoom();
                            },
                            child: loading
                                ? Container(padding: const EdgeInsets.all(3),child: const Center(child: SizedBox( height:18, width:18, child: CircularProgressIndicator(color: Colors.white))))
                                :const Text('Join')
                        ),
                      ],
                    )
                  ],
                )
              : const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xff9e26bc),
                    ),
                    SizedBox(height: 16),
                    Text("Please wait..."),
                  ],
                ),
        ],
      ),
    );
  }

  void join({String? password}) async {

    if (zegoRoomProvider.room != null) await zegoRoomProvider.destroy();

    final response =  await Provider.of<RoomsProvider>(Get.context!, listen: false).addRoomUser(widget.room.id!, password: password);

    if (response.status == 1) {
      final me = Provider.of<UserDataProvider>(Get.context!, listen: false).userData;
      zegoRoomProvider.userID =me!.data!.id!;
      zegoRoomProvider.userName =me.data!.name!;
      zegoRoomProvider.isOwner = widget.room.userId! == StorageService().getString(Constants.id);
      zegoRoomProvider.room = widget.room;
      zegoRoomProvider.roomPassword = password;
      zegoRoomProvider.roomID = widget.room.roomId!;
      zegoRoomProvider.zegoRoom = ZegoRoomModel(
          totalSeats: 8,
          lockedSeats: [],
          viewCalculator: false);
      await zegoRoomProvider.init();
      if (zegoRoomProvider.isOwner) {
        if (me.data!.roomWallpaper!.isNotEmpty) {
          String image = userValidItemSelection(me.data!.roomWallpaper!);
          zegoRoomProvider.backgroundImage = image.isNotEmpty?image:null;
        }
        if(me.data!.extraSeat!.isNotEmpty){
          zegoRoomProvider.zegoRoom?.totalSeats = (userValidItemSelection(me.data!.extraSeat!).isNotEmpty ? widget.room.noOfSeats : 8)! ;
        }
      } else {
        final ownerData = await Provider.of<UserDataProvider>(Get.context!, listen: false)
                .getUser(id: zegoRoomProvider.room!.userId!);
        if (ownerData.data!.roomWallpaper!.isNotEmpty) {
          String image = userValidItemSelection(ownerData.data!.roomWallpaper!);
          zegoRoomProvider.backgroundImage = image.isNotEmpty?image:null;
        }
        if(ownerData.data!.extraSeat!.isNotEmpty){
          zegoRoomProvider.zegoRoom?.totalSeats = (userValidItemSelection(ownerData.data!.extraSeat!).isNotEmpty ? widget.room.noOfSeats : 8)! ;
        }
        zegoRoomProvider.addGreeting(
            getGreeting(
                me.data?.name, Random().nextInt(5),ownerData.data!.name!.contains('#icognito')?ownerData.data!.name!.split('#').first:ownerData.data!.name!),
            ownerData);
      }
      Provider.of<GiftsProvider>(Get.context!, listen: false).generateSeries();

      if(!me.data!.name!.contains('#icognito')){
        final vehicle = userValidItemSelection(me.data!.vehicle!);
        zegoRoomProvider.roomEntryEffect(userId: me.data!.userId!, vehicle: vehicle, mine: true);
      }

      Get.back();
      Get.to(() => const LiveRoom(), transition: Transition.size);
    }else if(locked && password!=null){
      setState(() {
        loading = false;
        errorText = response.message??'Invalid password!';
      });
    }
    else {
      Get.back();
      showCustomSnackBar(response.message, Get.context!, isToaster: true);
    }
  }

  void joinLockedRoom() {
    if(loading) return;
    if(textEditingController.text.isEmpty || textEditingController.text.length != 4){
      setState(() {
        errorText = 'Invalid PIN!';
      });
      return;
    }
    setState(() {
      loading = true;
    });
    join(password: textEditingController.text);
  }
}
