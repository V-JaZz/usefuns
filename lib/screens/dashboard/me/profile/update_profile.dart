import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_app/data/model/response/common_model.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import '../../../../utils/common_widgets.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  String? name;
  String? email;
  String? bio;
  DateTime? selectedDate;
  File? pickedImage;
  String? imagePaths;
  String? croppedImagePaths;
  int nameLength = 0;


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate??DateTime(1999),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

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
        maxHeight: 250,
        maxWidth: 250,
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
  void initState() {
    final user = Provider.of<UserDataProvider>(context,listen: false);
    name = user.userData?.data?.name??'';
    email = user.userData?.data?.email??'';
    bio = user.userData?.data?.bio??'';
    selectedDate = user.userData?.data?.dob;
    nameLength = user.userData?.data?.name?.length??0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserDataProvider>(
          builder:(context, value, child) => Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(24 * a),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                              context: context, builder: (builder) => imagePicker());
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 60 * a,
                              height: 60 * a,
                              child: croppedImagePaths == null
                                  ? (
                              value.userData!.data!.images!.isEmpty
                                  ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30 * a),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/logo_greystyle.png',
                                    ),
                                  ),
                                ),
                              )
                              : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30 * a),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      value.userData?.data?.images?.first??'',
                                    ),
                                  ),
                                ),
                              )
                              )
                                  :CircleAvatar(
                              radius: 30 * a,
                              backgroundImage: FileImage(File(croppedImagePaths!)),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                              radius: 13*a,
                              child: Center(
                                child: Icon(Icons.edit,color: Colors.grey,size: 15*a,),
                              ),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tap to edit the Profile Picture',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 16 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 1.44 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 3 * a),
                            child: Text(
                              'Nickname',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 16 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * b / a,
                                letterSpacing: 1.44 * a,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w300,
                              height: 1.5 * b / a,
                              letterSpacing: 1.08 * a,
                              color: const Color(0xFF000000),
                            ),
                            initialValue: name,
                            onChanged: (value) {
                              setState(() {
                                nameLength = value.length;
                                name = value;
                              });
                            },
                            maxLength: 24,
                            decoration: InputDecoration(
                                counterText: "",
                                isDense: true,
                                suffixIcon: Text(
                                  '$nameLength/24',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 12 * b,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5 * b / a,
                                    letterSpacing: 1.08 * a,
                                    color: const Color(0x66000000),
                                  ),
                                ),
                                suffixIconConstraints:
                                    BoxConstraints(maxHeight: 15 * a),
                                hintStyle: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 12 * b,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0x66000000),
                                ),
                                hintText: 'Enter Nickname',
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0x66000000)),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 3 * a),
                            child: Text(
                              'Birthday',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 16 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * b / a,
                                letterSpacing: 1.44 * a,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: TextFormField(
                              enabled: false,
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 12 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * b / a,
                                letterSpacing: 1.08 * a,
                                color: const Color(0x66000000),
                              ),
                              decoration: InputDecoration(
                                  isDense: true,
                                  suffixIcon: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: const Color(0x66000000),
                                    size: 15 * a,
                                  ),
                                  suffixIconConstraints:
                                      BoxConstraints(maxHeight: 15 * a),
                                  hintStyle: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 12 * b,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0x66000000),
                                  ),
                                  hintText: selectedDate != null
                                      ? selectedDate.toString().split(' ')[0]
                                      : 'Please Select Your Birthday',
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0x66000000)),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 3 * a),
                            child: Text(
                              'Email',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 16 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * b / a,
                                letterSpacing: 1.44 * a,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w300,
                              height: 1.5 * b / a,
                              letterSpacing: 1.08 * a,
                              color: const Color(0xFF000000),
                            ),
                            initialValue: email,
                            onChanged: (value) {
                                email = value;
                            },
                            decoration: InputDecoration(
                                counterText: "",
                                isDense: true,
                                hintStyle: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 12 * b,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0x66000000),
                                ),
                                hintText: 'Enter your email address',
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0x66000000)),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 3 * a),
                            child: Text(
                              'Bio',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 16 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * b / a,
                                letterSpacing: 1.44 * a,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w300,
                              height: 1.5 * b / a,
                              letterSpacing: 1.08 * a,
                              color: const Color(0xFF000000),
                            ),
                            initialValue: bio,
                            onChanged: (value) {
                              bio = value;
                            },
                            decoration: InputDecoration(
                                counterText: "",
                                isDense: true,
                                hintStyle: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 12 * b,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0x66000000),
                                ),
                                hintText: 'Enter about you',
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0x66000000)),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      TextButton(
                        onPressed: () async {
                          print('name : $name, dob : $selectedDate, email : $email, bio : $bio');
                          if(name!='' && name!=null && selectedDate !=null ){
                            CommonModel model = await value.updateUser(name: name!, dob: selectedDate!.toIso8601String(), email: email,image: croppedImagePaths??imagePaths,bio: bio);
                            if (model.status == 1) {
                              Get.back();
                            } else {
                              showCustomSnackBar(model.message, Get.context!);
                            }
                          }else{
                            showCustomSnackBar('All fields are required!', Get.context!);
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 314 * a,
                          height: 47 * a,
                          decoration: BoxDecoration(
                            color: const Color(0xff9e26bc),
                            borderRadius: BorderRadius.circular(27 * a),
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 16 * b,
                                fontWeight: FontWeight.w700,
                                height: 1.2125 * b / a,
                                letterSpacing: 0.64 * a,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(value.isUserDataLoading)loadingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
