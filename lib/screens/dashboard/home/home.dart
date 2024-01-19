import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/home/tabs/mine_tab_view.dart';
import 'package:live_app/screens/dashboard/home/tabs/new_tab_view.dart';
import 'package:live_app/screens/dashboard/home/tabs/popular_tab_view.dart';
import 'package:live_app/utils/utils_assets.dart';
import '../../../utils/common_widgets.dart';
import 'search_room_user.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color(0x339E26BC),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 1,
          title: Row(
            children: [
              Container(
                width: 24 * a,
                height: 24 * a,
                padding: const EdgeInsets.all(3),
                child: Image.asset(
                  'assets/icons/ic_home.png',
                ),
              ),
              Expanded(
                child: TabBar(
                  indicatorColor: Colors.black,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 6 * a),
                  indicatorWeight: 1.3,
                  dividerColor: Colors.transparent,
                  labelColor: const Color(0xff000000),
                  unselectedLabelColor: const Color(0x99000000),
                  labelStyle: SafeGoogleFont(
                    'Poppins',
                    fontSize: 21 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.96 * a,
                    color: const Color(0xff000000),
                  ),
                  unselectedLabelStyle: SafeGoogleFont(
                    'Poppins',
                    fontSize: 18 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.96 * a,
                    color: const Color(0x99000000),
                  ),
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      text: "Mine",
                    ),
                    Tab(
                      text: "Popular",
                    ),
                    Tab(
                      text: "New",
                    )
                  ],
                ),
              ),
              Container(
                width: 24 * a,
                height: 24 * a,
                padding: const EdgeInsets.all(3),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const SearchRoomUser());
                  },
                  child: Image.asset(
                    'assets/icons/ic_search.png',
                  ),
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MineTabView(),
            PopularTabView(),
            NewTabView(),
          ],
        ),
      ),
    );
  }

}
