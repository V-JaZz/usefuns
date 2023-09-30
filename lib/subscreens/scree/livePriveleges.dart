import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/screens/dashboard/me/me.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

class LivePrivleges extends StatefulWidget {
  final double trackHeight;

  const LivePrivleges({super.key, this.trackHeight = 60});

  @override
  State<LivePrivleges> createState() => _LivePrivlegesState();
}

class _LivePrivlegesState extends State<LivePrivleges> {
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
            Container(
              height: 190 * a,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffF88600),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30 * a,
                  ),
                  Image.asset('assets/bot.png'),
                  SizedBox(
                    height: 12 * a,
                  ),
                  Text(
                    'You need 50 EXP to upgrade to next Level',
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

                  Consumer<UserDataProvider>(
                    builder: (context, value, child) => SizedBox(
                      width: 270 * a,
                      child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 10,
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape: SliderComponentShape.noThumb,
                          ),
                          child: Slider(
                            min: 0,
                            max: 10,
                            value: value.userData?.data?.exp?.toDouble()??0,
                            onChanged: (double value) {},
                            inactiveColor: Colors.white,
                            activeColor: const Color(0xff884EFF),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 5 * a,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 40 * a),
                        child: Text(
                          '0(Lv.0)',
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
                          '50(Lv.1)',
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

                  // SliderTheme(
                  //   data: SliderTheme.of(context).copyWith(
                  //     trackHeight: widget.trackHeight,
                  //     overlayShape: SliderComponentShape.noOverlay,
                  //     thumbShape: SliderComponentShape.noThumb,
                  //     trackShape: RoundedRectSliderTrackShape(),
                  //   ),
                  //   child: Slider(
                  //     min: 0,
                  //     max: 100,
                  //     value: 0,
                  //     onChanged: (value) =>
                  //         setState(() => _volume = value as int),
                  //     inactiveColor: Colors.blue,
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20 * a, right: 20 * a, top: 40 * a),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'How to level Up',
                  style: SafeGoogleFont(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      'Poppins',
                      fontSize: 12 * a,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.w500,
                      height: 1 * b / a),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 45 * a, right: 45 * a, top: 29 * a),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/home.png'),
                      Text(
                        'Send Gift',
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.w500,
                            height: 1 * b / a),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/g2.png'),
                      Text(
                        'Shopping in\n      Store',
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.w500,
                            height: 1 * b / a),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/g3.png'),
                      Text(
                        'Add More',
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
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
            ),
            SizedBox(
              height: 20 * a,
            ),
            Text(
              'Every Time when You Spend Diamonds on Use funs\nYou will get EXP to level up(1 Diamonds=10 exp',
              textAlign: TextAlign.left,
              style: SafeGoogleFont(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  'Poppins',
                  fontSize: 12,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.w500,
                  height: 1 * b / a),
            ),
            SizedBox(
              height: 20 * a,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40 * a, right: 40 * a),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Privileges awards',
                  style: SafeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10 * a,
            ),
            txt('LV.1'),
            Padding(
              padding: EdgeInsets.only(left: 40 * a, right: 40 * a),
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
            SizedBox(
              height: 19 * a,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40 * a, right: 40 * a),
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
              padding:
                  EdgeInsets.only(left: 40 * a, right: 40 * a, top: 15 * a),
              child: Row(
                children: [
                  cont(),
                ],
              ),
            ),
            txt('LV.10'),
            Padding(
              padding:
                  EdgeInsets.only(left: 40 * a, right: 40 * a, top: 15 * a),
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
          Image.asset(
            'assets/diamond.png',
            height: 30 * a,
            width: 30 * a,
          ),
          Text(
            'Level Icon\nForever',
            textAlign: TextAlign.left,
            style: SafeGoogleFont(
              color: const Color.fromRGBO(255, 255, 255, 1),
              'Poppins',
              fontSize: 9 * a,
              /*percentages not used in flutter. defaulting to zero*/
              fontWeight: FontWeight.normal,
              height: 1 * b / a,
            ),
          )
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
          Image.asset(
            'assets/agency/rectangle.png',
            height: 30 * a,
            width: 30 * a,
          ),
          Text(
            'Level Icon\nForever',
            textAlign: TextAlign.left,
            style: SafeGoogleFont(
              color: const Color.fromRGBO(255, 255, 255, 1),
              'Poppins',
              fontSize: 9 * a,
              /*percentages not used in flutter. defaulting to zero*/
              fontWeight: FontWeight.normal,
              height: 1 * b / a,
            ),
          )
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
            color: const Color.fromRGBO(0, 0, 0, 1),
            'Poppins',
            fontSize: 12 * a,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
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
