import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';


class Contribution extends StatefulWidget {
  const Contribution({Key? key}) : super(key: key);

  @override
  State<Contribution> createState() => _ContributionState();
}

class _ContributionState extends State<Contribution> {
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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Contribution',
          style: TextStyle(fontSize: 18 * a),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: const Color(0xffFF9933),
              indicatorWeight: 0.7,
              labelColor: const Color(0xffFF9933),
              unselectedLabelColor: const Color(0x99000000),
              labelStyle: SafeGoogleFont(
                'Poppins',
                fontSize: 14 * b,
                fontWeight: FontWeight.w400,
                height: 1.5 * b / a,
                letterSpacing: 0.96 * a,
                color: const Color(0xff000000),
              ),
              unselectedLabelStyle: SafeGoogleFont(
                'Poppins',
                fontSize: 12 * b,
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
                  text: "Last 24 Hours",
                ),
                Tab(
                  text: "Last 7 Days",
                )
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18 * a, vertical: 8 * a),
                    child: Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20 * a, vertical: 0),
                      child: Consumer<ZegoRoomProvider>(
                        builder:(context, value, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Time Period: 18/05 00:00-24/05 23:59',
                            //   style: SafeGoogleFont(
                            //     'Poppins',
                            //     fontSize: 12 * b,
                            //     fontWeight: FontWeight.w400,
                            //     height: 1.5 * b / a,
                            //     letterSpacing: 0.48 * a,
                            //     color: const Color(0x88000000),
                            //   ),
                            // ),
                            // Text(
                            //   'Updated at: 16:59',
                            //   style: SafeGoogleFont(
                            //     'Poppins',
                            //     fontSize: 12 * b,
                            //     fontWeight: FontWeight.w400,
                            //     height: 1.5 * b / a,
                            //     letterSpacing: 0.48 * a,
                            //     color: const Color(0x88000000),
                            //   ),
                            // ),
                            SizedBox(height: 20 * a),
                            if(value.room!.contributorsList!.isEmpty)
                              Center(child: Text('No Data!',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 12 * b,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.48 * a,
                                    color: const Color(0x88000000),
                                  ))),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  value.room!.contributorsList!.length>2?3:value.room!.contributorsList!.length,
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
                            if(value.room!.contributorsList!.length>3)ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(
                                value.room!.contributorsList!.skip(3).length,
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
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18 * a, vertical: 8 * a),
                    child: Container(
                      color: Colors.white,
                      padding:
                      EdgeInsets.symmetric(horizontal: 20 * a, vertical: 0),
                      child: Consumer<ZegoRoomProvider>(
                        builder:(context, value, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Time Period: 18/05 00:00-24/05 23:59',
                            //   style: SafeGoogleFont(
                            //     'Poppins',
                            //     fontSize: 12 * b,
                            //     fontWeight: FontWeight.w400,
                            //     height: 1.5 * b / a,
                            //     letterSpacing: 0.48 * a,
                            //     color: const Color(0x88000000),
                            //   ),
                            // ),
                            // Text(
                            //   'Updated at: 16:59',
                            //   style: SafeGoogleFont(
                            //     'Poppins',
                            //     fontSize: 12 * b,
                            //     fontWeight: FontWeight.w400,
                            //     height: 1.5 * b / a,
                            //     letterSpacing: 0.48 * a,
                            //     color: const Color(0x88000000),
                            //   ),
                            // ),
                            SizedBox(height: 20 * a),
                            if(value.room!.contributorsList!.isEmpty)
                              Center(child: Text('No Data!',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 12 * b,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.48 * a,
                                    color: const Color(0x88000000),
                                  ))),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  value.room!.contributorsList!.length>2?3:value.room!.contributorsList!.length,
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
                            if(value.room!.contributorsList!.length>3)ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(
                                value.room!.contributorsList!.skip(3).length,
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
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
