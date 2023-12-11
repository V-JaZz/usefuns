import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/screens/dashboard/me/me.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

class LivePrivileges extends StatefulWidget {
  final double trackHeight;

  const LivePrivileges({super.key, this.trackHeight = 60});

  @override
  State<LivePrivileges> createState() => _LivePrivilegesState();
}

class _LivePrivilegesState extends State<LivePrivileges> {
  final _volume = 0;
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
                    Image.asset('assets/bot.png'),
                    SizedBox(
                      height: 12 * a,
                    ),
                    Text(
                      'You need ${(((value.userData?.data?.exp??0) + 999) ~/ 1000) * 1000 - (value.userData?.data?.exp??0)} EXP to upgrade to next Level',
                      textAlign: TextAlign.left,
                      style: SafeGoogleFont(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          'Poppins',
                          fontSize: 12 * a,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
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
                          value: ((value.userData?.data?.exp??0) % 1000) / 1000,
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
                            '${value.userData?.data?.exp} (Lv.${value.userData?.data?.level})',
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
                            '${(value.userData?.data?.level??0)+1}000 (Lv.${(value.userData?.data?.level??0)+1})',
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
            Text(
              'Every Time when You Spend Diamonds on Usefuns\nYou will get EXP to level up (1 Diamonds = 10 exp).',
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
            txt('LV.1'),
            Padding(
              padding: EdgeInsets.only(left: 30 * a, right: 30 * a),
              child: Row(
                children: [
                  red_cont(),
                ],
              ),
            ),
            SizedBox(
              height: 19 * a,
            ),
            txt('LV.4'),
            Padding(
              padding: EdgeInsets.only(left: 30 * a, right: 30 * a),
              child: Row(
                children: [
                  cont(),
                ],
              ),
            ),
            SizedBox(
              height: 19 * a,
            ),
            txt('LV.5'),
            Padding(
              padding: EdgeInsets.only(left: 30 * a, right: 30 * a),
              child: Row(
                children: [
                  cont(),
                ],
              ),
            ),
            SizedBox(
              height: 19 * a,
            ),
            txt('LV.10'),
            Padding(
              padding: EdgeInsets.only(left: 30 * a, right: 30 * a),
              child: Row(
                children: [
                  cont(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container red_cont() {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      width: 62 * a,
      height: 63 * a,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(66, 133, 244, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/icons/ic_diamond.png',
            height: 30 * a,
            width: 30 * a,
          ),
          const Spacer(),
          Text(
            'Level Icon\nForever',
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              color: const Color.fromRGBO(255, 255, 255, 1),
              'Poppins',
              fontSize: 9 * a,
              /*percentages not used in flutter. defaulting to zero*/
              fontWeight: FontWeight.normal,
              height: 1 * b / a,
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Container cont() {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      width: 62 * a,
      height: 63 * a,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment(6.123234262925839e-17, 1),
            end: Alignment(-1, 6.123234262925839e-17),
            colors: [
              Color.fromRGBO(226, 18, 118, 1),
              Color.fromRGBO(144, 6, 193, 0)
            ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/agency/rectangle.png',
            height: 30 * a,
            width: 30 * a,
          ),
          const Spacer(),
          Text(
            'Level Icon\nForever',
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              color: const Color.fromRGBO(255, 255, 255, 1),
              'Poppins',
              fontSize: 9 * a,
              /*percentages not used in flutter. defaulting to zero*/
              fontWeight: FontWeight.normal,
              height: 1 * b / a,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
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
