import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/subscreens/mess/usefuns_teams.dart';
import 'package:live_app/screens/dashboard/me/profile/user_profile.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'activity.dart';
import 'system_notification.dart';
import 'usefuns_club_notifications.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  RefreshController refreshController = RefreshController();
  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
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
        "message": "     ",
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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        title: const Text('Notification'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        onRefresh: ()async{
          await Future.delayed(const Duration(milliseconds: 500),() {
            setState(() {});
          });
          refreshController.refreshCompleted();
          return;
        },
        physics: const BouncingScrollPhysics(),
        header: WaterDropMaterialHeader(distance: 36*a),
        controller: refreshController,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              children: [
                Column(
                  children: [
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
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                            InkWell(
                              onTap: () {
                                UserProfile();
                              },
                              child: Container(
                                  height: 33 * a,
                                  width: 36 * a,
                                  color: const Color(0xFF34A853),
                                  child: const Icon(Icons.people_alt_outlined,
                                      color: Colors.white)),
                            ),
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20 * a,
                    ),
                    for (Map m in notifications)
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
                        subtitle: Text(
                          m['message'],
                          maxLines: 1,
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
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
