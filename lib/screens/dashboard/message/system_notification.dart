import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:live_app/utils/utils_assets.dart';

class System extends StatelessWidget {
  System({super.key});
  final Map m = {
    "title": "System",
    "message":
        "Please Complete Your Profile, So that Other People Can Know You better, and You can get more followers",
    "color": 0xFFFF9933,
    "icon": Icons.notifications_none,
  };

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
        title: Text(m['title']),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0 * a),
        child: ListTile(
          onTap: () {},
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Color(m['color']),
            radius: 15 * a,
            child: Icon(
              m['icon'],
              color: Colors.white,
            ),
          ),
          title: Text(
            'Usefuns  Official',
            style: SafeGoogleFont(
              'Poppins',
              fontSize: 15 * b,
              fontWeight: FontWeight.w400,
              height: 1.5 * b / a,
              letterSpacing: 0.6 * a,
              color: const Color(0xff000000),
            ),
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                m['message'],
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 10 * b,
                  fontWeight: FontWeight.w300,
                  height: 1.5 * b / a,
                  letterSpacing: 0.4 * a,
                  color: const Color(0x99000000),
                ),
              ),
              Text(
                '\n5 hours ago',
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 10 * b,
                  fontWeight: FontWeight.w300,
                  height: 1.5 * b / a,
                  letterSpacing: 0.4 * a,
                  color: const Color(0x99000000),
                ),
              ),
            ],
          ),
          trailing: Column(
            children: [
              Container(
                width: 48 * a,
                height: 17 * a,
                decoration: BoxDecoration(
                  color: const Color(0xff9e26bc),
                  borderRadius: BorderRadius.circular(9 * a),
                ),
                child: Center(
                  child: Text(
                    'Fill in',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 10 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.4 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
