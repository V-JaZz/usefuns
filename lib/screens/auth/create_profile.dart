import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:live_app/provider/auth_provider.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../data/model/response/register_model.dart';
import '../../utils/common_widgets.dart';
import '../dashboard/bottom_navigation.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  String? name;
  DateTime? selectedDate;
  String? gender;
  File? pickedImage;
  String? imagePaths;
  String? croppedImagePaths;
  int nameLength = 0;
  String? selectedLanguage = 'English';


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1999),
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
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder:(context, value, child) => Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(24 * a),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Start to Create Your Profile',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 22 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.1725 * b / a,
                          letterSpacing: 1.98 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
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
                              child: croppedImagePaths == null? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30 * a),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/logo_greystyle.png',
                                    ),
                                  ),
                                ),
                              ):CircleAvatar(
                                radius: 30 * a,
                                backgroundImage: FileImage(File(croppedImagePaths!)),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                                right: 0,
                                child: Center(
                                  child: Icon(Icons.edit,color: Colors.grey,size: 15*a,),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 6 * a),
                              child: Text(
                                'Select Gender',
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
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = 'Male';
                              });
                            },
                            child: Container(
                              decoration: gender == 'Male'
                                  ? BoxDecoration(
                                      color: const Color(0x119e26bc),
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                        width: 1,
                                        strokeAlign: BorderSide.strokeAlignInside,
                                        color: const Color(0xFF9e26bc),
                                      ))
                                  : null,
                              child: Column(
                                children: [
                                  Container(
                                    width: 30 * a,
                                    height: 30 * a,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15 * a),
                                      image: const DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          'assets/icons/ic_male.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Male',
                                    style: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 16 * b,
                                      fontWeight: FontWeight.w300,
                                      height: 1.5 * b / a,
                                      letterSpacing: 1.44 * a,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20 * a,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = 'Female';
                              });
                            },
                            child: Container(
                              decoration: gender == 'Female'
                                  ? BoxDecoration(
                                      color: const Color(0x119e26bc),
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                        width: 1,
                                        strokeAlign: BorderSide.strokeAlignInside,
                                        color: const Color(0xFF9e26bc),
                                      ))
                                  : null,
                              child: Column(
                                children: [
                                  Container(
                                    width: 30 * a,
                                    height: 30 * a,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15 * a),
                                      image: const DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          'assets/icons/ic_female.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Female',
                                    style: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 16 * b,
                                      fontWeight: FontWeight.w300,
                                      height: 1.5 * b / a,
                                      letterSpacing: 1.44 * a,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20 * a,
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 3 * a),
                            child: Text(
                              'Language',
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
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return languageDialog();
                                  });
                              setState(() {});
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
                                  hintText:
                                      selectedLanguage ?? 'Choose Your Language',
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
                                      ? 'Selected Date: ${selectedDate.toString().split(' ')[0]}'
                                      : 'Please Select Your Birthday',
                                  disabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0x66000000)),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your gender and language cannot be changed after filling.',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w300,
                          height: 1.5 * b / a,
                          letterSpacing: 1.08 * a,
                          color: const Color(0x66000000),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () async {
                          if((croppedImagePaths??imagePaths)== null){
                            showCustomSnackBar('Profile Picture is Required!', Get.context!);
                          }else if(name!='' && name!=null && selectedDate !=null && gender!='' && gender!=null){
                            RegisterModel model = await value.register(name: name!, dob: DateFormat('MM-dd-yyyy').format(selectedDate!), gender: gender!,image: croppedImagePaths??imagePaths,language: selectedLanguage);
                            if (model.status == 1) {
                          Get.offAll(() => const BottomNavigator());
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
              if(value.isLoading)loadingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  languageDialog() {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return AlertDialog(
          title: const Text('Choose Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('English'),
                leading: Radio(
                  value: 'English',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Hindi'),
                leading: Radio(
                  value: 'Hindi',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Spanish'),
                leading: Radio(
                  value: 'Spanish',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                Navigator.of(context).pop(selectedLanguage);
              },
            ),
          ],
        );
      },
    );
  }
}
