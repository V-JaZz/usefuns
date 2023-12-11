import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:shimmer/shimmer.dart';

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
      case > 79:
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

Widget roomListTile(
    {required String? image,
    required String title,
    required String? subTitle,
    required String active,
    required void Function() onTap}) {
  double baseWidth = 360;
  double a = Get.width / baseWidth;
  double b = a * 0.97;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(top: 8*a),
      decoration: BoxDecoration(
        color: const Color(0x119E26BC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        errorBuilder: (context, error, stackTrace) => Container(
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Text(error.toString(),
                              textAlign: TextAlign.center),
                        ),
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
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 6),
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

void rewardDialog(String path, String title, String info, void Function() onTap){
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
                  Image.asset(
                      path,
                    height: 136 * a,
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
                  InkWell(
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
}
