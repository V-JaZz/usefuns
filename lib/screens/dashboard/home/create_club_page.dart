import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../../provider/club_provider.dart';

class CreateClubScreen extends StatefulWidget {
  const CreateClubScreen({Key? key}) : super(key: key);

  @override
  State<CreateClubScreen> createState() => _CreateClubScreenState();
}

class _CreateClubScreenState extends State<CreateClubScreen> {

  File? pickedImage;
  String? imagePaths;
  String? croppedImagePaths;
  final name = TextEditingController();
  final label = TextEditingController();
  final announcement = TextEditingController();

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
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        maxHeight: 200,
        maxWidth: 200,
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Create a Club',
            style: safeGoogleFont(
              'inter',
              fontSize: 20 * b,
              fontWeight: FontWeight.w700,
              height: 1.2125 * b / a,
              letterSpacing: 0.64 * a,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7 * a),
          child: Column(
            children: [
              SizedBox(
                height: 20 * a,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                          context: context, builder: (builder) => imagePicker());
                    },
                    child: Container(
                      height: 120 * a,
                      width: 120 * a,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)),
                      child: croppedImagePaths != null
                          ? FittedBox(child: Image.file(File(croppedImagePaths!)))
                          :Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                  Icons.camera_alt,
                                  size: 40 * a,
                                ),
                            SizedBox(height: 8*a),
                            Text(
                              'Add Club Avatar',
                              style: safeGoogleFont(
                                'inter',
                                fontSize: 12 * b,
                                fontWeight: FontWeight.w700,
                                height: 1.2125 * b / a,
                                letterSpacing: 0.64 * a,
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20 * a,
              ),
              Row(
                children: [
                  Text(
                    'Club Name',
                    style: safeGoogleFont('Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * b / a,
                        letterSpacing: 0.64 * a,
                        color: Colors.grey.shade500),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 8 * a,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintMaxLines: 20,
                  hintText: "Name your Club",
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8), // Adjust the value for vertical centering
                ),
                // Other properties...
              ),
              SizedBox(
                height: 8 * a,
              ),
              Row(
                children: [
                  Text(
                    'Club Label',
                    style: safeGoogleFont('Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * b / a,
                        letterSpacing: 0.64 * a,
                        color: Colors.grey.shade500),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 8 * a,
              ),
              TextFormField(
                controller: label,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintMaxLines: 20,
                  hintText: "Tag your Club",
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8), // Adjust the value for vertical centering
                ),
                // Other properties...
              ),
              SizedBox(
                height: 8 * a,
              ),
              Text(
                "A label is a short name for your club;it will be shown in club rooms and on club menmbers",
                style: safeGoogleFont('Poppins',
                    fontSize: 10 * b,
                    fontWeight: FontWeight.bold,
                    height: 1.2125 * b / a,
                    letterSpacing: 0.64 * a,
                    color: Colors.amber),
              ),
              SizedBox(
                height: 8 * a,
              ),
              Row(
                children: [
                  Text(
                    'Club Announcement',
                    style: safeGoogleFont('Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * b / a,
                        letterSpacing: 0.64 * a,
                        color: Colors.grey.shade500),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 8 * a,
              ),
              TextFormField(
                controller: announcement,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintMaxLines: 20,
                  hintText: "Tag your Club",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 40.0 * a,
                    horizontal: 8,
                  ), // Adjust the value for vertical centering
                ),
                // Other properties...
              ),
              SizedBox(
                height: 10 * a,
              ),
              Text(
                'Tips: \n 1. Leader can get rewards when your club is in the top 150 of monthly ranking.(settled monthly)\n 2. There is a limit on how many times you can change your avatar , name, label , so choose wisely \n 3.You can create a club for free if your wealth level is greater than lv.35',
                style: safeGoogleFont('Poppins',
                    fontSize: 12 * b,
                    fontWeight: FontWeight.bold,
                    height: 1.2125 * b / a,
                    letterSpacing: 0.64 * a,
                    color: Colors.amber),
              ),
              SizedBox(
                height: 42 * a,
              ),
              Consumer<UserDataProvider>(
                builder: (context, user, child) => GestureDetector(
                  onTap: () {
                    if((user.userData?.data?.diamonds??0)>5000){
                      Provider.of<ClubProvider>(context,listen: false).create(name.text, label.text, croppedImagePaths??imagePaths!, announcement.text);
                    }else{
                      showCustomSnackBar('Insufficient Diamonds', context);
                    }
                  },
                  child: Container(
                    width: 300 * b,
                    height: 35 * a,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      "Create with 5000 Diamonds",
                      style: safeGoogleFont('Poppins',
                          fontSize: 13 * b,
                          fontWeight: FontWeight.bold,
                          height: 2 * b / a,
                          letterSpacing: 0.64 * a,
                          color: Colors.white),
                    )),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
