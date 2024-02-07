import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/screens/dashboard/me/me.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_widgets.dart';
import '../../../utils/helper.dart';

class LevelPrivileges extends StatefulWidget {
  final double trackHeight;

  const LevelPrivileges({super.key, this.trackHeight = 60});

  @override
  State<LevelPrivileges> createState() => _LevelPrivilegesState();
}

class _LevelPrivilegesState extends State<LevelPrivileges> {

  late final List<double> series;

  @override
  void initState() {
    series = generateSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
          automaticallyImplyLeading: true,
          title: Text(
            'Level Privileges',
            textAlign: TextAlign.left,
            style: SafeGoogleFont(
              color: const Color.fromRGBO(0, 0, 0, 1),
              'Poppins',
              fontSize: 17 * a,
              fontWeight: FontWeight.normal,
              height: 1 * b / a,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<UserDataProvider>(
              builder: (context, value, child) => Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 18*a,vertical: 27*a),
                decoration: const BoxDecoration(
                  color: Color(0xffF88600),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60 * a,
                      height: 60 * a,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image:value.userData!.data!.images!.isEmpty
                              ?const DecorationImage(
                            image: AssetImage('assets/profile.png'),
                          )
                              :DecorationImage(
                              image: NetworkImage(
                                  value.userData?.data?.images
                                      ?.first ??
                                      '')
                          )
                      ),
                    ),
                    SizedBox(
                      height: 12 * a,
                    ),
                    Text(
                      'You need ${(series[value.userData?.data?.level??0].ceil()-(value.userData?.data?.exp??0.0)).toInt()} EXP to upgrade Level',
                      textAlign: TextAlign.left,
                      style: SafeGoogleFont(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          'Poppins',
                          fontSize: 12 * a,
                          letterSpacing: 0 ,
                          fontWeight: FontWeight.normal,
                          height: 1 * b / a),
                    ),
                    SizedBox(
                      height: 15 * a,
                    ),
                    SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 10,
                          overlayShape: SliderComponentShape.noOverlay,
                          thumbShape: SliderComponentShape.noThumb,
                        ),
                        child: Slider(
                          min: 0,
                          max: 1,
                          value: setLevelProgressValue(value.userData?.data?.level??0,value.userData?.data?.exp??0),
                          onChanged: (double value) {},
                          inactiveColor: Colors.white,
                          activeColor: const Color(0xff884EFF),
                        )),
                    SizedBox(
                      height: 5 * a,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40 * a),
                          child: Text(
                            '${formatNumber(((value.userData?.data?.exp??0)-(series[(value.userData?.data?.level??0)-1])).toInt())} (Lv.${value.userData?.data?.level})',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Poppins',
                                fontSize: 12 * a,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1 * b / a),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 40 * a),
                          child: Text(
                            '${formatNumber((series[value.userData?.data?.level??0]-series[(value.userData?.data?.level??0)-1]).toInt())} (Lv.${(value.userData?.data?.level??0)+1})',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Poppins',
                                fontSize: 12 * a,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1 * b / a),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15 * a, right: 15 * a, top: 21 * a),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'How to level Up',
                  style: SafeGoogleFont(
                      color: Colors.black.withOpacity(0.8),
                      'Poppins',
                      fontSize: 14 * a,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.w500,
                      height: 1 * b / a),
                ),
              ),
            ),
            SizedBox(
              height: 21 * a,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/home.png',
                      height: 27*a,
                      width: 27*a,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5 * a,
                    ),
                    Text(
                      'Send Gift',
                      style: SafeGoogleFont(
                          color: Colors.black.withOpacity(0.8),
                          'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                          height: 1 * b / a),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20 * a,
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/g2.png',
                      height: 27*a,
                      width: 27*a,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5 * a,
                    ),
                    Text(
                      'Shop',
                      style: SafeGoogleFont(
                          color: Colors.black.withOpacity(0.8),
                          'Poppins',
                          fontSize: 12,
                          letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                          height: 1 * b / a),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20 * a,
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/g3.png',
                      height: 27*a,
                      width: 27*a,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5 * a,
                    ),
                    Text(
                      'Add More',
                      style: SafeGoogleFont(
                          color: Colors.black.withOpacity(0.8),
                          'Poppins',
                          fontSize: 12,
                          letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                          height: 1 * b / a),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15 * a,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Every Time when You Spend Diamonds on Usefuns\nYou will get EXP to level up (1 Diamonds = 1 exp).',
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                    color: Colors.black.withOpacity(0.8),
                    'Poppins',
                    fontSize: 12,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w500,
                    height: 1 * b / a),
              ),
            ),
            SizedBox(
              height: 27 * a,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20 * a, right: 20 * a),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Privileges awards',
                  style: SafeGoogleFont(
                      color: Colors.black.withOpacity(0.8),
                      'Poppins',
                      fontSize: 14 * a,
                      letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.w500,
                      height: 1 * b / a),
                ),
              ),
            ),
            SizedBox(
              height: 20 * a,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28*a),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userLevelTag(0, 28 * a,viewZero: true),
                  SizedBox(height: 14 * a),
                  userLevelTag(2, 28 * a,viewZero: true),
                  SizedBox(height: 14 * a),
                  userLevelTag(13, 28 * a,viewZero: true),
                  SizedBox(height: 14 * a),
                  userLevelTag(24, 28 * a,viewZero: true),
                  SizedBox(height: 14 * a),
                  userLevelTag(35, 28 * a,viewZero: true),
                  SizedBox(height: 14 * a),
                  userLevelTag(46, 28 * a,viewZero: true),
                  SizedBox(height: 14 * a),
                  userLevelTag(57, 28 * a,viewZero: true),
                  SizedBox(height: 14 * a),
                  userLevelTag(68, 28 * a,viewZero: true),
                  SizedBox(height: 14 * a),
                  userLevelTag(79, 28 * a,viewZero: true),
                  SizedBox(height: 28 * a),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column txt(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(left: 40 * a, right: 40 * a),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            txt,
            style: SafeGoogleFont(
              color: Colors.black.withOpacity(0.8),
              'Poppins',
              fontSize: 12 * a,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
    ]);
  }

  List<double> generateSeries() {
    List<double> series = [100];

    for (int i = 1; i < 99; i++) {
      double lastValue = series.last;
      double newValue = lastValue + (lastValue * 0.8725173730668903);
      series.add(newValue);
    }
    return series;
  }

  double setLevelProgressValue(int level, double xp) {
    if(level==0) return xp/series[level].toInt();
    return (xp-series[level-1])/(series[level]-series[level-1]).toInt();
  }
}
