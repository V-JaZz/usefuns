import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class Relation extends StatefulWidget {
  const Relation({super.key});

  @override
  State<Relation> createState() => _RelationState();
}

class _RelationState extends State<Relation> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0 * a),
        child: SizedBox(
          height: 550,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            children: [
              images('assets/soccer.png', 'Soccer'),
              images('assets/frame1.png', 'Frame'),
            ],
          ),
        ),
      ),
    );
  }

  Column images(img, txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Column(
      children: [
        Image.asset(img),
        Text(txt),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/diamond.png',
            ),
            Text(
              '1319/1 Days',
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
      ],
    );
  }
}
