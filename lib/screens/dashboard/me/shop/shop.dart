import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/screens/dashboard/me/mine/mine.dart';
import 'package:provider/provider.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';
import '../../../../provider/user_data_provider.dart';
import '../../../../utils/utils_assets.dart';
import 'shop_tab_view.dart';

class Shop extends StatefulWidget {
  final int? index;
  const Shop({super.key, this.index});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late int index;
  @override
  void initState() {
    index = widget.index??0;
    Provider.of<ShopWalletProvider>(context, listen: false).getAll();
    super.initState();
  }
  @override
  void dispose() {
    final p = Provider.of<ShopWalletProvider>(Get.context!, listen: false);
    if(p.loadingShopProgress != null) p.loadingShopProgress=0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    final shopWalletProvider = Provider.of<ShopWalletProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white)),
        title: const Text(
          'SHOP',
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
                style: safeGoogleFont(
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
              Get.off(() => Mine(index: index), transition: Transition.noTransition);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3 * a),
                color: Colors.white,
              ),
              child: Text(
                'MINE',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
      body: shopWalletProvider.loadingShopProgress == null
          ? VerticalTabs(
              tabsWidth: 120 * a,
              initialIndex: index,
              onSelect: (tabIndex) {
                index = tabIndex;
              },
              indicatorColor: Theme.of(context).primaryColor,
              selectedTabBackgroundColor:
                  Theme.of(context).primaryColor.withOpacity(0.1),
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
                  text: 'Special ID'
                   ,
                ),
                Tab(
                  text: 'Room Accessories',
                ),
              ],
              contents: const [
                ShopCommonView(type: 'frame'),
                ShopCommonView(type: 'chatBubble'),
                ShopCommonView(type: 'wallpaper'),
                ShopCommonView(type: 'vehicle'),
                ShopCommonView(type: 'relationship'),
                ShopCommonView(type: 'specialId'),
                ShopCommonView(type: 'lockRoom', type2: 'extraSeat'),
              ],
            )
          : Center(
              child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: Provider.of<ShopWalletProvider>(context)
                          .loadingShopProgress,
                    ),
                  ),
                ),
                Center(
                    child: Text(
                        '${(Provider.of<ShopWalletProvider>(context).loadingShopProgress! * 100).toInt()}%'))
              ],
            )),
    );
  }
}
