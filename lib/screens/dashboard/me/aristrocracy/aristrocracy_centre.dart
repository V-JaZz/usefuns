import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';


class Viscount extends StatefulWidget {
  const Viscount({super.key});

  @override
  State<Viscount> createState() => _ViscountState();
}

class _ViscountState extends State<Viscount> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/abc3.png'),
              Column(
                children: [
                  bonuses('20'),
                  inrdays('2200', '30'),
                ],
              ),
            ],
          ),
          Container(
            width: 133 * a,
            height: 35 * b,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9*a),
                topRight: Radius.circular(9*a),
                bottomLeft: Radius.circular(9*a),
                bottomRight: Radius.circular(9*a),
              ),
              color: const Color.fromRGBO(255, 229, 0, 1),
            ),
            child: Center(
              child: Text(
                'Active',
                style: safeGoogleFont(
                  'Poppins',
                  fontSize: 22 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  color: const Color(0xff000000),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(27 * a, 40 * a, 0 * a, 4 * a),
            child: Column(
              children: [
                SizedBox(
                  height: 550 * a,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: [
                      imagesColumn('assets/aristro.png', 'Aristocracy Ba..',
                          'Aristocracy badge on\n      the room list'),
                      imagesColumn('assets/home.png', 'Aristocracy Ro',
                          'Aristocracy badge on\n      the room list'),
                      imagesColumn('assets/visc1.png', 'Aristocracy Gifts.',
                          'Exclusive Gifts only \n    Sended by aristocracy'),
                      imagesColumn('assets/visc2.png', 'Aristocracy Ro',
                          'Aristocracy badge on\n      the room list'),
                      imagesColumn('assets/visc3.png', 'Aristocracy Ro',
                          'Aristocracy badge on\n      the room list'),
                      imagesColumn('assets/visc4.png', 'Aristocracy Ro',
                          'Aristocracy badge on\n      the room list'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //tabbar

          // //active button
          // privelege('5', '15'),
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 50, right: 50),
          //   child: Column(children: [
          //     aristrorow(
          //       'assets/aristro.png',
          //       'assets/aristro.png',
          //       'Aristocracy Ro..',
          //       'Aristocracy Ro..',
          //       'Aristocracy badge on\n      the room list',
          //       'Aristocracy badge on\n      the room list',
          //     ),
          //   ]),
          // )
        ]),
      ),
    );
  }

  Column imagesColumn(img, text1, text2) {
    return Column(
      children: [
        Image.asset(
          img,
        ),
        Text(
          text1,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          text2,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Text privelege(text, txt) => Text(
        "Privileges($text/$txt)",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      );

  Text inrdays(rupee, day) => Text(
        '$rupee INR/$day DAYS',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      );

  Text bonuses(text) => Text(
        'Bonus $text Diamonds',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      );
}
