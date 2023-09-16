import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class AgencyReward extends StatefulWidget {
  const AgencyReward({super.key});

  @override
  State<AgencyReward> createState() => _AgencyRewardState();
}

class _AgencyRewardState extends State<AgencyReward> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 30 * a,
        ),
        red_cont(7668),
        SizedBox(
          height: 30 * a,
        ),
        Padding(
          padding: EdgeInsets.only(left: 48 * a, right: 48 * a),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/agency/2.png'),
              Image.asset('assets/agency/1.png'),
              Image.asset('assets/agency/3.png'),
            ],
          ),
        ),
        SizedBox(
          height: 20 * a,
        ),
        red_cont(5643),
        SizedBox(
          height: 20 * a,
        ),
        Padding(
          padding: EdgeInsets.only(left: 48 * a, right: 48 * a),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/agency/4.png'),
              Image.asset('assets/agency/5.png'),
              Image.asset('assets/agency/6.png'),
            ],
          ),
        ),
        SizedBox(
          height: 20 * a,
        ),
        red_cont(7878),
        SizedBox(
          height: 20 * a,
        ),
        Padding(
          padding: EdgeInsets.only(left: 50 * a, right: 200 * a),
          child: Image.asset('assets/agency/6.png'),
        ),
      ]),
    );
  }

  Center red_cont(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Center(
      child: Container(
        width: 175 * a,
        height: 23 * a,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 0, 0, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                'Sum of Gifting $txt',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 12 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  color: Colors.white,
                ),
              ),
            ),
            Image.asset('assets/diamond.png'),
          ],
        ),
      ),
    );
  }
}
