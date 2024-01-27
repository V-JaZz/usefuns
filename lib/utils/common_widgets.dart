import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../provider/shop_wallet_provider.dart';
import '../provider/user_data_provider.dart';
import '../screens/dashboard/me/profile/user_profile.dart';
import '../screens/dashboard/me/wallet/wallet.dart';
import 'constants.dart';

void showCustomSnackBar(String? message, BuildContext context,
    {bool isError = true, bool isToaster = false}) {
  if (isToaster) {
    Fluttertoast.showToast(
        msg: message ?? 'error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(message ?? 'error'),
      duration: const Duration(seconds: 2),
    ));
  }
}

Future<void> showCustomDialog(String title, String? subtitle,IconData? ic, {bool barrierDismissible = true, Color? icColor}) async {
  double baseWidth = 360;
  double a = Get.width / baseWidth;
  double b = a * 0.97;
  await showDialog(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
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
                  if(ic!=null)Icon(
                      ic,
                    size: 50*a,
                    color: icColor??Colors.deepOrangeAccent,
                  ),
                  SizedBox(height: 9*a),
                  if(subtitle!=null)Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont('Poppins',
                        fontSize: 10 * b,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * b / a,
                        letterSpacing: 0.48 * a,
                        color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: (){
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
                              'OKAY',
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
                ],
              )),
        );
      });
  return;
}

Widget loadingWidget() {
  return WillPopScope(
    onWillPop: () async => false,
    child: Stack(
      children: [
        // Background with blur effect
        Positioned.fill(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black.withOpacity(0.1), // Adjust opacity as needed
            ),
          ),
        ),
        // Centered circular progress indicator
        const Positioned.fill(
          child: Center(
            child: CircularProgressIndicator(
              color: Color(0xff9e26bc),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget userLevelTag(int level, double height, {bool viewZero = false}) {
  double width = height * 3.357;
  if (!viewZero && level == 0) return const SizedBox.shrink();
  Image getBg() {
    int i = 1;
    switch (level) {
      case < 2:
        break;
      case < 13:
        i = 2;
        break;
      case < 24:
        i = 3;
        break;
      case < 35:
        i = 4;
        break;
      case < 46:
        i = 5;
        break;
      case < 57:
        i = 6;
        break;
      case < 68:
        i = 7;
        break;
      case < 79:
        i = 8;
        break;
      case >= 79:
        i = 9;
        break;
    }
    return Image.asset(
      'assets/level_badge/level_badge_$i.png',
      fit: BoxFit.cover,
    );
  }
  return Stack(
    children: [
      SizedBox(height: height, width: width, child: getBg()),
      Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(left: width * 0.27),
        alignment: Alignment.center,
        child: Text(
          'Lv.$level',
          style: TextStyle(
              fontSize: height * .7,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );

}

Widget userProfileDisplay(
    {required double size,
      required String image,
      required String frame,
      Widget? child,
      void Function()? onTap}){
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: size * 0.7,
              height: size * 0.7,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: image.isEmpty
                      ? const DecorationImage(image: AssetImage('assets/profile.png'))
                      : DecorationImage(image: NetworkImage(image))),
              child: child,
            ),
          ),
          if(frame.isNotEmpty)
            frame.split('.').last == 'svga'
                ?SizedBox(
                  width: size,
                  height: size,
                  child:SVGASimpleImage(
                    resUrl: frame,
                ))
                :Container(
                  margin: EdgeInsets.all(size*0.05),
                  width: size*0.9,
                  height: size*0.9,
                  child: Image.network(
                    frame,
                    fit: BoxFit.contain,
                )),
        ],
      ),
    ),
  );
}

Widget roomListTile(
    {required String? image,
    required String title,
    required String? subTitle,
    required String? iso,
    required String active,
    required bool isLocked,
    required void Function() onTap}) {
  double baseWidth = 360;
  double a = Get.width / baseWidth;
  double b = a * 0.97;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(top: 8*a),
      height: 84*a,
      decoration: BoxDecoration(
        color: const Color(0x119E26BC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(6*a),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 72*a,
                width: 72*a,
                color: Colors.white,
                child: image == null
                    ? Image.asset(
                  "assets/logo_greystyle.png",
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Shimmer.fromColors(
                        highlightColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(0.3),
                        baseColor: Theme.of(context)
                            .primaryColor
                            .withOpacity(0.1),
                        child: Container(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                  // errorBuilder: (context, error, stackTrace) => Container(
                  //   alignment: Alignment.center,
                  //   color: Colors.white,
                  //   child: Text(error.toString(),
                  //       textAlign: TextAlign.center),
                  // ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8*a),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8*a),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 17 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.64 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    subTitle == null || subTitle == ''
                        ? 'Welcome to my room!'
                        : subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 14 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: const Color(0x99000000),
                    ),
                  ),
                ),
                SizedBox(height: 2*a),
                CountryFlag.fromCountryCode(
                  iso??'IN',
                  height: 14*a,
                  width: 21*a,
                  borderRadius: 4,
                )
              ],
            ),
          ),
          SizedBox(width: 4*a),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(isLocked)Padding(
                padding: const EdgeInsets.only(top: 12,right: 6),
                child: Icon(Icons.lock, color: const Color(0xFF9E26BC), size: 18*a),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15, width: 20, child: WaveAnimation()),
                    Text(
                      active == 'null' ? '0' : active,
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 14 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.48 * a,
                        color: const Color(0xff000000),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class WaveAnimation extends StatefulWidget {
  final Color? color;
  const WaveAnimation({Key? key, this.color}) : super(key: key);
  @override
  WaveAnimationState createState() => WaveAnimationState();
}

class WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _animation1 = Tween(begin: 7.0, end: 12.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _animation2 = Tween(begin: 12.0, end: 7.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _animation3 = Tween(begin: 7.0, end: 12.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 3),
        AnimatedBar(animation: _animation1,color: widget.color),
        const SizedBox(width: 2),
        AnimatedBar(animation: _animation2,color: widget.color),
        const SizedBox(width: 2),
        AnimatedBar(animation: _animation3,color: widget.color),
        const SizedBox(width: 4),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedBar extends StatelessWidget {
  final Animation<double> animation;
  final Color? color;
  const AnimatedBar({Key? key, required this.animation, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          height: animation.value,
          width: 3,
          decoration: BoxDecoration(
              color: color??Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6)),
        );
      },
    );
  }
}

Future<void> rewardDialog(String path, String title, String info, void Function()? onTap, {bool smallIcon = false}) async {
  double baseWidth = 360;
  double a = Get.width / baseWidth;
  double b = a * 0.97;
  await showDialog(
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
                  Image.asset(
                      path,
                    height: smallIcon ? 60 * a : 136 *a,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(height: 9*a),
                  Text(
                    info,
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont('Poppins',
                        fontSize: 10 * b,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * b / a,
                        letterSpacing: 0.48 * a,
                        color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: onTap,
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
                              'OKAY',
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
                ],
              )),
        );
      });
  return;
}

