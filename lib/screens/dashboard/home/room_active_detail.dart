import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:live_app/utils/utils_assets.dart';

class RoomActiveDetail extends StatelessWidget {
  final Map m;
  RoomActiveDetail({super.key, required this.m});

  final List<Map> subscribedList = [
    {
      "dp": "assets/dummy/g1.png",
      "name": "Liza",
      "time": "8 minutes ago",
    },
    {
      "dp": "assets/dummy/g2.png",
      "name": "Girl Friend.Com",
      "time": "15 minutes ago",
    },
    {
      "dp": "assets/dummy/b1.png",
      "name": "Ariful islam",
      "time": "21 minutes ago",
    },
    {
      "dp": "assets/dummy/b2.png",
      "name": "Simple Boy",
      "time": "44 minutes ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
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
                child: Text('Room Active Detail',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 20 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.8 * a,
                      color: const Color(0xff000000),
                    ))),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 264 * a,
              child: Stack(
                children: [
                  Positioned(
                    left: 0 * a,
                    top: 0 * a,
                    child: Align(
                      child: SizedBox(
                        width: 360 * a,
                        height: 258 * a,
                        child: Image.asset(
                          m["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 23 * a,
                    bottom: 18 * a,
                    child: SizedBox(
                      width: 127 * a,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m["name"],
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                          SizedBox(height: 2 * a),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 12 * a,
                              ),
                              SizedBox(width: 6 * a),
                              Text(
                                m["time"],
                                style: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 9 * b,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * b / a,
                                  letterSpacing: 0.36 * a,
                                  color: const Color(0x99000000),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 11 * a),
                          Text(
                            'Room ID:354356765',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(21 * a, 0 * a, 21 * a, 12 * a),
              width: double.infinity,
              height: 18 * a,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subscribed Record',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 3 * a, 0 * a),
                        width: 9 * a,
                        height: 9 * a,
                        child: Icon(
                          Icons.people,
                          size: 12 * a,
                        ),
                      ),
                      SizedBox(
                        width: 3 * a,
                      ),
                      Text(
                        '4',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 9 * b,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.36 * a,
                          color: const Color(0x66000000),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(21 * a, 0 * a, 21 * a, 12 * a),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  subscribedList.length,
                  (i) {
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        foregroundImage: AssetImage(
                          subscribedList[i]['dp'],
                        ),
                        radius: 15 * a,
                      ),
                      title: Text(
                        subscribedList[i]['name'],
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                      trailing: Text(
                        subscribedList[i]['time'],
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 9 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.36 * a,
                          color: const Color(0x66000000),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 30 * a, 0 * a),
              width: double.infinity,
              height: 23 * a,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 7 * a, 0 * a),
                    width: 88 * a,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff9e26bc),
                      borderRadius: BorderRadius.circular(12 * a),
                    ),
                    child: Center(
                      child: Text(
                        'Join',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 88 * a,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffffe500),
                      borderRadius: BorderRadius.circular(12 * a),
                    ),
                    child: Center(
                      child: Text(
                        'Subscribe',
                        style: SafeGoogleFont(
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
          ],
        ),
      ),
    );
  }
}
