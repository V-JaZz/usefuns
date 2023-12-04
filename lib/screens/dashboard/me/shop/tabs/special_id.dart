import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/shop_wallet_provider.dart';

class ShopSpecialId extends StatefulWidget {
  const ShopSpecialId({super.key});

  @override
  State<ShopSpecialId> createState() => _ShopSpecialIdState();
}

class _ShopSpecialIdState extends State<ShopSpecialId> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Consumer<ShopWalletProvider>(
      builder: (context, value, _) {
        return Padding(
          padding: EdgeInsets.only(top: 15.0 * a),
          child: value.items['specialId']!.data!.isEmpty
              ? Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top:15.0 * a ),
                child: const Text('No Special ID found!'),
              ))
              : Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              spacing: 20 * a,
              runSpacing: 30 * a,
              children:
              List.generate(value.items['specialId']!.data!.length, (index) {
                return cont(value.items['specialId']?.data?[index].name??'null');
              }),
            ),
          ),
        );
      },
    );
  }

  Container cont(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      width: (Get.width -150*a)/2,
      height: 33*a,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: const Color.fromRGBO(255, 229, 0, 1),
      ),
      child: Center(child: Text(txt)),
    );
  }
}
