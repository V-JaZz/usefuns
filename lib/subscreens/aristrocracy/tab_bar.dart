import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/subscreens/aristrocracy/aristrocracy_centre.dart';
import 'package:live_app/subscreens/aristrocracy/bubble.dart';
import 'package:live_app/subscreens/aristrocracy/duke.dart';
import 'package:live_app/subscreens/aristrocracy/marquis.dart';

import '../../screens/dashboard/me/me.dart';

class TabsBar extends StatefulWidget {
  const TabsBar({super.key});

  @override
  State<TabsBar> createState() => _TabsBarState();
}

class _TabsBarState extends State<TabsBar> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75 * a,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Text(
          'Aristrocracy Center',
        ),
        actions: const [],
      ),
      //  body: Container(
      //   decoration: const BoxDecoration(color: Colors.white),
      //   padding: const EdgeInsets.all(8.0),
      //   child: ContainedTabBarView(
      //     tabs: const [
      //       Text('Vehicle'),
      //       Text('Bubble'),
      //       Text('UniqueID'),
      //       Text('Number'),
      //     ],
      //     views: const [
      //       Vehicle(),
      //       Bubble(),
      //       Uid(),
      //       Bubble(),
      //     ],
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(8.0 * a),
        child: ContainedTabBarView(
          tabs: const [
            Text('Viscount'),
            Text('Count'),
            Text('Marquis'),
            Text('Duke'),
          ],
          views: const [
            Viscount(),
            Bubbles(),
            Marquis(),
            Duke(),
          ],
        ),
      ),
    );
  }
}
