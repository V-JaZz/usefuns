import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:live_app/utils/utils_assets.dart';

class CreateClubScreen extends StatefulWidget {
  const CreateClubScreen({Key? key}) : super(key: key);

  @override
  State<CreateClubScreen> createState() => _CreateClubScreenState();
}

class _CreateClubScreenState extends State<CreateClubScreen> {
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
            style: SafeGoogleFont(
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
                  Container(
                    height: 120 * a,
                    width: 120 * a,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.camera_alt,
                                size: 40 * a,
                              )),
                          Text(
                            'Add Club Avatar',
                            style: SafeGoogleFont(
                              'inter',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w700,
                              height: 1.2125 * b / a,
                              letterSpacing: 0.64 * a,
                            ),
                          )
                        ]),
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
                    style: SafeGoogleFont('Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * b / a,
                        letterSpacing: 0.64 * a,
                        color: Colors.grey.shade500),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 8 * a,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintMaxLines: 20,
                  hintText: "Name your Club",
                  contentPadding: EdgeInsets.symmetric(
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
                    style: SafeGoogleFont('Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * b / a,
                        letterSpacing: 0.64 * a,
                        color: Colors.grey.shade500),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 8 * a,
              ),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintMaxLines: 20,
                  hintText: "Tag your Club",
                  contentPadding: EdgeInsets.symmetric(
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
                style: SafeGoogleFont('Poppins',
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
                    style: SafeGoogleFont('Poppins',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.2125 * b / a,
                        letterSpacing: 0.64 * a,
                        color: Colors.grey.shade500),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 8 * a,
              ),
              TextFormField(
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
                style: SafeGoogleFont('Poppins',
                    fontSize: 12 * b,
                    fontWeight: FontWeight.bold,
                    height: 1.2125 * b / a,
                    letterSpacing: 0.64 * a,
                    color: Colors.amber),
              ),
              SizedBox(
                height: 42 * a,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Center(
                      child: Text(
                    "Create with 5000 Diamonds",
                    style: SafeGoogleFont('Poppins',
                        fontSize: 13 * b,
                        fontWeight: FontWeight.bold,
                        height: 2 * b / a,
                        letterSpacing: 0.64 * a,
                        color: Colors.white),
                  )),
                  width: 300 * b,
                  height: 35 * a,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
