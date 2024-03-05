import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/rooms_provider.dart';
import '../../../provider/zego_room_provider.dart';
import 'live_record.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/utils_assets.dart';

class RoomSettings extends StatefulWidget {
  const RoomSettings({super.key});

  @override
  State<RoomSettings> createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {
  File? pickedImage;
  String? imagePaths;
  String? croppedImagePaths;

  Future pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          pickedImage = File(pickedFile.path);
          imagePaths = (pickedImage!.path);
        }
      });
      if (pickedImage == null) return null;
      await ImageCropper().cropImage(
        sourcePath: imagePaths!,
        compressFormat: ImageCompressFormat.jpg,
        maxHeight: 200,
        maxWidth: 200,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: const Color(0x339E26BC),
              toolbarWidgetColor: Colors.black,
              // toolbarWidgetColor: const Color(0xff9e26bc),
              initAspectRatio: CropAspectRatioPreset.original,
              statusBarColor: const Color(0x339E26BC),
              activeControlsWidgetColor: const Color(0xff9e26bc)
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: Get.context!,
          ),
        ],
      ).then((croppedImage) {
        croppedImagePaths = croppedImage?.path;
        setState(() {});
        return null;
      });

    } on Exception catch (e) {
      return Text('Adding Failed!, $e');
    }
  }
  imagePicker() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              Navigator.of(context).pop();
              await pickImage(ImageSource.camera);
              if(croppedImagePaths!=null)updateImage();
            },
            child: const ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Camera'),
            ),
          ),
          InkWell(
            onTap: () async {
              Navigator.of(context).pop();
              await pickImage(ImageSource.gallery);
              if(croppedImagePaths!=null)updateImage();
            },
            child: const ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
            ),
          ),
        ],
      ),
    );
  }
  updateImage() async {
    final p1 = Provider.of<RoomsProvider>(context,listen: false);
    final p2 = Provider.of<ZegoRoomProvider>(context,listen: false);
    Get.dialog(
        barrierDismissible: false,
        loadingWidget());
    await p1.updatePicture(p2.room!.id!, croppedImagePaths!,p2.room!.name!).then((value) async {
      if(value.status == 1){
        await p1.getAllMine();
        p2.room = p2.room!.copyWith(images: p1.myRoom!.data!.first.images);
      }else{
        showCustomSnackBar('Error Updating Icon!', context);
      }
      Get.back();
      return null;
    });
  }

  late List<Map> settingsList = [
    {
      "title": "Icon",
      "trailing": "dp",
      'onTap': () {
        showModalBottomSheet(
            context: context, builder: (builder) => imagePicker());
      },
    },
    {
      "title": "Name",
      "trailing": "id",
      'onTap': () {
        _showRoomNameBottomSheet();
      },
    },
    {
      "title": "Announcement",
      "trailing": "view",
      'onTap': _showAnnouncementBottomSheet,
    },
    {
      "title": "Joined History",
      "trailing": "view",
      'onTap': () {
        Get.to(() => const JoinedHistory());
      },
    },
    {
      "title": "Blocked list",
      "trailing": "view",
      'onTap': () {
        Get.to(() => const BlockedList());
      },
    },
    {
      "title": "Kick History",
      "trailing": "view",
      'onTap': () {
        Get.to(() => const KickHistory());
      },
    },
    {
      "title": "LIVE Record",
      "trailing": "view",
      'onTap': () {
        Get.to(() => const LiveRecord());
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color(0x339E26BC),
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 1,
          title: Text('Room Settings',
              textAlign: TextAlign.center,
              style: safeGoogleFont(
                'Poppins',
                fontSize: 20 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.8 * a,
                color: const Color(0xff000000),
              )),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 34 * a, vertical: 14 * a),
          child: ListView(
            children: [
              for (Map m in settingsList)
                GestureDetector(
                  onTap: m['onTap'],
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12 * a),
                    height: 21 * a,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          m['title'],
                          textAlign: TextAlign.left,
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 14 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.48 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                        const Spacer(),
                        if (m['trailing'] == 'view')
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 14 * a,
                          ),
                        if (m['trailing'] == 'id')
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                value.room!.name!,
                                style: safeGoogleFont(
                                  'Poppins',
                                  fontSize: 12 * b,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * b / a,
                                  letterSpacing: 0.36 * a,
                                  color: const Color(0x99000000),
                                ),
                              ),
                              SizedBox(width: 3*a),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 14 * a,
                              ),
                            ],
                          ),
                        if (m['trailing'] == 'dp')
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 18 * a,
                                width: 18 * a,
                                decoration: BoxDecoration(
                                  image: value.room!.images!.isEmpty
                                      ? const DecorationImage(
                                    fit: BoxFit.cover,
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
                                child: value.room!.isLocked == true
                                    ?Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: 7 * a,
                                    height: 4 * a,
                                    child: Image.asset(
                                      'assets/room_icons/lock.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                    :null,
                              ),
                              SizedBox(width: 3*a),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 14 * a,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 36 * a),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showRoomNameBottomSheet() async {
    final p = Provider.of<ZegoRoomProvider>(context,listen: false).room;
    TextEditingController name = TextEditingController(text: p?.name??'');
    bool? b = await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        elevation: 0,
        builder: (context) {
          double baseWidth = 290;
          double a = Get.width / baseWidth;
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Get.width,
                color: Colors.white,
                padding: EdgeInsets.all(12 * a),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit Room Name',
                      style: TextStyle(
                        fontSize: 12 * a,
                      ),
                    ),
                    SizedBox(height: 12 * a),
                    TextFormField(
                      maxLength: 30,
                      controller: name,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Center(child: Text('Cancel')))),
                        Container(
                            color: Colors.black, width: 1, height: 18 * a),
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                if(name.text.trim() != ''){
                                  final p1 = Provider.of<RoomsProvider>(context,listen: false);
                                  final p2 = Provider.of<ZegoRoomProvider>(context,listen: false);
                                  p1.updateName(p2.room!.id!, name.text).then((value) {
                                    if(value.status == 1){
                                      p1.myRoom = p1.myRoom!.copyWith(data: [p1.myRoom!.data!.first.copyWith(name: name.text)]);
                                      p2.room = p2.room!.copyWith(name: name.text);
                                      Get.back();
                                    }
                                    return null;
                                  });
                                  Get.back<bool>(result: true);
                                }
                              },
                              child: const Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Color(0xFF9E26BC)),
                                  )),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    if(b==true){
      Get.dialog(
        barrierDismissible: false,
          loadingWidget()
      );
    }
  }

  void _showAnnouncementBottomSheet() async {
    final p = Provider.of<ZegoRoomProvider>(context,listen: false).room;
    TextEditingController controller = TextEditingController(text: p?.announcement??'');
    bool? b = await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        elevation: 0,
        builder: (context) {
          double baseWidth = 290;
          double a = Get.width / baseWidth;
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Get.width,
                color: Colors.white,
                padding: EdgeInsets.all(12 * a),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit Announcement',
                      style: TextStyle(
                        fontSize: 12 * a,
                      ),
                    ),
                    SizedBox(height: 12 * a),
                    TextFormField(
                      controller: controller,
                      maxLength: 150,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Center(child: Text('Cancel')))),
                        Container(
                            color: Colors.black, width: 1, height: 18 * a),
                        Expanded(
                            child: Center(
                                child: InkWell(
                                  onTap: (){
                                    if(controller.text.trim() != ''){
                                      final p1 = Provider.of<RoomsProvider>(context,listen: false);
                                      final p2 = Provider.of<ZegoRoomProvider>(context,listen: false);
                                      p1.addAnnouncement(p2.room!.id!, controller.text).then((value) {
                                        if(value.status == 1){
                                          p1.myRoom = p1.myRoom!.copyWith(data: [p1.myRoom!.data!.first.copyWith(announcement: controller.text)]);
                                          p2.room = p2.room!.copyWith(announcement: controller.text);
                                      Get.back();
                                        }
                                        return null;
                                      });
                                    }
                                    Get.back<bool>(result: true);
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: Color(0xFF9E26BC)),
                                  ),
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    if(b==true){
      Get.dialog(
        barrierDismissible: false,
          loadingWidget()
      );
    }
  }
}

