import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:live_app/subscreens/agency/agency_reward.dart';
import 'package:live_app/subscreens/agency/host_data.dart';
import 'package:live_app/subscreens/agency/host_member.dart';
import 'package:live_app/utils/utils_assets.dart';

import '../../screens/dashboard/me/me.dart';

class AgencyTab extends StatefulWidget {
  const AgencyTab({super.key});

  @override
  State<AgencyTab> createState() => _AgencyTabState();
}

class _AgencyTabState extends State<AgencyTab> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 66 * a,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        leading:   IconButton(
          icon:  const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Agency',
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 12 * b,
            fontWeight: FontWeight.w400,
            height: 1.5 * b / a,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ContainedTabBarView(
          tabs: [
            textt('HostData'),
            textt('HostMember'),
            textt('AgencyReport'),
            textt('AgencyReward'),
          ],
          views: const [
            Agency(),
            HostMember(),
            HostMember(),
            AgencyReward(),
          ],
        ),
      ),
    );
  }

  Text textt(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Text(
      txt,
      style: SafeGoogleFont(
        'Poppins',
        fontSize: 12 * b,
        fontWeight: FontWeight.w400,
        height: 1.5 * b / a,
        color: Colors.black,
      ),
    );
  }
}
