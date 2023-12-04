import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils_assets.dart';

class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      color: Colors.white,
      height: 80 * a,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0 * a),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundImage:
                  const AssetImage('assets/icons/club.png'),
                  radius: 21 * a,
                ),
                Text(
                  'Usefuns Friends',
                  style: SafeGoogleFont('Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(width: 18 * a),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundImage:
                  const AssetImage('assets/room_icons/ic_wa.png'),
                  radius: 21 * a,
                ),
                Text(
                  'Whatsapp',
                  style: SafeGoogleFont('Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: Colors.black),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
