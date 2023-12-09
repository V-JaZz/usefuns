import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/response/shop_items_model.dart';

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
        return Padding(
          padding: EdgeInsets.only(top: 15.0 * a),
          child: value.items[type]!.data!.isEmpty
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top:15.0 * a ),
                    child: Text('No $type found!'),
                  ))
              : Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    spacing: 20 * a,
                    runSpacing: 30 * a,
                    children: List.generate(value.items[type]!.data!.length, (index) {
                      return viewItem(value.items[type]!.data![index]);
                    }),
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
                height: 12*a,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(width: 3*a),
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
            onTap: (){
              if(type == 'frame'){
                framePreviewDialog(
                  item.images!.first
                    ,item.name.toString()
                    ,'${item.price}/${item.day} Days'
                );
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

  void framePreviewDialog(String path, String title, String price){
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: SizedBox(
                width: 50 * a,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: SafeGoogleFont('Poppins',
                          fontSize: 16 * b,
                          fontWeight: FontWeight.w600,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: Colors.black),
                    ),
                    SizedBox(height: 3*a),
                    SizedBox(
                      width: 80 * a,
                      height: 80 * a,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 13,
                            right: 11,
                            left: 11,
                            bottom: 9,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image:Provider.of<UserDataProvider>(context,listen: false).userData!.data!.images!.isEmpty
                                      ?const DecorationImage(
                                      image: AssetImage('assets/profile.png')
                                  )
                                      :DecorationImage(
                                      image: NetworkImage(
                                          Provider.of<UserDataProvider>(context,listen: false).userData?.data?.images
                                              ?.first ??
                                              '')
                                  )
                              ),
                            ),
                          ),
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * a, 0 * a, 0 * a, 0 * a),
                                width: 80 * a,
                                height: 80 * a,
                                child: Image.network(
                                  path,
                                  fit: BoxFit.contain,
                                )
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 9*a),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/ic_diamond.png',
                          height: 12*a,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: 3*a),
                        Text(
                          price,
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
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 12 * a,
                            left: 0 * a,
                            right: 0 * a),
                        child: Container(
                            width: 136 * a,
                            height: 30 * a,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.only(
                                topLeft: Radius.circular(
                                    9 * a),
                                topRight: Radius.circular(
                                    9 * a),
                                bottomLeft:
                                Radius.circular(
                                    9 * a),
                                bottomRight:
                                Radius.circular(
                                    9 * a),
                              ),
                              color: Colors.deepOrangeAccent,
                            ),
                            child: Center(
                              child: Text(
                                'Buy Now',
                                style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 13 * a,
                                    fontWeight:
                                    FontWeight.w500,
                                    height: 1.5 * b / a,
                                    letterSpacing:
                                    0.48 * a,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12 * a,
                          left: 0 * a,
                          right: 0 * a),
                      child: GestureDetector(
                        onTap: (){Get.back();},
                        child: Text(
                          'Back',
                          style: SafeGoogleFont('Poppins',
                              fontSize: 13 * a,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: const Color.fromARGB(
                                  255, 64, 63, 63)),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
