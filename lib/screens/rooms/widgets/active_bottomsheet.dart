import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class ViewActiveBottomSheet extends StatefulWidget {
  const ViewActiveBottomSheet({Key? key}) : super(key: key);

  @override
  State<ViewActiveBottomSheet> createState() => _ViewActiveBottomSheetState();
}

class _ViewActiveBottomSheetState extends State<ViewActiveBottomSheet> {
  final List<Map> list = [
    {"image": 'assets/dummy/b1.png', "name": "Simple Boy"},
    {"image": 'assets/dummy/g2.png', "name": "FRIENDSHIP CLUB"},
    {"image": 'assets/dummy/g3.png', "name": "Gf Bf Dating "},
    {"image": 'assets/dummy/g4.png', "name": "Nisha Hosting"},
    {"image": 'assets/dummy/g1.png', "name": "Dimple Ayesha."},
  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double a = MediaQuery.of(context).size.width / baseWidth;
    double b = a * 0.97;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 12 * a,
          ),
          SizedBox(
            width: 125 * a,
            height: 24 * a,
            child: Text(
              'Room Member',
              style: SafeGoogleFont(
                'Poppins',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.64 * a,
                color: const Color(0xff000000),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: Get.height / 3,
            padding: EdgeInsets.all(27 * a),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30 * a,
                  margin: EdgeInsets.only(bottom: 12 * a),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 7 * a, 0 * a),
                        width: 36 * a,
                        height: 36 * a,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/dummy/b2.png'),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.fromLTRB(5 * a, 0 * a, 6 * a, 0 * a),
                        height: 14 * a,
                        decoration: const BoxDecoration(
                          color: Color(0xff9E26BC),
                        ),
                        child: Text(
                          'New',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 11 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.36 * a,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(6 * a, 0 * a, 6 * a, 2 * a),
                        child: Text(
                          '981476',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 14 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.48 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.fromLTRB(5 * a, 0 * a, 6 * a, 0 * a),
                        height: 15 * a,
                        decoration: const BoxDecoration(
                          color: Color(0xffFF9933),
                        ),
                        child: Text(
                          'Owner',
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 11 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.36 * a,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 30 * a,
                      margin: EdgeInsets.only(bottom: 12 * a),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * a, 0 * a, 7 * a, 0 * a),
                                  width: 36 * a,
                                  height: 36 * a,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(list[index]['image']),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      3 * a, 0 * a, 6 * a, 2 * a),
                                  child: Text(
                                    list[index]['name'],
                                    style: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 14 * b,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * b / a,
                                      letterSpacing: 0.48 * a,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      5 * a, 0 * a, 6 * a, 0 * a),
                                  height: 15 * a,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff4285f4),
                                    borderRadius: BorderRadius.circular(9 * a),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0 * a, 0 * a, 4 * a, 1 * a),
                                        width: 11 * a,
                                        height: 11 * a,
                                        child: Image.asset(
                                          'assets/room_icons/blue_diamond.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        'L.v 5',
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 11 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.36 * a,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                4 * a, 6 * a, 0 * a, 10 * a),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.person_add,
                                    color: Colors.grey, size: 18 * a),
                                SizedBox(width: 12 * a),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          shape: ShapeBorder.lerp(
                                              InputBorder.none,
                                              InputBorder.none,
                                              0),
                                          child: Container(
                                            width: 280 * a,
                                            padding: EdgeInsets.all(21 * a),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        7 * a)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Confirm to Kick Simple Boy Out Of the Room?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14 * a),
                                                ),
                                                SizedBox(height: 9 * a),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .radio_button_off_rounded,
                                                      size: 16 * a,
                                                    ),
                                                    SizedBox(width: 9 * a),
                                                    Expanded(
                                                      child: Text(
                                                        "Permanently Block him and forbid him from entering Your room",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0x99000000),
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 14 * a),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 24 * a),
                                                Container(
                                                  height: 20 * a,
                                                  width: 140 * a,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFFF9933),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12 * a)),
                                                  child: Center(
                                                    child: Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 14 * a),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 12 * a),
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0x99000000),
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 14 * a),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.exit_to_app,
                                      color: Colors.grey, size: 18 * a),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
