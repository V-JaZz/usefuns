import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/datasource/local/sharedpreferences/storage_service.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/constants.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/model/response/user_data_model.dart';
import '../../../../provider/zego_room_provider.dart';
import '../../../../utils/common_widgets.dart';
import '../../../../utils/helper.dart';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class MineCommonView extends StatelessWidget {
  final String type;
  const MineCommonView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;

    bool isNullOrEmpty = checkNullOrEmpty(context);

    return Consumer<UserDataProvider>(
      builder: (context, value, _) {

        final list = getItemsList(context,value);

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 15.0 * a,bottom: 30.0 * a),
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
                      children: List.generate(list.length, (i) {
                        int index = list.length-i-1;
                        return viewItem(list[index]);
                      }),
                    ),
                  ),
          ),
        );

      },
    );

  }

  Widget viewItem(UserItem item) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    bool permanent = (item.isOfficial??false) && item.validTill==null;
    bool isSelected = item.isDefault == true ? isValidValidity(item.validTill) : false;
    String timeLeft = calculateRemainingTime(item.validTill);

    return GestureDetector(

      onTap: () {
        if((timeLeft!='Expired' || permanent)) {
          if(type == 'room accessories'){
            showCustomSnackBar('Use ${item.name??''} in your room!', Get.context!,isError: false, isToaster: true);
          }else{
            Get.dialog(MineItemDialog(
                title: item.name??'',
                path: item.images?.last??'',
                frameId: item.id??'',
                isSelected: isSelected,
                type: type
            ));
          }
        }
      },
      child: Container(
        width: 100 * a,
        padding: EdgeInsets.all(5*a),
        decoration: BoxDecoration(
            color: timeLeft=='Expired' && !permanent ?Colors.grey.shade100:isSelected? const Color(0xFF7926BC).withOpacity(0.1): Colors.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: isSelected? const Color(0xFF7926BC): Colors.white)
        ),
        child: Column(
          children: [
            Image.network(
              '${item.images?.first}',
              width: 90 * a,
              height: 90 * a,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Shimmer.fromColors(
                    highlightColor: const Color(0xFF7926BC).withOpacity(0.1),
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
            Text(capitalizeText(item.name!),textAlign: TextAlign.center),
            permanent
                ? const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.security, color: Color(0xFF7926BC),size: 18,),
                    Text('Official',textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF7926BC))),
                  ],
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.access_time_rounded, color: Color(0xFF7926BC),size: 18,),
                    Text(' $timeLeft',textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF7926BC))),
                  ],
                ),
          ],
        ),
      ),
    );
  }

  bool checkNullOrEmpty(context) {
    final value =Provider.of<UserDataProvider>(context,listen: false);
    switch(type){
      case 'frame':
        return value.userData?.data?.frame?.isEmpty??true;
      case 'wallpaper':
        return value.userData?.data?.roomWallpaper?.isEmpty??true;
      case 'chatBubble':
        return value.userData?.data?.chatBubble?.isEmpty??true;
      case 'vehicle':
        return value.userData?.data?.vehicle?.isEmpty??true;
      // case 'specialId':
      //   return value.userData?.data?.specialId?.isEmpty??true;
      case 'room accessories':
        return [...(value.userData?.data?.lockRoom??[]), ...(value.userData?.data?.extraSeat??[])].isEmpty;
      default:
        return true;
    }
  }

  List<UserItem> getItemsList(context,UserDataProvider value){
    switch(type){
      case 'frame':
        return value.userData?.data?.frame??[];
      case 'chatBubble':
        return value.userData?.data?.chatBubble??[];
      case 'wallpaper':
        return value.userData?.data?.roomWallpaper??[];
      case 'vehicle':
        return value.userData?.data?.vehicle??[];
      case 'specialId':
        return value.userData?.data?.specialId??[];
      case 'room accessories':
        return [...(value.userData?.data?.lockRoom??[]), ...(value.userData?.data?.extraSeat??[])];
      default:
        return [];
    }
  }

}

class MineItemDialog extends StatelessWidget {
  final String type;
  final String path;
  final String title;
  final String frameId;
  final bool? isSelected;
  const MineItemDialog({super.key, required this.path, required this.title, this.isSelected, required this.frameId, required this.type});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
          width: 50 * a,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                capitalizeText(title),
                style: safeGoogleFont('Poppins',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w600,
                    height: 1.5 * b / a,
                    letterSpacing: 0.48 * a,
                    color: Colors.black),
              ),
              SizedBox(height: 3 * a),
              showPreview(context),
              SizedBox(height: 3 * a),
              if(isSelected!=true)GestureDetector(
                onTap: () async {
                  Get.back();
                  if(isSelected==false){
                    final res = await Provider.of<UserDataProvider>(context,listen: false).makeItemDefault(itemId: frameId, type: type);
                    if(res.status == 0) {
                      showCustomSnackBar(res.message??'error!', Get.context!,isToaster: true);
                    }else if(type == 'wallpaper'){
                      final zp = Provider.of<ZegoRoomProvider>(Get.context!,listen:false);
                      if(zp.room?.userId == StorageService().getString(Constants.id)){
                        zp.updateRoomTheme();
                      }
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
                      child: Text(
                        isSelected==false?'Apply':'Buy Now',
                        style: safeGoogleFont('Poppins',
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
                    style: safeGoogleFont('Poppins',
                        fontSize: 13 * a,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * b / a,
                        letterSpacing: 0.48 * a,
                        color: const Color.fromARGB(255, 64, 63, 63)),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget showPreview(context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;

    switch(type){
      case 'frame':
        return userProfileDisplay(
            size: 100*a,
            image: Provider.of<UserDataProvider>(context,listen: false).userData!.data!.images!.isEmpty?'':Provider.of<UserDataProvider>(context,listen: false).userData?.data?.images?.first??'',
            frame: path
        );
      case 'chatBubble':
        return SizedBox(
          height: 90*a,
          width: 120*a,
          child: Stack(
            children: [
              Image.network(
                path,
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
                    'Hii! welcome to my room.',
                    textAlign: TextAlign.center,
                    style: safeGoogleFont('Poppins',
                        fontSize: 9 * a,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.48 * a,
                        color: Colors.white),),
                ),
              )
            ],
          ),
        );
      // case 'wallpaper':
    // //   return value.userData?.data?.specialId??[];
      case 'vehicle':
        return SizedBox(
            width: 100*a,
            height: 100*a,
            child:SVGASimpleImage(
              resUrl: path,
            ));
    // // case 'specialId':
    // //   return value.userData?.data?.specialId??[];
    //   case 'room accessories':
    //     return [...(value.userData?.data?.lockRoom??[]), ...(value.userData?.data?.extraSeat??[])];
      default:
        return Image.network(
            path,
          height: 100*a,
          width: 100*a,
        );
    }
  }
}
