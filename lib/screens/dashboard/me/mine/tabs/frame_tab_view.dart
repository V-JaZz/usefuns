import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../../../../../utils/common_widgets.dart';

class MineFrameTabView extends StatelessWidget {
  const MineFrameTabView({super.key});
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    bool isNullOrEmpty =
        Provider.of<UserDataProvider>(context).userData?.data?.frame?.isEmpty ??
            true;
    final list =
        Provider.of<UserDataProvider>(context).userData?.data?.frame ?? [];

    return Consumer<UserDataProvider>(
      builder: (context, value, _) {
        return Padding(
          padding: EdgeInsets.only(top: 15.0 * a),
          child: isNullOrEmpty
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0 * a),
                    child: const Text('No fame found!'),
                  ))
              : Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    spacing: 10 * a,
                    runSpacing: 30 * a,
                    children: List.generate(list.length, (index) {
                      return viewFrameWidget(
                          list[index].name!,
                          list[index].images!,
                          list[index].defaultFrame??false,
                          list[index].id!
                      );
                    }),
                  ),
                ),
        );
      },
    );
  }

  Widget viewFrameWidget(String name, List<String> image,bool isSelected, String frameId) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      width: 100 * a,
      padding: EdgeInsets.all(5*a),
      decoration: BoxDecoration(
        color: isSelected? const Color(0xFF7926BC).withOpacity(0.1): Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: isSelected? const Color(0xFF7926BC): Colors.white)
      ),
      child: Column(
        children: [
          Image.network(
            image.first,
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
          Text(name, textAlign: TextAlign.center),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: Get.context!,
                  barrierDismissible: false,
                  builder: (context) {
                    return FramePreview(title: name ,path: image.last, isSelected: isSelected, frameId: frameId);
                  });
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

class FramePreview extends StatelessWidget {
  final String path;
  final String title;
  final String frameId;
  final String? price;
  final bool? isSelected;
  const FramePreview({super.key, required this.path, required this.title, this.price, this.isSelected, required this.frameId});

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
                title,
                style: SafeGoogleFont('Poppins',
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
                  frame: path
              ),
              SizedBox(height: 3 * a),
              if(price!=null)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/ic_diamond.png',
                    height: 12 * a,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(width: 3 * a),
                  Text(
                    price!,
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
              if(isSelected!=true)GestureDetector(
                onTap: () async {
                  Get.back();
                  if(isSelected==false){
                    final res = await Provider.of<UserDataProvider>(context,listen: false).selectFrame(frameId: frameId);
                    if(res.status == 0) {
                      showCustomSnackBar(res.message??'error!', context,isToaster: true);
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
          )),
    );
  }
}
