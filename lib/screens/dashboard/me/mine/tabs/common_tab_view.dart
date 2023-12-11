import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/response/shop_items_model.dart';
import '../../../../../data/model/response/user_data_model.dart';

class MineCommonView extends StatelessWidget {
  final String type;
  const MineCommonView({super.key, required this.type});
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    bool isNullOrEmpty = checkNullOrEmpty(context);
    final list = getItemsList(context);

    return Consumer<UserDataProvider>(
      builder: (context, value, _) {
        return Padding(
          padding: EdgeInsets.only(top: 15.0 * a),
          child: isNullOrEmpty
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
                    children: List.generate(list.length, (index) {
                      return viewItem(list[index].name!,list[index].images!.first);
                    }),
                  ),
                ),
        );
      },
    );
  }

  Widget viewItem(String name, String image) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SizedBox(
      width: 90 * a,
      child: Column(
        children: [
          Image.network(
            image,
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
          Text(name,textAlign: TextAlign.center),
          GestureDetector(
            onTap: (){
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

  bool checkNullOrEmpty(context) {
    final value =Provider.of<UserDataProvider>(context,listen: false);
    switch(type){
      case 'theme':
        return value.userData?.data?.roomWallpaper?.isEmpty??true;
      default:
        return true;
    }
  }

  List<ItemModel> getItemsList(context){
    final value =Provider.of<UserDataProvider>(context,listen: false);
    switch(type){
      case 'theme':
        return value.userData?.data?.roomWallpaper??[];
      default:
        return [];
    }
  }
}
