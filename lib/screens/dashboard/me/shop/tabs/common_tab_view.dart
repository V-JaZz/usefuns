import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../../../../data/model/response/shop_items_model.dart';
import '../../mine/tabs/frame_tab_view.dart';

class ShopCommonView extends StatelessWidget {
  final String type;
  const ShopCommonView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Consumer<ShopWalletProvider>(
      builder: (context, value, _) {
        final itemList = value.items[type]?.data
                ?.where((e) => e.isOfficial != true)
                .toList() ??
            [];

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0 * a),
            child: itemList.isEmpty
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0 * a),
                      child: Text('No $type found!'),
                    ))
                : Align(
                    alignment: Alignment.topCenter,
                    child: Wrap(
                      spacing: 20 * a,
                      runSpacing: 30 * a,
                      children: List.generate(itemList.length, (index) {
                        return viewItem(itemList[index]);
                      }),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget viewItem(Items item) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SizedBox(
      width: 90 * a,
      child: Column(
        children: [
          Image.network(
            item.images!.first,
            width: 90 * a,
            height: 90 * a,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 90 * a,
              height: 90 * a,
              padding: EdgeInsets.all(8 * a),
              child: Text(error.toString()),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return SizedBox(
                width: 90 * a,
                height: 90 * a,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          Text(item.name.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/ic_diamond.png',
                height: 12 * a,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(width: 3 * a),
              Text(
                '${item.price}/${item.day} Days',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 10 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.1725 * b / a,
                  color: const Color.fromARGB(255, 11, 11, 11),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (type == 'frame') {
                showDialog(
                    context: Get.context!,
                    barrierDismissible: false,
                    builder: (context) {
                      return FramePreview(title: item.name.toString() ,path: item.images!.last,price: '${item.price}/${item.day} Days',frameId: item.id!);
                    });
              }
            },
            child: Container(
              width: 70 * a,
              height: 16 * a,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
                color: Color.fromRGBO(255, 229, 0, 1),
              ),
              child: Center(
                child: Text(
                  'PREVIEW',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 10 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.1725 * b / a,
                    color: const Color.fromARGB(255, 11, 11, 11),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
