import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/club_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/subscreens/create_club_page.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/club_model.dart';

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
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 18 * a, vertical: 8 * a),
                  child: Container(
                    color: Colors.white,
                    padding:
                    EdgeInsets.symmetric(horizontal: 20 * a, vertical: 0),
                    child: Consumer<ClubProvider>(
                      builder: (context, value, child) => FutureBuilder(
                        future: value.getAll(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text('none...');
                            case ConnectionState.active:
                              return const Text('active...');
                            case ConnectionState.waiting:
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(height: 36),
                                  CircularProgressIndicator(),
                                  SizedBox(height: 18),
                                  Text('Loading'),
                                ],
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if((snapshot.data?.data?.length??0) == 0){
                                return const Center(child: Text('No Clubs Yet!'));
                              } else {
                                return Column(
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
                                    SizedBox(height: 20 * a),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                          snapshot.data!.data!.length > 2
                                              ?snapshot.data!.data!.take(3).length
                                              :snapshot.data!.data!.length,
                                              (i) {
                                            Club club = snapshot.data!.data![i];
                                            return GestureDetector(
                                              onTap: () {
                                                final user = Provider.of<UserDataProvider>(context,listen: false);
                                                showDialog(context: context, builder: (context) => AlertDialog(
                                                  title: Text('Join ${club.name}?'),
                                                  actions: [
                                                    TextButton(onPressed: (){Get.back();}, child: const Text('Cancel',style: TextStyle(color: Colors.grey),)),
                                                    ElevatedButton(onPressed: (){
                                                      Get.back();
                                                      showDialog(context: context, builder: (context) => AlertDialog(
                                                        title: Text('Joining ${club.name}...'),
                                                        actions: const [],
                                                      ),);
                                                      value.join(club.id!).then((value) {
                                                        user.getUser();
                                                        Get.back();
                                                        Get.back();
                                                        return null;
                                                      });
                                                      }, child: const Text('Join'))
                                                  ],
                                                ),);
                                              },
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 58 * a,
                                                    child: Stack(
                                                      children: [
                                                        club.images!.isNotEmpty
                                                            ?CircleAvatar(
                                                            foregroundImage:
                                                            NetworkImage(club.images!.first),
                                                            radius: 25 * a)
                                                            :CircleAvatar(
                                                          foregroundImage:
                                                          const AssetImage('assets/icons/club.png'),
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
                                                    club.name??'',
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
                                                        club.totalDaimond?.toString()??'0',
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
                                            );
                                          },
                                        )),
                                    SizedBox(
                                      height: 26 * a,
                                    ),
                                    ListView(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: List.generate(
                                        snapshot.data!.data!.length > 3
                                            ?snapshot.data!.data!.skip(3).length
                                            :0,
                                            (index) {
                                          int i = index + 3;
                                          Club club = snapshot.data!.data![i];
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
                                                club.images!.isNotEmpty
                                                    ?CircleAvatar(
                                                  foregroundImage: NetworkImage(club.images!.first),
                                                  radius: 25 * a,
                                                )
                                                    :CircleAvatar(
                                                  foregroundImage: const AssetImage('assets/icons/club.png'),
                                                  radius: 25 * a,
                                                ),
                                              ],
                                            ),
                                            title: Text(
                                              club.name??'',
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
                                                  club.totalDaimond?.toString()??'0',
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
                                );
                              }
                          }
                        },
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
                    child: Consumer<ClubProvider>(
                      builder: (context, value, child) => FutureBuilder(
                        future: value.getAll(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text('none...');
                            case ConnectionState.active:
                              return const Text('active...');
                            case ConnectionState.waiting:
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(height: 36),
                                  CircularProgressIndicator(),
                                  SizedBox(height: 18),
                                  Text('Loading'),
                                ],
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if((snapshot.data?.data?.length??0) == 0){
                                return const Center(child: Text('No Clubs Yet!'));
                              } else {
                                return Column(
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
                                    SizedBox(height: 20 * a),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                          snapshot.data!.data!.length > 2
                                          ?snapshot.data!.data!.take(3).length
                                          :snapshot.data!.data!.length,
                                              (i) {
                                                Club club = snapshot.data!.data![i];
                                                return Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 58 * a,
                                                child: Stack(
                                                  children: [
                                                    club.images!.isNotEmpty
                                                    ?CircleAvatar(
                                                      foregroundImage:
                                                      NetworkImage(club.images!.first),
                                                      radius: 25 * a)
                                                    :CircleAvatar(
                                                      foregroundImage:
                                                      const AssetImage('assets/icons/club.png'),
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
                                                club.name??'',
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
                                                    club.totalDaimond?.toString()??'0',
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
                                          );
                                              },
                                        )),
                                    SizedBox(
                                      height: 26 * a,
                                    ),
                                    ListView(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: List.generate(
                                        snapshot.data!.data!.length > 3
                                          ?snapshot.data!.data!.skip(3).length
                                          :0,
                                            (index) {
                                          int i = index + 3;
                                          Club club = snapshot.data!.data![i];
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
                                              club.images!.isNotEmpty
                                                ?CircleAvatar(
                                                foregroundImage: NetworkImage(club.images!.first),
                                                radius: 25 * a,
                                                )
                                                :CircleAvatar(
                                                  foregroundImage: const AssetImage('assets/icons/club.png'),
                                                  radius: 25 * a,
                                                ),
                                              ],
                                            ),
                                            title: Text(
                                              club.name??'',
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
                                                  club.totalDaimond?.toString()??'0',
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
                                );
                              }
                          }
                        },
                      ),
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
