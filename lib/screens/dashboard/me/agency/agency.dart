import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../../../provider/seller_agency_provider.dart';
import '../../../../provider/user_data_provider.dart';
import 'agency_reward.dart';
import 'tabs/host_data.dart';
import 'tabs/invite_host.dart';

class AgencyTab extends StatefulWidget {
  const AgencyTab({super.key});

  @override
  State<AgencyTab> createState() => _AgencyTabState();
}

class _AgencyTabState extends State<AgencyTab> {
  @override
  void initState() {
    Provider.of<SellerAgencyProvider>(context,listen: false).loginAgency(
        '${Provider.of<UserDataProvider>(context,listen: false).userData?.data?.mobile}'
    );
    super.initState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 66 * a,
        backgroundColor: Colors.deepOrange,
        leading:   IconButton(
          icon:  const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Agency',
          style: safeGoogleFont(
            'Poppins',
            fontSize: 14 * b,
            fontWeight: FontWeight.w400,
            height: 1.5 * b / a,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<SellerAgencyProvider>(
        builder: (context, value, _) {
          if(!value.isAgentLogged){
            return const Center(child: CircularProgressIndicator(color: Colors.deepOrange));
          }
          return Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: ContainedTabBarView(
            tabBarProperties: const TabBarProperties(
              indicatorColor: Colors.deepOrange
            ),
            tabs: [
              tabBarWidget('Host Data'),
              tabBarWidget('Invite Host'),
              // tabBarWidget('Report'),
              tabBarWidget('Reward'),
            ],
            views: const [
              HostDataTabView(),
              InviteHostTabView(),
              // HostMember(),
              AgencyReward(),
            ],
          ),
        );
        },
      ),
    );
  }

  Text tabBarWidget(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Text(
      txt,
      style: safeGoogleFont(
        'Poppins',
        fontSize: 12 * b,
        fontWeight: FontWeight.w400,
        height: 1.5 * b / a,
        color: Colors.black,
      ),
    );
  }
}
