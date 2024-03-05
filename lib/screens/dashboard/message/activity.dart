import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:live_app/utils/utils_assets.dart';

class Activity extends StatelessWidget {
  Activity({Key? key}) : super(key: key);

  final List<Map> activityList = [
    {
      "image": "assets/dummy/activity1.png",
      "text":
          "Come and Join the lucky draw to win great rewards| Use gold Coins 10 times 30 times to get lucky rewards"
    },
    {
      "image": "assets/dummy/activity2.png",
      "text": "Task avtivity is Online| Go do the task and get the reward"
    },
    {
      "image": "assets/dummy/activity3.png",
      "text":
          "The PK Challenge is coming .Join PK Challange Can have Chance to open box and get PK gift by free during 18 to 24 o’ Clock Every day"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 1,
        title: const Text("Activity"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22 * a, vertical: 28 * a),
        child: ListView(
          children: List.generate(
              activityList.length,
              (index) => Padding(
                    padding: EdgeInsets.only(bottom: 28.0 * a),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 114 * a,
                          child: Image.asset(
                            activityList[index]["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8 * a),
                        Text(
                          activityList[index]["text"],
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 14 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.56 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