class JoinedHistory extends StatelessWidget {
  const JoinedHistory({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 1,
        title: Text('Joined History',
            textAlign: TextAlign.center,
            style: safeGoogleFont(
              'Poppins',
              fontSize: 20 * b,
              fontWeight: FontWeight.w400,
              height: 1.5 * b / a,
              letterSpacing: 0.8 * a,
              color: const Color(0xff000000),
            )),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
        child: Provider.of<ZegoRoomProvider>(context,listen: false).room?.lastmembers?.isEmpty??true
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50 * a,
            ),
            Image.asset(
              "assets/icons/ic_empty.png",
              width: Get.width / 3,
              height: Get.width / 3,
            ),
            Text(
              'No Data!',
              style: safeGoogleFont(
                'Poppins',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.64 * a,
                color: const Color(0xff000000),
              ),
            ),
          ],
        )
            : viewUsersByIds(Provider.of<ZegoRoomProvider>(context,listen: false).room!.lastmembers!.toSet().toList()),
      ),
    );
  }
}

class BlockedList extends StatelessWidget {
  const BlockedList({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 1,
        title: Text('Blocked List',
            textAlign: TextAlign.center,
            style: safeGoogleFont(
              'Poppins',
              fontSize: 20 * b,
              fontWeight: FontWeight.w400,
              height: 1.5 * b / a,
              letterSpacing: 0.8 * a,
              color: const Color(0xff000000),
            )),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50 * a,
            ),
            Image.asset(
              "assets/icons/ic_empty.png",
              width: Get.width / 3,
              height: Get.width / 3,
            ),
            Text(
              'No Data!',
              style: safeGoogleFont(
                'Poppins',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.64 * a,
                color: const Color(0xff000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KickHistory extends StatelessWidget {
  const KickHistory({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 1,
        title: Text('Kick History',
            textAlign: TextAlign.center,
            style: safeGoogleFont(
              'Poppins',
              fontSize: 20 * b,
              fontWeight: FontWeight.w400,
              height: 1.5 * b / a,
              letterSpacing: 0.8 * a,
              color: const Color(0xff000000),
            )),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50 * a,
            ),
            Image.asset(
              "assets/icons/ic_empty.png",
              width: Get.width / 3,
              height: Get.width / 3,
            ),
            Text(
              'No Data!',
              style: safeGoogleFont(
                'Poppins',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.64 * a,
                color: const Color(0xff000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}