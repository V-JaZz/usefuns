import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:live_app/utils/utils_assets.dart';

class Treasures extends StatefulWidget {
  const Treasures({Key? key}) : super(key: key);

  @override
  State<Treasures> createState() => _TreasuresState();
}

class _TreasuresState extends State<Treasures> {
  List<Map> boxes = [
    {
      'image': 'assets/room_icons/t1.png',
      'prize': [
        {
          'image': 'assets/treas/bike.png',
          'name': 'Bike',
          'charge': '325',
          'chng': '50',
        },
        {
          'image': 'assets/gifts/frame.png',
          'name': 'Frame',
          'charge': '325',
          'chng': '50',
        },
        {
          'image': 'assets/gifts/vip2.png',
          'charge': '2000',
          'chng': '50',
        },
      ],
    },
    {
      'image': 'assets/room_icons/t2.png',
      'prize': [
        {
          'image': 'assets/treas/car.png',
          'name': 'Car',
          'charge': '325',
          'chng': '50',
        },
        {
          'image': 'assets/treas/frame2.png',
          'name': 'Frame',
          'charge': '399',
          'chng': '50',
        },
        {
          'image': 'assets/gifts/vip2.png',
          'name': 'Rose',
          'charge': '99',
        },
      ],
    },
    {
      'image': 'assets/room_icons/t3.png',
      'prize': [
        {
          'image': 'assets/treas/car2.png',
          'name': 'Car',
          'charge': '325',
          'chng': '50',
        },
        {
          'image': 'assets/treas/frame3.png',
          'name': 'Frame',
          'charge': '399',
          'chng': '50',
        },
        {
          'image': 'assets/gifts/vip1.png',
          'charge': '2000',
          'chng': '50',
        },
      ],
    },
    {
      'image': 'assets/room_icons/t4.png',
      'prize': [
        {
          'image': 'assets/treas/car3.png',
          'name': 'Car',
          'charge': '325',
          'chng': '50',
        },
        {
          'image': 'assets/treas/frame4.png',
          'name': 'Frame',
          'charge': '399',
          'chng': '50',
        },
        {
          'image': 'assets/gifts/vip1.png',
          'charge': '2000',
        },
      ],
    },
    {
      'image': 'assets/room_icons/t5.png',
      'prize': [
        {
          'image': 'assets/treas/car4.png',
          'name': 'Car',
          'charge': '325',
          'chng': '50',
        },
        {
          'image': 'assets/treas/frame2.png',
          'name': 'Panda',
          'charge': '325',
          'chng': '50',
        },
        {
          'image': 'assets/gifts/vip3.png',
          'charge': '2000',
          'chng': '50',
        },
      ],
    }
  ];
  int selectedBox = 0;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      height: 600 * a,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8 * a),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 46 * a,
                  height: 18 * a,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6 * a),
                    color: const Color(0x66000000),
                  ),
                  child: Center(
                    child: Text(
                      'Prize',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 9 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.36 * a,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Treasure Box',
                  style: SafeGoogleFont(
                    'Poppins',
                    fontSize: 18 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.72 * a,
                    color: const Color(0xffffffff),
                  ),
                ),
                Icon(CupertinoIcons.question_circle,
                    color: Colors.white, size: 18 * a)
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 68 * a,
              width: 95 * a * 5,
              child: Row(
                children: List.generate(
                  boxes.length,
                  (i) => SizedBox(
                    height: 68 * a,
                    width: 95 * a,
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              if (selectedBox == i)
                                Positioned(
                                    left: 5 * a,
                                    top: 37 * a,
                                    child: Image.asset(
                                      'assets/room_icons/red_shadow.png',
                                      width: 90 * a,
                                      height: 15 * a,
                                    )),
                              Positioned(
                                  left: 21 * a,
                                  top: 0 * a,
                                  child: InkWell(
                                    onTap: () {
                                      selectedBox = i;
                                      setState(() {});
                                    },
                                    child: Image.asset(
                                      boxes[i]['image'],
                                      width: 60 * a,
                                      height: 49 * a,
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        if (selectedBox == i)
                          Container(
                            width: 37 * a,
                            height: 14 * a,
                            margin: EdgeInsets.only(top: 2 * a, left: 10 * a),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9 * a),
                              color: const Color(0xff411fba),
                            ),
                            child: Center(
                              child: Text(
                                'Lv.${i + 1}',
                                style: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 9 * b,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * b / a,
                                  letterSpacing: 0.36 * a,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8 * a),
            child: Text(
              'Send gifts to open the treasure box',
              style: SafeGoogleFont(
                'Poppins',
                fontSize: 12 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.36 * a,
                color: const Color(0xffffffff),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0 * a),
            child: Text(
              'Prize',
              style: SafeGoogleFont(
                'Poppins',
                fontSize: 12 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.36 * a,
                color: const Color(0xffffffff),
              ),
            ),
          ),

          Row(
            children: [
              SizedBox(
                width: 10 * a,
              ),
              Column(
                children: List.generate(
                  1,
                  (index) => iconTextRow(
                      boxes[selectedBox]['prize'][index]['image'],
                      boxes[selectedBox]['prize'][index]['name']),
                ),
              ),
              SizedBox(
                width: 10 * a,
              ),
              Column(
                children: List.generate(
                  1,
                  (index) => iconTextRow(
                      boxes[selectedBox]['prize'][1]['image'],
                      boxes[selectedBox]['prize'][1]['name']),
                ),
              ),
              SizedBox(
                width: 10 * a,
              ),
              Column(
                children: List.generate(
                  1,
                  (index) => iconicc('20', '30', '40'),
                ),
              ),
              SizedBox(
                width: 10 * a,
              ),
              Column(
                children: List.generate(
                  1,
                  (index) => iconTexRow(
                    boxes[selectedBox]['prize'][2]['image'],
                  ),
                ),
              ),
            ],
          ),
          // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //   iconTextRow(100, 'assets/treas/car.png', 'Bike'),
          //   iconTextRow(50, 'assets/2.png', 'Frame'),
          //   iconTextRow(70, '', 'no'),
          //   iconTextRow(80, 'assets/abc.png', ''),
          // ]),
        ],
      ),
    );
  }

  iconTextRow(String p, String txt) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * a, horizontal: 3 * a),
      color: const Color(0x66411EB9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120 * a,
            width: 70 * a,
            child: Column(
              children: [
                Container(
                  width: 92 * a,
                  height: 64.348836898803711 * a,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(p), fit: BoxFit.fitWidth),
                  ),
                ),
                SizedBox(
                  height: 8 * a,
                ),
                Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: SafeGoogleFont(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      'Roboto',
                      fontSize: 16 * a,
                      fontWeight: FontWeight.normal,
                      height: 1.5 * b / a),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 11 * a,
                        height: 6.523255825042725 * a,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/diamond.png'),
                              fit: BoxFit.fitWidth),
                        )),
                    Text(
                      '2000',
                      textAlign: TextAlign.left,
                      style: SafeGoogleFont(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          'Roboto',
                          fontSize: 16 * a,
                          fontWeight: FontWeight.normal,
                          height: 1.5 * b / a),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  iconTexRow(String p) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * a, horizontal: 3 * a),
      color: const Color(0x66411EB9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120 * a,
            width: 70 * a,
            child: Column(
              children: [
                Container(
                  width: 92 * a,
                  height: 74.348836898803711 * a,
                  decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage(p), fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  height: 20 * a,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 11 * a,
                        height: 6.523255825042725 * a,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/diamond.png'),
                              fit: BoxFit.fitWidth),
                        )),
                    Text(
                      '2000',
                      textAlign: TextAlign.left,
                      style: SafeGoogleFont(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          'Roboto',
                          fontSize: 16 * a,
                          fontWeight: FontWeight.normal,
                          height: 1.5 * b / a),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  iconicc(String t1, String t2, String t3) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            color: const Color(0x66411EB9),
            height: 40 * a,
            width: 70 * a,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 11 * a,
                    height: 6.523255825042725 * a,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/diamond.png'),
                          fit: BoxFit.fitWidth),
                    )),
                Text(
                  t1,
                  textAlign: TextAlign.left,
                  style: SafeGoogleFont(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      'Roboto',
                      fontSize: 16 * a,
                      fontWeight: FontWeight.normal,
                      height: 1.5 * b / a),
                ),
              ],
            )),
        SizedBox(
          height: 10 * a,
        ),
        Container(
          color: const Color(0x66411EB9),
          height: 40 * a,
          width: 70 * a,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 11 * a,
                  height: 6.523255825042725 * a,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/diamond.png'),
                        fit: BoxFit.fitWidth),
                  )),
              Text(
                t2,
                textAlign: TextAlign.left,
                style: SafeGoogleFont(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    'Roboto',
                    fontSize: 16 * a,
                    fontWeight: FontWeight.normal,
                    height: 1.5 * b / a),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10 * a,
        ),
        Container(
            color: const Color(0x66411EB9),
            height: 40 * a,
            width: 70 * a,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 11 * a,
                    height: 6.523255825042725 * a,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/diamond.png'),
                          fit: BoxFit.fitWidth),
                    )),
                Text(
                  t3,
                  textAlign: TextAlign.left,
                  style: SafeGoogleFont(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      'Roboto',
                      fontSize: 16 * a,
                      fontWeight: FontWeight.normal,
                      height: 1.5 * b / a),
                ),
              ],
            ))
      ],
    );
  }
}
