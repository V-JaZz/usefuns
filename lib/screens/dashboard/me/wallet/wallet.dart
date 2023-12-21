import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/me/me.dart';
import 'tabs/coins.dart';
import 'tabs/beans.dart';
import 'tabs/diamond.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 75,
        // backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        backgroundColor: index==0?Colors.green:(index==1?const Color(0xffFEA500):const Color(0xffF74928)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Wallet',
        ),
        actions: [
          IconButton(icon: const Icon(Icons.help_outline_outlined),
              onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(8.0),
        child: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
            indicatorColor: index==0?Colors.green:(index==1?const Color(0xffFEA500):const Color(0xffF74928)),
            labelColor: index==0?Colors.green:(index==1?const Color(0xffFEA500):const Color(0xffF74928))
          ),
          onChange: (p0) {
            setState(() {
              index = p0;
            });
          },
          tabs: const [
            Text('Diamond'),
            Text('Beans'),
            Text('Coins'),
          ],
          views: const [
            DiamondTabView(),
            BeanTabView(),
            CoinsTabView(),
          ],
        ),
      ),
    );
  }
}
