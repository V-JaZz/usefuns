import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/utils_assets.dart';
import '../../dashboard/me/shop/shop.dart';
import '../widget/media_player.dart';
import 'manager.dart';

class BottomMoreBottomSheet extends StatelessWidget {
  const BottomMoreBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 420;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) => Container(
        color: Colors.white,
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 19.0 * a, vertical: 15 * a),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // SizedBox(
              //   width: 10 * a,
              // ),
              // InkWell(
              //   onTap: () {
              //     Get.to(() => const DailyTask());
              //   },
              //   child: iconTextRow(
              //       a, b, 'Daily\nTasks', 'assets/room_icons/b1.png'),
              // ),
              SizedBox(
                width: 20 * a,
              ),
              InkWell(
                onTap:(){
                  Get.back();
                  LiveRoomBottomSheets(context).showIncomeExpenseBottomSheet();
                },
                child: iconTextRow(a, b, 'Income &\nExpenditure',
                    'assets/room_icons/b2.png'),
              ),
              SizedBox(
                width: 20 * a,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.to(() => const Shop());
                },
                child: iconTextRow(a, b, 'Shop', 'assets/homeim.png'),
              ),
              SizedBox(
                width: 20 * a,
              ),
              // InkWell(
              //   onTap: () {
              //     Get.to(() => const TabsBar());
              //   },
              //   child: iconTextRow(
              //       a, b, 'Aristocracy', 'assets/room_icons/b4.png'),
              // ),
              // SizedBox(
              //   width: 10 * a,
              // ),
              value.onSeat && (value.isOwner || value.room!.admin!.contains(value.userID))? InkWell(
                onTap: () {
                  Get.back();
                  Get.to(() => const RoomMediaPlayer());
                },
                child: iconTextRow(a, b, 'Music', 'assets/musicc.png'),
              ):const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Container iconTextRow(double a, double b, String t, String p) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * a, horizontal: 3 * a),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70 * a,
            height: 60 * a,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(p),
              ),
            ),
          ),
          // CircleAvatar(
          //   foregroundImage: AssetImage(p),
          //   radius: 15 * a,
          // ),
          SizedBox(height: 6 * a),
          SizedBox(
            // width: 57 * a,
            child: Text(
              t,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: safeGoogleFont('Poppins',
                  fontSize: 12 * b,
                  fontWeight: FontWeight.w400,
                  height: 1 * b / a,
                  letterSpacing: 0.48 * a,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
