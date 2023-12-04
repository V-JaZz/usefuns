import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/me/diamond_seller/tabs/balance_tab_view.dart';
import 'package:live_app/screens/dashboard/me/diamond_seller/tabs/recharge_user.dart';
import 'package:live_app/screens/dashboard/me/diamond_seller/tabs/record_tab_view.dart';
import 'package:provider/provider.dart';

import '../../../../provider/user_data_provider.dart';
import '../../../../utils/utils_assets.dart';

class DiamondSeller extends StatefulWidget {
  const DiamondSeller({super.key});

  @override
  State<DiamondSeller> createState() => _DiamondSellerState();
}

class _DiamondSellerState extends State<DiamondSeller> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Diamond Seller'),
      ),
      body: Column(
        children: [
          sellerDetails(a,b),
          SizedBox(height: 8 * a),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(children: [
                TabBar(
                  indicatorColor: Colors.black,
                  indicatorWeight: 1.3,
                  labelColor: const Color(0xff000000),
                  unselectedLabelColor: const Color(0x99000000),
                  labelStyle: SafeGoogleFont(
                    'Poppins',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.96 * a,
                    color: const Color(0xff000000),
                  ),
                  unselectedLabelStyle: SafeGoogleFont(
                    'Poppins',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.96 * a,
                    color: const Color(0x99000000),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30 * a),
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      text: "Recharge",
                    ),
                    Tab(
                      text: "Balance",
                    ),
                    Tab(
                      text: "Record",
                    )
                  ],
                ),
                const Expanded(
                    child: TabBarView(
                        children: [
                          RechargeUserTabView(),
                          BalanceTabView(),
                          SellerRecordTabView(),
                        ]
                    )
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget sellerDetails(double a,double b) {
    final providerUserData = Provider.of<UserDataProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12*a, vertical: 3*a),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 54 * a,
            height: 54 * a,
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4),width: 3),
                shape: BoxShape.circle
            ),
            child: providerUserData
                .userData!.data!.images!.isEmpty
                ? CircleAvatar(
                foregroundImage:
                const AssetImage('assets/profile.png'),
                radius: 27 * a)
                : CircleAvatar(
                foregroundImage: NetworkImage(
                    providerUserData.userData?.data?.images
                        ?.first ??
                        ''),
                radius: 27 * a),
          ),
          SizedBox(width: 8*a),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: 1234567890',
                textAlign: TextAlign.left,
                style: SafeGoogleFont(
                    color: Colors.black.withOpacity(0.7),
                    'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1),
              ),
              SizedBox(height: 6*a),
            ],
          )
        ],
      ),
    );
  }
}
