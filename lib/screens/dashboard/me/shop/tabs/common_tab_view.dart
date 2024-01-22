import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/helper.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../../../../data/model/response/shop_items_model.dart';
import '../../../../../utils/common_widgets.dart';

class ShopCommonView extends StatefulWidget {
  final String type;
  const ShopCommonView({super.key, required this.type});

  @override
  State<ShopCommonView> createState() => _ShopCommonViewState();
}

class _ShopCommonViewState extends State<ShopCommonView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;

    return Consumer<ShopWalletProvider>(
      builder: (context, value, _) {
        final itemList = value.items[widget.type]?.data
                ?.where((e) => e.isOfficial == true)
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
                      child: Text('No ${widget.type} found!'),
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
    bool checkAlreadyOwned() {
      final ud = Provider.of<UserDataProvider>(context,listen: false).userData?.data;
      final similarFrames = ud!.frame!.where((e) => e.id == item.id);
      if(similarFrames.isEmpty){
        return false;
      }else if(similarFrames.where((e) => isValidValidity(e.validTill!)).isNotEmpty){
        return true;
      }
      return false;
    }
    bool owned = checkAlreadyOwned();
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
              if(item.priceAndvalidity!.isNotEmpty)Text(
                '${item.priceAndvalidity?.first.price}/${item.priceAndvalidity?.first.validity} Days',
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
              if (!owned) {
                showDialog(
                    context: Get.context!,
                    barrierDismissible: false,
                    builder: (context) {
                      return ItemBuyPreview(item: item,type: widget.type);
                    });
              }
            },
            child: Container(
              width: 70 * a,
              height: 16 * a,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
                color: owned
                    ?const Color.fromRGBO(124, 255, 146, 1)
                    :const Color.fromRGBO(255, 229, 0, 1),
              ),
              child: Center(
                child: Text(
                  owned?'OWNED':'PREVIEW',
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


class ItemBuyPreview extends StatefulWidget {
  final Items item;
  final String type;
  const ItemBuyPreview({super.key, required this.item, required this.type});

  @override
  State<ItemBuyPreview> createState() => _ItemBuyPreviewState();
}

class _ItemBuyPreviewState extends State<ItemBuyPreview> {
  int selectedPriceIndex = 0;
  late bool owned;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return AlertDialog(
      backgroundColor: Colors.white,
      content: Consumer<ShopWalletProvider>(
        builder: (context, value, _) {
          return SizedBox(
            width: 50 * a,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${widget.item.name}',
                  style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w600,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: Colors.black),
                ),
                SizedBox(height: 3 * a),
                userProfileDisplay(
                    size: 100*a,
                    image: Provider.of<UserDataProvider>(context,listen: false).userData!.data!.images!.isEmpty?'':Provider.of<UserDataProvider>(context,listen: false).userData?.data?.images?.first??'',
                    frame: '${widget.item.images?.last}'
                ),
                SizedBox(height: 3 * a),

                // Radio selection for price options
                if(widget.item.priceAndvalidity!.isNotEmpty)Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.item.priceAndvalidity!.length; i++)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            value: i,
                            groupValue: selectedPriceIndex,
                            activeColor: Colors.deepOrangeAccent,
                            onChanged: (value) {
                              setState(() {
                                selectedPriceIndex = value as int;
                              });
                            },
                          ),
                          Image.asset(
                            'assets/icons/ic_diamond.png',
                            height: 12 * a,
                            fit: BoxFit.fitHeight,
                          ),
                          SizedBox(width: 3 * a),
                          Text(
                            '${widget.item.priceAndvalidity![i].price}/${widget.item.priceAndvalidity![i].validity} Days',
                            style: TextStyle(
                              fontSize: 10 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.1725 * b / a,
                              color: const Color.fromARGB(255, 11, 11, 11),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    if(!value.isBuying){
                      final success = await value.buy(
                          widget.type,
                          widget.item.priceAndvalidity?[selectedPriceIndex].price??100,
                          widget.item,
                          widget.item.priceAndvalidity?[selectedPriceIndex].validity??1);
                      Get.back();
                      if(success) {
                        showCustomSnackBar('Buying Successful!', Get.context!,isError: false,isToaster: true);
                      }else{
                        showCustomSnackBar('Error Buying!', Get.context!,isToaster: true);
                      }
                    }
                  },
                  child: Container(
                      width: 136 * a,
                      height: 30 * a,
                      margin: EdgeInsets.only(
                          top: 12 * a, left: 0 * a, right: 0 * a),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9 * a),
                          topRight: Radius.circular(9 * a),
                          bottomLeft: Radius.circular(9 * a),
                          bottomRight: Radius.circular(9 * a),
                        ),
                        color: Colors.deepOrangeAccent,
                      ),
                      child: Center(
                        child: value.isBuying
                            ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FittedBox(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 8)),
                            )
                            : Text(
                          'Buy Now',
                          style: SafeGoogleFont('Poppins',
                              fontSize: 13 * a,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: Colors.white),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 12 * a, left: 0 * a, right: 0 * a),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Back',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 13 * a,
                          fontWeight: FontWeight.w500,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: const Color.fromARGB(255, 64, 63, 63)),
                    ),
                  ),
                ),
              ],
            ));
        },
      ),
    );
  }
}
