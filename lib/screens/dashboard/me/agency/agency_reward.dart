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
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 36 * a,
        ),
        redCont(7668),
        SizedBox(
          height: 30 * a,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/agency/2.png'),
            Image.asset('assets/agency/1.png'),
            Image.asset('assets/agency/3.png'),
          ],
        ),
        SizedBox(
          height: 36 * a,
        ),
        redCont(5643),
        SizedBox(
          height: 20 * a,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/agency/4.png'),
            Image.asset('assets/agency/5.png'),
            Image.asset('assets/agency/6.png'),
          ],
        ),
        SizedBox(
          height: 36 * a,
        ),
        redCont(7878),
        SizedBox(
          height: 20 * a,
        ),
        Image.asset('assets/agency/6.png'),
      ]),
    );
  }

  Center redCont(txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Center(
      child: Container(
        width: 175 * a,
        height: 23 * a,
        decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(4*a)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Sum of Gifting $txt',
                style: safeGoogleFont(
                  'Poppins',
                  fontSize: 12 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset('assets/icons/ic_diamond.png'),
            ),
          ],
        ),
      ),
    );
  }
}
