import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_app/data/model/response/rooms_model.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/utils/common_widgets.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../room/live_room.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController textEditingController = TextEditingController();
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
            context: context,
          ),
        ],
      ).then((croppedImage) {
        croppedImagePaths = croppedImage?.path;
        setState(() {});
        return null;
      });

    } on Exception catch (e) {
      return const Text('Adding Failed');
    }
  }

  imagePicker() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pickImage(ImageSource.camera);
              Navigator.of(context).pop();
            },
            child: const ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Camera'),
            ),
          ),
          InkWell(
            onTap: () {
              pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22 * a, vertical: 12 * a),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 60 * a,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(width: 12 * a),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 24 * a,
                      ),
                    ),
                    SizedBox(width: 24 * a),
                    Text(
                      'Enter Room Name',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 21 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.96 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35 * a),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: (builder) => imagePicker());
                },
                child: Container(
                  color: Colors.black,
                  child: imagePaths == null
                      ?Image.asset(
                    "assets/logo_greystyle.png",
                    height: 109 * a,
                    width: 109 * a,
                  )
                      :Image(
                    image: FileImage(File(croppedImagePaths??imagePaths!)),
                    height: 109 * a,
                    width: 109 * a,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 35 * a),
              TextFormField(
                maxLength: 30,
                controller: textEditingController,
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 12 * b,
                  fontWeight: FontWeight.w300,
                  height: 1.5 * b / a,
                  letterSpacing: 1.08 * a,
                  color: const Color(0x66000000),
                ),
                decoration: InputDecoration(
                    hintStyle: SafeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w300,
                      color: const Color(0x66000000),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter Room Name',
                    enabledBorder: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x66000000)),
                    )),
              ),
              SizedBox(height: 35 * a),
              Consumer<RoomsProvider>(
                builder:(context, value, child) => TextButton(
                  onPressed: () {
                    if(textEditingController.text.isEmpty){
                      showCustomSnackBar('Enter Room Name!', context);
                    }else if((croppedImagePaths??imagePaths) == null){
                      showCustomSnackBar('Image Required!', context);
                    }else if(!value.creatingRoom){
                      value.create(textEditingController.text, croppedImagePaths??imagePaths).then((value) {
                        if(value.status==1){
                          Get.back();
                        }else{
                          showCustomSnackBar(value.message, context);
                        }
                        return null;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 210 * a,
                    height: 36 * a,
                    decoration: BoxDecoration(
                      color: const Color(0xff9e26bc),
                      borderRadius: BorderRadius.circular(27 * a),
                    ),
                    child: Center(
                      child: Text(
                        value.creatingRoom?'Please Wait..':'Verify',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 16 * b,
                          fontWeight: FontWeight.w700,
                          height: 1.2102272511 * b / a,
                          letterSpacing: 0.64 * a,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
