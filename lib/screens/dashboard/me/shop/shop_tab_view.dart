import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/helper.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/model/response/shop_items_model.dart';
import '../../../../utils/common_widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class ShopCommonView extends StatefulWidget {
  final String type;
  final String? type2;
  const ShopCommonView({super.key, required this.type, this.type2});

  @override
  State<ShopCommonView> createState() => _ShopCommonViewState();
}

class _ShopCommonViewState extends State<ShopCommonView> {
  late List<Items> itemList;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;

    return Consumer<ShopWalletProvider>(
      builder: (context, value, _) {

        if(widget.type2 == null) {
          itemList = value.items[widget.type]?.data
              ?.where((e) => e.isOfficial != true)
              .toList()
              ?? [];
        }else{
          itemList = [...(value.items[widget.type]?.data??[]), ...(value.items[widget.type2]?.data??[])];
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0 * a,bottom: 30.0 * a),
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
                        return viewItem(itemList[index],widget.type2 != null && index==1);
                      }),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget viewItem(Items item, bool type2) {
    bool checkAlreadyOwned() {
      final ud = Provider.of<UserDataProvider>(context,listen: false).userData?.data;
      final similarFrames = ud!.frame!.where((e) => e.id == item.id);
      if(similarFrames.isEmpty){
        return false;
      }else if(similarFrames.where((e) => isValidValidity(e.validTill)).isNotEmpty){
        return true;
      }
      return false;
    }
    bool owned = checkAlreadyOwned();
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return GestureDetector(
      onTap: (){
        if (!owned) {
          showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) {
                return ItemBuyPreview(item: item, type: type2 ? widget.type2! : widget.type);
              });
        }
      },
      child: SizedBox(
        width: 90 * a,
        child: Column(
          children: [
            Image.network(
              item.images!.first,
              width: 90 * a,
              height: 90 * a,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Shimmer.fromColors(
                    highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    baseColor: Colors.transparent,
                    child: Container(
                      width: 90 * a,
                      height: 90 * a,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }
              },
            ),
            Text(capitalizeText(item.name!)),
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
            Container(
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
          ],
        ),
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
                  capitalizeText(widget.item.name!),
                  style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w600,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 3 * a),

                showPreview(),

                SizedBox(height: 3 * a),

                // Radio selection for price options
                if(widget.item.priceAndvalidity!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.item.priceAndvalidity!.length; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPriceIndex = i;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio(
                              value: i,
                              groupValue: selectedPriceIndex,
                              visualDensity: VisualDensity.comfortable,
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
                                fontSize: 13 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.1725 * b / a,
                                color: Colors.black87
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Consumer<UserDataProvider>(
                  builder: (context, udp, _) => GestureDetector(
                    onTap: () async {
                      if((udp.userData?.data?.diamonds??0) < (widget.item.priceAndvalidity?[selectedPriceIndex].price??100)){
                        showInsufficientDialog(context,(widget.item.priceAndvalidity?[selectedPriceIndex].price??100)-(udp.userData?.data?.diamonds??0));
                      }else if(!value.isBuying){
                        final success = await value.buyItem(
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

  Widget showPreview() {
    double baseWidth = 360;
    double a = Get.width / baseWidth;

    switch(widget.type){
      case 'frame':
        return userProfileDisplay(
            size: 100*a,
            image: Provider.of<UserDataProvider>(context,listen: false).userData!.data!.images!.isEmpty?'':Provider.of<UserDataProvider>(context,listen: false).userData?.data?.images?.first??'',
            frame: '${widget.item.images?.last}'
        );
        case 'chatBubble':
          return SizedBox(
            height: 90*a,
            width: 120*a,
            child: Stack(
              children: [
                Image.network(
                  '${widget.item.images?.last}',
                  height: 90*a,
                  width: 120*a,
                  fit: BoxFit.fitWidth,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 90*a,
                    width: 120*a,
                    alignment: Alignment.center,
                    child: Text(
                      'Hii! how are you?',
                      style: SafeGoogleFont('Poppins',
                          fontSize: 9 * a,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.48 * a,
                          color: Colors.white),),
                  ),
                )
              ],
            ),
          );
    //   case 'theme':
    //     return value.userData?.data?.roomWallpaper??[];
      case 'vehicle':
        return SizedBox(
            width: 100*a,
            height: 100*a,
            child:SVGASimpleImage(
              resUrl: '${widget.item.images?.last}',
            ));
    // // case 'special ID':
    // //   return value.userData?.data?.specialId??[];
    //   case 'room accessories':
    //     return [...(value.userData?.data?.lockRoom??[]), ...(value.userData?.data?.extraSeat??[])];
      default:
        return Image.network(
          '${widget.item.images?.last}',
          height: 100*a,
          width: 100*a,
        );
    }
  }
}
