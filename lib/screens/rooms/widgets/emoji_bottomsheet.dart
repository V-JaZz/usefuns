import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';


class Emoji extends StatefulWidget {
  const Emoji({Key? key}) : super(key: key);

  @override
  State<Emoji> createState() => _EmojiState();
}

class _EmojiState extends State<Emoji> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 24 * a),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            runSpacing: 24 * a,
            spacing: 18 * a,
            children: [
              iconTextRow('assets/emoji/1.png', true),
              iconTextRow('assets/emoji/2.png', true),
              iconTextRow('assets/emoji/3.png', true),
              iconTextRow('assets/emoji/4.png', true),
              iconTextRow('assets/emoji/5.png', true),
              iconTextRow('assets/emoji/6.png', true),
              iconTextRow('assets/emoji/7.png', true),
              iconTextRow('assets/emoji/8.png', true),
              iconTextRow('assets/emoji/9.png', true),
              iconTextRow('assets/emoji/10.png', false),
              iconTextRow('assets/emoji/11.png', false),
              iconTextRow('assets/emoji/12.png', false),
            ],
          ),
        ],
      ),
    );
  }

  iconTextRow(String path, bool vip) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return GestureDetector(
      onTap: (){
        Provider.of<ZegoRoomProvider>(context,listen: false).reactEmoji(path.split('/').last.split('.').first);
        Get.back();
      },
      child: SizedBox(
        width: 93 * a,
        height: 68 * a,
        child: Stack(
          children: [
            Positioned(
              left: 0 * a,
              top: 11 * a,
              child: Image.asset(
                path,
                width: 58 * a,
                height: 57 * a,
              ),
            ),
            if (vip)
              Positioned(
                left: 35 * a,
                top: 0 * a,
                child: Container(
                  width: 58 * a,
                  height: 18 * a,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9 * a),
                    color: const Color(0xffffe500),
                  ),
                  child: Center(
                    child: Text(
                      'SVIP',
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.171875 * b / a,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
