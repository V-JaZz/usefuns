import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';
import '../../../../provider/user_data_provider.dart';
import '../../../../utils/utils_assets.dart';
import 'tabs/accessories.dart';
import 'tabs/common_tab_view.dart';
import 'tabs/special_id.dart';
import 'tabs/theme.dart';

class Shop extends StatefulWidget {
  final int? index;
  const Shop({super.key, this.index});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  void initState() {
    Provider.of<ShopWalletProvider>(context, listen: false).getAll();
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
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Text(
          'SHOP',
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
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3 * a),
                color: Colors.pink,
              ),
              child: const Text(
                'MY SHOP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Provider.of<ShopWalletProvider>(context).isShopLoaded
          ? VerticalTabs(
              tabsWidth: 120 * a,
              initialIndex: widget.index ?? 0,
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
                  text: 'Special ID',
                ),
                Tab(
                  text: 'Room Accessories',
                ),
              ],
              contents: const [
                ShopCommonView(item: 'frame'),
                ShopCommonView(item: 'chatBubble'),
                ShopTheme(),
                ShopCommonView(item: 'vehicle'),
                ShopCommonView(item: 'relationship'),
                ShopSpecialId(),
                ShopRoomAccessories()
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
                      value: Provider.of<ShopWalletProvider>(context).loadingShopProgress,
                    ),
                  ),
                ),
                Center(
                    child: Text(
                        '${(Provider.of<ShopWalletProvider>(context).loadingShopProgress * 100).toInt()}%'))
              ],
            )),
    );
  }
}
