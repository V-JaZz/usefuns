import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:provider/provider.dart';

void kickRoomWidget(context, name, id){
  double baseWidth = 390;
  double a = MediaQuery.of(context).size.width / baseWidth;
  double b = a * 0.97;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: ShapeBorder.lerp(
            InputBorder.none,
            InputBorder.none,
            0),
        child: Container(
          width: 280 * a,
          padding: EdgeInsets.all(21 * a),
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(
                  7 * a)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Confirm to Kick out of the Room?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14 * a),
              ),
              SizedBox(height: 9 * a),
              Row(
                children: [
                  Icon(
                    Icons
                        .radio_button_off_rounded,
                    size: 16 * a,
                  ),
                  SizedBox(width: 9 * a),
                  Expanded(
                    child: Text(
                      "Permanently Block him and forbid him from entering your room",
                      style: TextStyle(
                          color: const Color(
                              0x99000000),
                          fontWeight:
                          FontWeight.w300,
                          fontSize: 14 * a),
                    ),
                  )
                ],
              ),
              SizedBox(height: 24 * a),
              GestureDetector(
                onTap: (){
                  Provider.of<ZegoRoomProvider>(context,listen: false).kickStreamer(id!,name!);
                  Get.back();
                },
                child: Container(
                  height: 20 * a,
                  width: 140 * a,
                  decoration: BoxDecoration(
                      color: const Color(
                          0xFFFF9933),
                      borderRadius:
                      BorderRadius.circular(
                          12 * a)),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                          FontWeight.w300,
                          fontSize: 14 * a),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12 * a),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: const Color(
                          0x99000000),
                      fontWeight:
                      FontWeight.w300,
                      fontSize: 14 * a),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}