import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/subscreens/create_club_page.dart';

import 'package:live_app/utils/utils_assets.dart';

class UsefunsClub extends StatefulWidget {
  const UsefunsClub({super.key});

  @override
  State<UsefunsClub> createState() => _UsefunsClubState();
}

class _UsefunsClubState extends State<UsefunsClub>
    with TickerProviderStateMixin {
  final List<Map> giftsList = [
    {
      "dp": "assets/dummy/g1.png",
      "name": "Liza",
      "points": "33913",
    },
    {
      "dp": "assets/dummy/g2.png",
      "name": "Girl Friend.Com",
      "points": "32878",
    },
    {
      "dp": "assets/dummy/b1.png",
      "name": "Ariful islam",
      "points": "27567",
    },
    {
      "dp": "assets/dummy/b2.png",
      "name": "Simple Boy",
      "points": "21398",
    },
    {
      "dp": "assets/dummy/g3.png",
      "name": "FRIENDSHIP CLUB",
      "points": "18232",
    },
    {
      "dp": "assets/dummy/g4.png",
      "name": "Gf Bf Dating Eoom",
      "points": "18221",
    },
    {
      "dp": "assets/dummy/g5.png",
      "name": "Nisha Hosting....",
      "points": "17323",
    },
    {
      "dp": "assets/dummy/b1.png",
      "name": "Dimple Ayesha.",
      "points": "11237",
    },
    {
      "dp": "assets/dummy/g1.png",
      "name": "Sheikh Papia.",
      "points": "3421",
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
                child: Text('Usefuns',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 20 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.8 * a,
                      color: const Color(0xff000000),
                    ))),
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.black,
              indicatorWeight: 1.3,
              labelColor: const Color(0xff000000),
              unselectedLabelColor: const Color(0x99000000),
              labelStyle: SafeGoogleFont(
                'Poppins',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.96 * a,
                color: const Color(0xff000000),
              ),
              unselectedLabelStyle: SafeGoogleFont(
                'Poppins',
                fontSize: 16 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.96 * a,
                color: const Color(0x99000000),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30 * a),
              labelPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(
                  text: "Recommended",
                ),
                Tab(
                  text: "Ranking",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                Column(
                  children: [
                    SizedBox(
                      height: Get.width / 4,
                    ),
                    Image.asset(
                      "assets/icons/ic_empty.png",
                      width: Get.width / 2,
                      height: Get.width / 2,
                    ),
                    Text(
                      'No data, Please meet More Freiends',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 16 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.64 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18 * a, vertical: 8 * a),
                    child: Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20 * a, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time Period: 18/05 00:00-24/05 23:59',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: const Color(0x88000000),
                            ),
                          ),
                          SizedBox(height: 20 * a),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                giftsList.take(3).length,
                                (i) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 58 * a,
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            foregroundImage:
                                                AssetImage(giftsList[i]['dp']),
                                            radius: 25 * a,
                                          ),
                                          Positioned(
                                            left: 29 * a,
                                            top: 34 * a,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              foregroundImage: AssetImage(
                                                  'assets/decoration/top_${i + 1}.png'),
                                              radius: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      giftsList[i]['name'],
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
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 5 * a),
                                          width: 13 * a,
                                          height: 14 * a,
                                          child: Image.asset(
                                            'assets/icons/ic_diamond.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          giftsList[i]['points'],
                                          style: SafeGoogleFont(
                                            'Poppins',
                                            fontSize: 9 * b,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5 * b / a,
                                            letterSpacing: 0.36 * a,
                                            color: const Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 26 * a,
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              giftsList.skip(3).length,
                              (index) {
                                int i = index + 3;
                                return ListTile(
                                  dense: true,
                                  minVerticalPadding: 26 * a,
                                  contentPadding: EdgeInsets.zero,
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0 * a, 0 * a, 11 * a, 0 * a),
                                        child: Text(
                                          '${i + 1}',
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
                                      CircleAvatar(
                                        foregroundImage: AssetImage(
                                          giftsList[i]['dp'],
                                        ),
                                        radius: 25 * a,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    giftsList[i]['name'],
                                    style: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 12 * b,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * b / a,
                                      letterSpacing: 0.48 * a,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5 * a),
                                        width: 13 * a,
                                        height: 14 * a,
                                        child: Image.asset(
                                          'assets/icons/ic_diamond.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        giftsList[i]['points'],
                                        style: SafeGoogleFont(
                                          'Poppins',
                                          fontSize: 9 * b,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5 * b / a,
                                          letterSpacing: 0.36 * a,
                                          color: const Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0 * a, 10 * a, 0 * a, 7 * a),
              width: double.infinity,
              height: 41 * a,
              decoration: const BoxDecoration(
                color: Color(0xff9e26bc),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 6 * a, 0 * a),
                    width: 19 * a,
                    height: double.infinity,
                    child: SizedBox(
                      width: 19 * a,
                      height: 19 * a,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff0663fe),
                        ),
                        child: Center(
                          child: Text(
                            '+',
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
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const CreateClubScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 2 * a),
                      child: Text(
                        'Create a Club',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
