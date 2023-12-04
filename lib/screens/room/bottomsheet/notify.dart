import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../subscreens/mess/usefuns_teams.dart';
import '../../../utils/utils_assets.dart';
import '../../dashboard/message/activity.dart';
import '../../dashboard/message/system_notification.dart';
import '../../dashboard/message/usefuns_club_notifications.dart';

class NotificationsBottomSheet extends StatelessWidget {
  NotificationsBottomSheet({super.key});

  final List<Map> notifications = [
    {
      "title": "System",
      "message":
      "Please Complete Your Profile, So that Other People Can Know You better, and You can get more followers",
      "color": 0xFFFF9933,
      "icon": Icons.notifications_none,
      "onTap": () {
        Get.to(() => System());
      },
    },
    {
      "title": "Usefuns Club",
      "message": "",
      "color": 0xff14ae80,
      "icon": Icons.people_alt_outlined,
      "onTap": () {
        Get.to(() => const UsefunsClubNotification());
      },
    },
    {
      "title": "Activity",
      "message": "Every Single gift has a rank, a greater chance",
      "color": 0xFFEE3074,
      "icon": Icons.outlined_flag,
      "onTap": () {
        Get.to(() => Activity());
      },
    },
    {
      "title": "Usefuns team",
      "message": "",
      "color": 0xff14ae80,
      "icon": Icons.headset_mic_outlined,
      "onTap": () {
        Get.to(() => const UsefunsTeam());
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 300 * a,
      padding: EdgeInsets.all(18 * a),
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                    children: [
                      Container(
                          height: 33 * a,
                          width: 36 * a,
                          color: const Color(0xFF4285F4),
                          child: const Icon(Icons.comment_sharp,
                              color: Colors.white)),
                      SizedBox(height: 5 * a),
                      Text(
                        'Comments',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 15 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.6 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  child: Column(
                    children: [
                      Container(
                          height: 33 * a,
                          width: 36 * a,
                          color: const Color(0xFFEE3074),
                          child: const Icon(Icons.thumb_up_off_alt,
                              color: Colors.white)),
                      SizedBox(height: 5 * a),
                      Text(
                        'Likes',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 15 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.6 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  child: Column(
                    children: [
                      Container(
                          height: 33 * a,
                          width: 36 * a,
                          color: const Color(0xFF34A853),
                          child: const Icon(Icons.people_alt_outlined,
                              color: Colors.white)),
                      SizedBox(height: 5 * a),
                      Text(
                        'Followers',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 15 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.6 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: 18 * a,
          ),
          for (Map m in notifications)
            Column(
              children: [
                ListTile(
                  onTap: m['onTap'],
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
                    m['title'],
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 15 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.6 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(height: 8*a)
              ],
            )
        ]),
      ),
    );
  }
}
