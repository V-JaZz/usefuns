import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/me/profile/badges.dart';
import 'package:live_app/utils/utils_assets.dart';

class HonourTabView extends StatefulWidget {
  const HonourTabView({super.key});

  @override
  State<HonourTabView> createState() => _HonourTabViewState();
}

class _HonourTabViewState extends State<HonourTabView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '   Aristocracy',
                style: SafeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12 * a,
                    fontWeight: FontWeight.w500,
                    height: 1 * b / a),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 30 * a, right: 30 * a, bottom: 30 * a, top: 10 * a),
              child: Container(
                height: 64 * a,
                width: 310 * a,
                decoration: const BoxDecoration(color: Colors.black),
                child: ListTile(
                  leading: Container(
                      width: 40 * a,
                      height: 37 * a,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/homepage.png",
                            ),
                            fit: BoxFit.fitWidth),
                      )),
                  trailing: Container(
                    width: 80 * a,
                    height: 20 * a,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12 * a),
                        topRight: Radius.circular(12 * a),
                        bottomLeft: Radius.circular(12 * a),
                        bottomRight: Radius.circular(12 * a),
                      ),
                      color: const Color.fromRGBO(255, 153, 51, 1),
                    ),
                    child: Center(
                      child: Text(
                        '7 Privileges',
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12 * a,
                            fontWeight: FontWeight.normal,
                            height: 1 * a),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Badge',
                    style: SafeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.w500,
                        height: 1 * a),
                  ),
                  Row(
                    children: [
                      Text(
                        'More',
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12 * a,
                            fontWeight: FontWeight.w500,
                            height: 1 * a),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => const BadgePage());
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset('assets/2.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vehicle',
                    style: SafeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.w500,
                        height: 1 * a),
                  ),
                  Row(
                    children: [
                      Text(
                        'More',
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12 * a,
                            fontWeight: FontWeight.w500,
                            height: 1 * a),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14 * a,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset('assets/3.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Frame'),
                  Row(
                    children: [
                      Text(
                        'More',
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12 * a,
                            fontWeight: FontWeight.w500,
                            height: 1 * a),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                children: [
                  Image.asset('assets/4.png'),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset('assets/5.png'),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset('assets/6.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gift',
                    style: SafeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.w500,
                        height: 1 * a),
                  ),
                  Row(
                    children: [
                      Text(
                        'More',
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 12 * a,
                            fontWeight: FontWeight.w500,
                            height: 1 * a),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                children: [
                  Image.asset('assets/4.png'),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset('assets/5.png'),
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset('assets/6.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
