import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/response/shop_items_model.dart';
import '../../../../../provider/shop_wallet_provider.dart';
import '../../../../../utils/utils_assets.dart';

class ShopTheme extends StatelessWidget {
  const ShopTheme({super.key});

  final item = 'wallpaper';

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Consumer<ShopWalletProvider>(
      builder: (context, value, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0 * a),
            child: value.items[item]!.data!.isEmpty
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0 * a),
                      child: const Text('No theme found!'),
                    ))
                : Align(
                    alignment: Alignment.topCenter,
                    child: Wrap(
                      spacing: 20 * a,
                      runSpacing: 30 * a,
                      children:
                          List.generate(value.items[item]!.data!.length, (index) {
                        return viewTheme(value.items[item]!.data![index]);
                      }),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget viewTheme(Items item) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SizedBox(
      width: 90 * a,
      child: Stack(
        children: [
          Image.network(
            item.images!.first,
            fit: BoxFit.cover,
            width: 90 * a,
            height: 150 * a,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 90 * a,
              height: 150 * a,
              padding: EdgeInsets.all(8 * a),
              child: Text(error.toString()),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return SizedBox(
                width: 90 * a,
                height: 150 * a,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          Positioned(
            bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.white54,
                child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                SizedBox(
                  width: 80 * a,
                  child: Text(
                      item.name.toString(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 80 * a,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/ic_diamond.png',
                  height: 12*a,
                  fit: BoxFit.fitHeight,
                      ),
                      Expanded(
                        child: Text(
                          '${item.price}/${item.day} Days',
                          maxLines: 2,
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 10 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.1725 * b / a,
                            color: const Color.fromARGB(255, 11, 11, 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 9*a),
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
              SizedBox(height: 12*a)
            ],
          ),
              ))
        ],
      ),
    );
  }
}
