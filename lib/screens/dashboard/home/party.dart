import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'room_active_detail.dart';

class Party extends StatefulWidget {
  const Party({super.key});

  @override
  State<Party> createState() => _PartyState();
}

class _PartyState extends State<Party> {
  final List<Map> roomList = [
    {
      "image": "assets/dummy/g1.png",
      "name": "kajol Sona",
      "time": "24/5 19:37"
    },
    {
      "image": "assets/dummy/p1.png",
      "name": "Happy birthday Rj Roy",
      "time": "24/5 18:30"
    },
    {
      "image": "assets/dummy/p2.png",
      "name": "Single Boy For sale",
      "time": "26/5 15:34"
    },
    {
      "image": "assets/dummy/p3.png",
      "name": "Rahul saini",
      "time": "30/5 19:00"
    },
    {
      "image": "assets/dummy/p4.png",
      "name": "Happy Birthday Party",
      "time": "1/6 20:37"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color(0x339E26BC),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 1,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 18 * a,
                ),
              ),
              Expanded(
                child: TabBar(
                  dividerColor: Colors.transparent,
                  labelColor: const Color(0xff000000),
                  unselectedLabelColor: const Color(0x99000000),
                  labelStyle: safeGoogleFont(
                    'Poppins',
                    fontSize: 12 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.48 * a,
                    color: const Color(0xff000000),
                  ),
                  unselectedLabelStyle: safeGoogleFont(
                    'Poppins',
                    fontSize: 12 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.48 * a,
                    color: const Color(0x99000000),
                  ),
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white),
                  indicatorPadding: EdgeInsets.symmetric(vertical: 12 * a),
                  splashBorderRadius:
                      const BorderRadius.all(Radius.circular(100)),
                  tabs: const [
                    Tab(
                      text: "Square",
                    ),
                    Tab(
                      text: "Subscribe",
                    ),
                    Tab(
                      text: "My Party",
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: 21 * a,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Coming Soon',
                        style: safeGoogleFont(
                          'Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'More',
                            style: safeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 14 * b,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20 * a),
                  for (Map club in roomList)
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.0 * a),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => RoomActiveDetail(
                                m: club,
                              ));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              club["image"],
                              fit: BoxFit.contain,
                              width: 80 * a,
                              height: 80 * a,
                            ),
                            SizedBox(width: 8 * a),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  club["name"],
                                  style: safeGoogleFont(
                                    'Poppins',
                                    fontSize: 12 * b,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.48 * a,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.access_time, size: 12 * a),
                                    SizedBox(width: 3 * a),
                                    Text(
                                      club["time"],
                                      overflow: TextOverflow.ellipsis,
                                      style: safeGoogleFont(
                                        'Poppins',
                                        fontSize: 9 * b,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * b / a,
                                        letterSpacing: 0.36 * a,
                                        color: const Color(0x99000000),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  width: 62 * a,
                                  height: 14 * a,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffff9933),
                                    borderRadius: BorderRadius.circular(12 * a),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'Subscribe',
                                      style: safeGoogleFont(
                                        'Poppins',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.36 * a,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 20 * a),
                  Container(
                    height: 26 * a,
                    width: 108 * a,
                    decoration: BoxDecoration(
                      color: const Color(0xff9e26bc),
                      borderRadius: BorderRadius.circular(9 * a),
                    ),
                    child: Center(
                      child: Text(
                        '+ Create',
                        style: safeGoogleFont(
                          'Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: Get.width / 6,
              ),
              Image.asset(
                "assets/icons/ic_empty.png",
                width: Get.width / 3,
                height: Get.width / 3,
              ),
              Text(
                'No Data',
                style: safeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  letterSpacing: 0.64 * a,
                  color: const Color(0xff000000),
                ),
              ),
              SizedBox(height: 45 * a),
              Container(
                height: 26 * a,
                width: 108 * a,
                decoration: BoxDecoration(
                  color: const Color(0xff9e26bc),
                  borderRadius: BorderRadius.circular(9 * a),
                ),
                child: Center(
                  child: Text(
                    '+ Create',
                    style: safeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.black,
                  indicatorWeight: 1.3,
                  labelColor: const Color(0xff000000),
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: const Color(0x99000000),
                  labelStyle: safeGoogleFont(
                    'Poppins',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.96 * a,
                    color: const Color(0xff000000),
                  ),
                  unselectedLabelStyle: safeGoogleFont(
                    'Poppins',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.96 * a,
                    color: const Color(0x99000000),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30 * a),
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      text: "Pass",
                    ),
                    Tab(
                      text: "Auditing",
                    ),
                    Tab(
                      text: "Notpass",
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    Column(
                      children: [
                        SizedBox(
                          height: Get.width / 6,
                        ),
                        Image.asset(
                          "assets/icons/ic_empty.png",
                          width: Get.width / 3,
                          height: Get.width / 3,
                        ),
                        Text(
                          'No Data',
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 16 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.64 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                        SizedBox(height: 45 * a),
                        Container(
                          height: 26 * a,
                          width: 108 * a,
                          decoration: BoxDecoration(
                            color: const Color(0xff9e26bc),
                            borderRadius: BorderRadius.circular(9 * a),
                          ),
                          child: Center(
                            child: Text(
                              '+ Create',
                              style: safeGoogleFont(
                                'Poppins',
                                fontSize: 12 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                letterSpacing: 0.48 * a,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: Get.width / 6,
                        ),
                        Image.asset(
                          "assets/icons/ic_empty.png",
                          width: Get.width / 3,
                          height: Get.width / 3,
                        ),
                        Text(
                          'No Data',
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 16 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.64 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                        SizedBox(height: 45 * a),
                        Container(
                          height: 26 * a,
                          width: 108 * a,
                          decoration: BoxDecoration(
                            color: const Color(0xff9e26bc),
                            borderRadius: BorderRadius.circular(9 * a),
                          ),
                          child: Center(
                            child: Text(
                              '+ Create',
                              style: safeGoogleFont(
                                'Poppins',
                                fontSize: 12 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                letterSpacing: 0.48 * a,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: Get.width / 6,
                        ),
                        Image.asset(
                          "assets/icons/ic_empty.png",
                          width: Get.width / 3,
                          height: Get.width / 3,
                        ),
                        Text(
                          'No Data',
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 16 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.64 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                        SizedBox(height: 45 * a),
                        Container(
                          height: 26 * a,
                          width: 108 * a,
                          decoration: BoxDecoration(
                            color: const Color(0xff9e26bc),
                            borderRadius: BorderRadius.circular(9 * a),
                          ),
                          child: Center(
                            child: Text(
                              '+ Create',
                              style: safeGoogleFont(
                                'Poppins',
                                fontSize: 12 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                letterSpacing: 0.48 * a,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
