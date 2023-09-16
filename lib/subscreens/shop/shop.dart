import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/subscreens/shop/bubble.dart';
import 'package:live_app/subscreens/shop/lock.dart';
import 'package:live_app/subscreens/shop/relationship.dart';
import 'package:live_app/subscreens/shop/uid.dart';
import 'package:live_app/subscreens/shop/vehicle.dart';

import '../../screens/dashboard/me/me.dart';
import '../scree/mine.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Text(
          'SHOP',
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const MinPage());
            },
            child: Container(
              margin: EdgeInsets.only(right: 30),
              height: 33,
              width: 60,
              color: Colors.pink,
              child: Center(
                child: Text(
                  'MINE',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ContainedTabBarView(
          tabs: const [
            Text('Vehicle'),
            Text('Bubble'),
            Text('Id'),
            Text('Lock'),
            Text('Theme'),
            Text('Relation'),
          ],
          views: const [
            Vehicle(),
            Bubble(),
            Uid(),
            Loccking(),
            Bubble(),
            Relation(),
          ],
        ),
      ),
    );
  }

}
