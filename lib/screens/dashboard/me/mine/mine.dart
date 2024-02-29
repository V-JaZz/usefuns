import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';
import '../../../../provider/user_data_provider.dart';
import '../../../../utils/utils_assets.dart';
import '../shop/shop.dart';
import 'mine_tab_view.dart';

class Mine extends StatefulWidget {
  final int? index;
  const Mine({super.key, this.index});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  late int index;
  @override
  void initState() {
    index = widget.index??0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color(0xFF7926BC),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon:
                const Icon(Icons.arrow_back_ios_rounded, color: Colors.white)),
        title: const Text(
          'MINE',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          Row(
            children: [
              Image.asset('assets/icons/ic_diamond.png',
                  height: 12 * a, width: 12 * a),
              SizedBox(width: 3 * a),
              Text(
                Provider.of<UserDataProvider>(context)
                    .userData!
                    .data!
                    .diamonds
                    .toString(),
                style: SafeGoogleFont(
                  'Roboto',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.171875 * b / a,
                  color: const Color(0xffffffff),
                ),
              ),
              SizedBox(width: 12 * a),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.off(() => Shop(index: index), transition: Transition.noTransition);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3 * a),
                color: Colors.white,
              ),
              child: const Text(
                'SHOP',
                style: TextStyle(color: Color(0xFF7926BC)),
              ),
            ),
          ),
        ],
      ),
      body: VerticalTabs(
              tabsWidth: 120 * a,
              initialIndex: index,
              indicatorColor: const Color(0xFF7926BC),
              onSelect: (tabIndex) {
                index = tabIndex;
              },
              selectedTabBackgroundColor:
                  const Color(0xFF7926BC).withOpacity(0.1),
              tabs: const <Tab>[
                Tab(
                  text: 'Frame',
                ),
                Tab(
                  text: 'Bubble',
                ),
                Tab(
                  text: 'Theme',
                ),
                Tab(
                  text: 'Vehicle',
                ),
                Tab(
                  text: 'Relation',
                ),
                Tab(
                  text: 'Special ID',
                ),
                Tab(
                  text: 'Room Accessories',
                ),
              ],
              contents: const [
                MineCommonView(type: 'frame'),
                MineCommonView(type: 'chatBubble'),
                MineCommonView(type: 'wallpaper'),
                MineCommonView(type: 'vehicle'),
                MineCommonView(type: 'relation'),
                MineCommonView(type: 'specialId'),
                MineCommonView(type: 'room accessories'),
              ],
            )
    );
  }
}