void showInsufficientDialog(context, int reqDiamonds) {
  String selectedPurchaseOption = 'beans';
  final user = Provider.of<UserDataProvider>(context, listen: false).userData;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            backgroundColor: Colors.white,
            // insetPadding: null,
            shape: Border.all(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 21, vertical: 12),
                    width: double.infinity,
                    child: FittedBox(
                        child: Column(
                          children: [
                            const Text('Your diamonds are not enough'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Account Balance ',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black38),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('assets/icons/ic_diamond.png',
                                        height: 12, width: 12),
                                    Text(
                                      '${user?.data?.diamonds} ',
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('assets/beans.png',
                                        height: 12, width: 12),
                                    Text(
                                      '${user?.data?.beans}',
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ))),
                const Text(
                  '   \t Recharge By:',
                  style: TextStyle(fontSize: 14, color: Colors.black38),
                ),
                RadioListTile<String>(
                  activeColor: const Color(0xFFFF9933),
                  dense: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/beans.png', height: 16, width: 16),
                      const Text('  Beans'),
                      const Spacer(),
                      Image.asset('assets/icons/ic_diamond.png',
                          height: 12, width: 12),
                      Text(
                        ' $reqDiamonds=${reqDiamonds*4} ',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Image.asset('assets/beans.png', height: 12, width: 12),
                    ],
                  ),
                  value: 'beans',
                  groupValue: selectedPurchaseOption,
                  onChanged: (value) {
                    setState(() {
                      selectedPurchaseOption = value as String;
                    });
                  },
                ),
                RadioListTile<String>(
                  activeColor: const Color(0xFFFF9933),
                  dense: true,
                  title: Row(
                    children: [
                      Image.asset('assets/other_wallet.png',
                          height: 16, width: 16),
                      const Text('  Wallet'),
                      const Spacer(),
                      // Image.asset('assets/icons/ic_diamond.png',
                      //     height: 12, width: 12),
                      // const Text(
                      //   ' 1000 = ₹750',
                      //   style: TextStyle(fontSize: 12),
                      // )
                    ],
                  ),
                  value: 'wallet',
                  groupValue: selectedPurchaseOption,
                  onChanged: (value) {
                    setState(() {
                      selectedPurchaseOption = value as String;
                    });
                  },
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      if(selectedPurchaseOption=='beans'){
                        int reqBeans = reqDiamonds*4;
                        if(user!.data!.beans!.toInt() < reqBeans){
                          showCustomSnackBar('Insufficient beans!', context, isToaster: true);
                        }else{
                          Provider.of<ShopWalletProvider>(context,listen: false).convertBeans(reqDiamonds, reqBeans);
                        }
                        Get.back();
                      }else{
                        Get.back();
                        Get.to(()=>const Wallet());
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24, top: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 9),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFF9933),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        selectedPurchaseOption=='beans'?"Convert Beans":"Wallet",
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}

Container viewUsersByIds(List<String>? list, {int popCount = 0, ScrollController? controller}){
  double baseWidth = 360;
  double a = Get.width / baseWidth;
  double b = a * 0.97;
  return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 18 * a, vertical: 8 * a),
      child:
      Consumer<UserDataProvider>(
        builder: (context, value, child) {
          if(list==null){
            return const Center(child: Text('Null!'));
          }if(list.isEmpty){
            return const Center(child: Text('NoData!'));
          }else {
            return ListView.separated(
              itemCount: list.length,
              controller: controller,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: Provider.of<UserDataProvider>(context,
                        listen: false)
                        .getUser(id: list[index]),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Text('none...');
                        case ConnectionState.active:
                          return const Text('active...');
                        case ConnectionState.waiting:
                          return Container(
                              width: double.infinity,
                              height: 70 * a,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                        Colors.black.withOpacity(0.06),
                                        width: 1)),
                              ),
                              padding: EdgeInsets.all(10 * a),
                              child: Row(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: const Color.fromARGB(
                                        248, 188, 187, 187),
                                    highlightColor: Colors.white,
                                    period: const Duration(seconds: 1),
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * a, 0 * a, 12 * a, 0 * a),
                                      width: 50 * a,
                                      height: 50 * a,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/profile.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Shimmer.fromColors(
                                        baseColor: const Color.fromARGB(
                                            248, 188, 187, 187),
                                        highlightColor: Colors.white,
                                        period: const Duration(seconds: 1),
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0 * a, 2 * a, 7 * a, 8 * a),
                                          height: 21 * a,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(8)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        case ConnectionState.done:
                          if (snapshot.hasError ||
                              snapshot.data?.status == 0 ||
                              snapshot.data?.data == null
                          ) {
                            return const SizedBox.shrink();
                          } else {
                            final user = snapshot.data!.data;

                            return Container(
                              width: double.infinity,
                              height: 80 * a,
                              padding: EdgeInsets.all(10 * a),
                              child: InkWell(
                                onTap: () {
                                  String myId =StorageService().getString(Constants.userId);
                                  for(popCount; popCount>0 ; popCount--) {
                                    Get.back();
                                  }
                                  if(user.userId == myId){
                                    Get.to(()=>const UserProfile());
                                  }else{
                                    Provider.of<UserDataProvider>(context,listen: false).addVisitor(list[index]);
                                    Get.to(()=> UserProfile(userData: user));
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 58 * a,
                                      height: 58 * a,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * a, 0 * a, 7 * a, 0 * a),
                                              width: 45 * a,
                                              height: 45 * a,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: user!.images!.isEmpty
                                                    ? const DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/profile.png'),
                                                )
                                                    : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      user.images!.first),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if(user.isActiveLive == true && user.name != 'error-10234')Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0 * a, 0 * a, 7 * a, 0 * a),
                                            width: 58 * a,
                                            height: 58 * a,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Theme.of(context).primaryColor,
                                                width: 2
                                              )
                                            ),
                                            alignment: Alignment.bottomCenter,
                                            child:
                                            Container(
                                              height: 15*a,
                                              width: 30*a,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                borderRadius: BorderRadius.circular(6)
                                              ),
                                              child: const FittedBox(
                                                child: Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: Text(
                                                      'LIVE',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          3 * a, 0 * a, 6 * a, 2 * a),
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width/2
                                      ),
                                      child: Text(
                                        user.name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 15 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.48 * a,
                                          color:
                                          const Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                    userLevelTag(
                                        user.level ?? 0, 17 * a)
                                  ],
                                ),
                              ),
                            );
                          }
                      }
                    });
              },
              separatorBuilder: (BuildContext context, int index) => Divider(height: 1,
                    color: Colors.black.withOpacity(0.06),
                    thickness: 1),
            );
          }
        },
      ),
    );
}
