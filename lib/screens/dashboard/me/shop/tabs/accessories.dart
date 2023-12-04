import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/response/shop_items_model.dart';

class ShopRoomAccessories extends StatelessWidget {
  const ShopRoomAccessories({super.key});

  @override
  Widget build(BuildContext context) {

    final p = Provider.of<ShopWalletProvider>(context,listen: false);
    List<Items> items = [...(p.items['lockRoom']?.data??[]), ...(p.items['extraSeat']?.data??[])];

    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Padding(
      padding: EdgeInsets.only(top: 15.0 * a),
      child: items.isEmpty
          ? Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top:15.0 * a ),
            child: const Text('No data found!'),
          ))
          : Align(
        alignment: Alignment.topCenter,
        child: Wrap(
          spacing: 20 * a,
          runSpacing: 30 * a,
          children:
          List.generate(items.length, (index) {
            return viewItem(items[index]);
          }),
        ),
      ),
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
            width: 60 * a,
            height: 60 * a,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 60 * a,
              height: 60 * a,
              padding: EdgeInsets.all(8 * a),
              child: Text(error.toString()),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return SizedBox(
                width: 60 * a,
                height: 60 * a,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          Text(item.name.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/diamond.png',
              ),
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
          Container(
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
        ],
      ),
    );
  }
}
