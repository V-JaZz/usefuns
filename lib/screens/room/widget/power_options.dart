import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/dashboard/bottom_navigation.dart';
import 'package:provider/provider.dart';

void viewPowerDailog(){
  showDialog(
      context: Get.context!,
      builder: (context) {
        double baseWidth = 360;
        double a = Get.width / baseWidth;
        double b = a * 0.97;
        return AlertDialog(
          backgroundColor:
          Colors.transparent,
          surfaceTintColor: Colors.transparent,
          content: Container(
            color: Colors.transparent,
            height: 350,
            width: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 5 * a),
                Container(
                  decoration:
                  BoxDecoration(
                    borderRadius:
                    BorderRadius
                        .circular(
                        55),
                    color:
                    Colors.white.withOpacity(0.8),
                    border: Border.all(color: Colors.green,width: 3)
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    icon: Icon(
                        Icons
                            .arrow_upward_rounded,
                        size: 70 * a,color: Colors.green),
                  ),
                ),
                SizedBox(
                    height: 120 * a),
                Container(
                  decoration:
                  BoxDecoration(
                      borderRadius:
                      BorderRadius
                          .circular(
                          55),
                      color:
                      Colors.white.withOpacity(0.8),
                      border: Border.all(color: Colors.deepOrangeAccent,width: 3)
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                      Get.back();
                      Provider.of<ZegoRoomProvider>(context,listen:false).destroy();
                    },
                    icon: Icon(
                        Icons
                            .power_settings_new_sharp,
                        size: 70 * a,color: Colors.deepOrangeAccent),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}