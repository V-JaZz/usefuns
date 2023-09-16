import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/me/me.dart';
import 'package:live_app/subscreens/wallet_U/beans.dart';
import 'package:live_app/subscreens/wallet_U/coins.dart';
import 'package:live_app/subscreens/wallet_U/diamond.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.to(() => const Me());
          },
        ),
        title: const Text(
          'Wallet',
        ),
        actions: [
          IconButton(icon: const Icon(Icons.help_outline_outlined), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(8.0),
        child: ContainedTabBarView(
          tabs: const [
            Text('Diamond'),
            Text('Beans'),
            Text('Coins'),
          ],
          views: const [
            Diamondpage(),
            BeanPage(),
            Coins(),
          ],
        ),
      ),
    );
  }
}
