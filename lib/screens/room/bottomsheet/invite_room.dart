import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils_assets.dart';

class InviteRoomBottomSheet extends StatelessWidget {
  InviteRoomBottomSheet({super.key});

  final List<Map> roomList = [
    {
      "image": "assets/dummy/g1.png",
      "name": "DREAM GIRLS",
      "about": "Sabhi New Users Ka swagat",
      "rank": "16",
    },
    {
      "image": "assets/dummy/g2.png",
      "name": "Girl Friend.Com",
      "about": "Sabhi New Users Ka swagat",
      "rank": "12",
    },
    {
      "image": "assets/dummy/g3.png",
      "name": "FRIENDSHIP CLUB",
      "about": "Sabhi New Users Ka swagat",
      "rank": "10",
    },
    {
      "image": "assets/dummy/g4.png",
      "name": "Gf Bf Dating Eoom",
      "about": "Sabhi New Users Ka swagat",
      "rank": "24",
    },
    {
      "image": "assets/dummy/g5.png",
      "name": "Nisha Hosting....",
      "about": "Sabhi New Users Ka swagat",
      "rank": "40",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SizedBox(
      width: double.infinity,
      height: 700 * a,
      child: Column(
        children: [
          SizedBox(height: 10 * a),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.arrow_back_rounded),
              Center(
                child: Text(
                  'Invite PK                                  ',
                  textAlign: TextAlign.left,
                  style: SafeGoogleFont(
                      color: const Color.fromRGBO(6, 6, 6, 1),
                      'Lato',
                      fontSize: 22 * a,
                      letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.w700,
                      height: 1 * a),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10 * a),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffd9d9d9),
                borderRadius: BorderRadius.circular(20 * a),
              ),
              height: 40 * a,
              child: const TextField(
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: '   Search Room',
                ),
              ),
            ),
          ),
          SizedBox(height: 30 * a),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              '   Recommended Rooms',
              textAlign: TextAlign.left,
              style: SafeGoogleFont(
                  color: const Color.fromRGBO(6, 6, 6, 1),
                  'Lato',
                  fontSize: 20 * a,
                  letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.w700,
                  height: 1 * a),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 18 * a, vertical: 8 * a),
              child: Column(
                children: [
                  for (Map club in roomList.take(3))
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ListTile(
                                leading: Image.asset(
                                  club["image"],
                                  fit: BoxFit.contain,
                                  width: 64 * a,
                                  height: 64 * a,
                                ),
                                title: Text(
                                  club["name"],
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 16 * b,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.64 * a,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                subtitle: Text(
                                  club["about"],
                                  overflow: TextOverflow.ellipsis,
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 12 * b,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.48 * a,
                                    color: const Color(0x99000000),
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 25 * a,
                                    width: 50 * a,
                                    decoration: const BoxDecoration(
                                      color: Colors.orange,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Invite',
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 12 * b,
                                          fontWeight: FontWeight.w800,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.48 * a,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ]),
                ],
              )),
        ],
      ),
    );
  }
}
