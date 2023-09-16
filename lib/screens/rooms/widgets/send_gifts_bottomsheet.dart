import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/subscreens/scree/livePriveleges.dart';

import 'package:live_app/utils/utils_assets.dart';

class SendGifts extends StatefulWidget {
  const SendGifts({Key? key}) : super(key: key);

  @override
  State<SendGifts> createState() => _SendGiftsState();
}

class _SendGiftsState extends State<SendGifts> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      color: const Color(0xCC352D2D),
      child: DefaultTabController(
        length: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(width: 18 * a),
                Image.asset('assets/icons/ic_diamond.png',
                    height: 12 * a, width: 12 * a),
                SizedBox(width: 6 * a),
                Text(
                  '7',
                  style: SafeGoogleFont(
                    'Roboto',
                    fontSize: 16 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.171875 * b / a,
                    color: const Color(0xffffffff),
                  ),
                ),
                Expanded(
                  child: TabBar(
                    indicatorColor: const Color(0xCC352D2D),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.white,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: const Color(0xCCFFFFFF),
                    labelStyle: SafeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.96 * a,
                    ),
                    unselectedLabelStyle: SafeGoogleFont(
                      'Poppins',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w300,
                      height: 1.5 * b / a,
                      letterSpacing: 0.96 * a,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30 * a),
                    labelPadding: EdgeInsets.zero,
                    tabs: const [
                      Tab(
                        text: "Gifts",
                      ),
                      Tab(
                        text: "Lucky   ",
                      ),
                      Tab(
                        text: "Surprise     ",
                      ),
                      Tab(
                        text: "Baggage",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Get.to(() => const LivePrivleges());
              },
              child: Container(
                height: 20 * a,
                width: 70 * a,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13 * a),
                    color: Colors.orange),
                child: Center(
                    child: Text(
                  'Privileges',
                  style: TextStyle(fontSize: 10),
                )),
              ),
            ),
            SizedBox(
              height: 300 * a,
              width: double.infinity,
              child: TabBarView(children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
                  child: Wrap(
                    children: [
                      iconTextRow('Rose', 'assets/gifts/rose.png', '99'),
                      iconTextRow('Finger heart',
                          'assets/gifts/finger_heart.png', '134'),
                      iconTextRow(
                          'India Heart', 'assets/gifts/ind_heart.png', '399'),
                      iconTextRow('Lion', 'assets/gifts/lion.png', '23'),
                      iconTextRow('Perfume', 'assets/gifts/perfume.png', '134'),
                      iconTextRow('Heart', 'assets/gifts/heart.png', '399'),
                      iconTextRow('Mic', 'assets/gifts/mic.png', '125'),
                      iconTextRow('Fire', 'assets/gifts/fire.png', '324'),
                      iconTextRow('Cake', 'assets/gifts/cake.png', '399'),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
                  child: Wrap(
                    children: [
                      iconTextRow('Rose', 'assets/gifts/rose.png', '99'),
                      iconTextRow(
                          'Lucky Cake', 'assets/gifts/lucky_cake.png', '134'),
                      iconTextRow('Lucky Flower',
                          'assets/gifts/lucky_flowers.png', '399'),
                      iconTextRow(
                          'Lucky Bag', 'assets/gifts/lucky_bag.png', '23'),
                      iconTextRow('Lucky Sports car',
                          'assets/gifts/perfume.png', '134'),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
                  child: Wrap(
                    children: [
                      iconTextRow(
                          'Luxury Box', 'assets/gifts/luxury_box.png', '99'),
                      iconTextRow(
                          'Supreme Box', 'assets/gifts/supreme_box.png', '134'),
                      iconTextRow(
                          'Basic Box', 'assets/gifts/basic_box.png', '399'),
                      iconTextRow(
                          'Lucky Box', 'assets/gifts/lucky_box.png', '23'),
                      iconTextRow(
                          'Super Box', 'assets/gifts/super_box.png', '134'),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
                  child: Wrap(
                    children: [
                      iconTextRow(
                          'Rose Flower', 'assets/gifts/rose2.png', '99'),
                    ],
                  ),
                ),
              ]),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 36 * a, right: 36 * a, bottom: 18 * a),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: SafeGoogleFont(
                        'DM Sans',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w700,
                        height: 1.1666666667 * b / a,
                        color: const Color(0xffffffff),
                      ),
                      children: [
                        const TextSpan(
                          text: 'To : ',
                        ),
                        TextSpan(
                          text: 'pick user to see',
                          style: SafeGoogleFont(
                            'DM Sans',
                            fontSize: 12 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.1666666667 * b / a,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 127.79 * a,
                    height: 28.56 * a,
                    decoration: BoxDecoration(
                      color: const Color(0xff1877f2),
                      borderRadius: BorderRadius.circular(3 * a),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 63 * a,
                          margin: EdgeInsets.all(1 * a),
                          padding: EdgeInsets.symmetric(horizontal: 6 * a),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff040106),
                            borderRadius: BorderRadius.circular(3 * a),
                          ),
                          child: Center(
                            child: TextField(
                              decoration: textFieldDecoration(),
                              maxLength: 5,
                              keyboardType: TextInputType.number,
                              style: SafeGoogleFont(
                                'DM Sans',
                                fontSize: 12 * b,
                                fontWeight: FontWeight.w700,
                                height: 1.1666666667 * b / a,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.fromLTRB(15 * a, 0 * a, 15 * a, 0 * a),
                          child: Text(
                            'SEND',
                            style: SafeGoogleFont(
                              'DM Sans',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w700,
                              height: 1.1666666667 * b / a,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
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

  iconTextRow(String t, String p, String d) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10 * a, horizontal: 3 * a),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(p, height: 30 * a, width: 30 * a),
          SizedBox(height: 3 * a),
          SizedBox(
            width: 99 * a,
            child: Text(
              t,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: SafeGoogleFont(
                'Roboto',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.1725 * b / a,
                color: const Color(0xffffffff),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/ic_diamond.png',
                  height: 12 * a, width: 12 * a),
              SizedBox(width: 3 * a),
              Text(
                d,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                  'Roboto',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.1725 * b / a,
                  color: const Color(0xffffffff),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  textFieldDecoration() {
    return const InputDecoration(
      isDense: true,
      counterText: "",
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );
  }
}
