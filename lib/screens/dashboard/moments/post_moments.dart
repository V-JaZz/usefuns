import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';

import '../../../provider/moments_provider.dart';
import '../../../utils/utils_assets.dart';

class PostMoments extends StatefulWidget {
  const PostMoments({super.key});

  @override
  State<PostMoments> createState() => _PostMomentsState();
}

class _PostMomentsState extends State<PostMoments> {
  File? pickedImage;
  String? imagePaths;
  String? croppedImagePaths;
  String? caption;


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
        sourcePath: imagePaths!, // Set your desired aspect ratio
        compressFormat: ImageCompressFormat.jpg,
        maxHeight: 1000,
        maxWidth: 500,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio5x4,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: const Color(0x339E26BC),
              toolbarWidgetColor: Colors.black,
              // toolbarWidgetColor: const Color(0xff9e26bc),
              initAspectRatio: CropAspectRatioPreset.original,
              statusBarColor: const Color(0x339E26BC),
              activeControlsWidgetColor: const Color(0xff9e26bc),
              lockAspectRatio: false),
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
    final momentsProvider = Provider.of<MomentsProvider>(context);
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 1,
        title: Text('Add Moment',
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Poppins',
              fontSize: 20 * b,
              fontWeight: FontWeight.w400,
              height: 1.5 * b / a,
              letterSpacing: 0.8 * a,
              color: const Color(0xff000000),
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: (builder) => imagePicker());
              },
              child: croppedImagePaths!= null
                  ? SizedBox(
                height: 200*a,
                    child: Image.file(
                    File(croppedImagePaths!
              )),
                  )
                  :Image.asset(
                'assets/add_post.png',
                color: Colors.grey,
                height: 200*a,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12*a),
            child: TextField(
              onChanged: (value) {
                caption=value;
              },
              decoration: const InputDecoration(
                hintText: 'Enter moment caption',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(!momentsProvider.isPosting){
                if ((croppedImagePaths??imagePaths) != null) {
                  momentsProvider.addPost(croppedImagePaths??imagePaths!, caption).then((value) {
                    if (value.status == 1) {
                      Get.back();
                      showCustomSnackBar(value.message, Get.context!,
                          isError: false, isToaster: true);
                    } else {
                      showCustomSnackBar(value.message, context, isError: true);
                    }
                    return null;
                  });
                } else {
                  showCustomSnackBar('Select Image!', context, isError: true);
                }
              }
            },
            child: Container(
              width: 180 * a,
              height: 44 * a,
              margin: EdgeInsets.only(top: 24*a),
              decoration: BoxDecoration(
                color: const Color(0xff9e26bc),
                borderRadius: BorderRadius.circular(12 * a),
              ),
              child: Center(
                child: Text(
                  momentsProvider.isPosting?'Posting':'Post',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.64 * a,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
