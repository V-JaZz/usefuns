import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/model/response/room_gift_history_model.dart';
import '../../../provider/gifts_provider.dart';
import '../../../utils/helper.dart';


class Contribution extends StatefulWidget {
  const Contribution({Key? key}) : super(key: key);

  @override
  State<Contribution> createState() => _ContributionState();
}

class _ContributionState extends State<Contribution> {

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
                  text: "Today",
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
                      child: Consumer<GiftsProvider>(
                        builder:(context, value, child) {
                          final list = value.todayRoomContribution;
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
                            if(list.isEmpty)
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  list.length>2?3:list.length,
                                  (i) {
                                    final userId = list.keys.elementAt(i);
                                    final List<GiftHistory> history = list[userId]!;
                                    int diamondsSum = 0;
                                    for(var g in history){
                                      diamondsSum = diamondsSum+(g.gift!.coin!*g.count!);
                                    }
                                    return FutureBuilder(
                                      future: Provider.of<UserDataProvider>(context,listen: false).getUser(id: userId),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.none:
                                              return const Text('none...');
                                            case ConnectionState.active:
                                              return const Text('active...');
                                            case ConnectionState.waiting:
                                              return Shimmer.fromColors(
                                                baseColor: const Color.fromARGB(
                                                    248, 188, 187, 187),
                                                highlightColor: Colors.white,
                                                period: const Duration(seconds: 1),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  margin: const EdgeInsets.only(bottom: 36),
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white
                                                  ),
                                                ),
                                              );
                                            case ConnectionState.done:
                                              if(snapshot.hasError || snapshot.data?.data == null){
                                                return const SizedBox.shrink();
                                              }
                                              return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 58 * a,
                                                      child: Stack(
                                                        children: [
                                                          snapshot.data!.data!.images!.isNotEmpty
                                                            ? CircleAvatar(
                                                            foregroundImage:NetworkImage(snapshot.data!.data!.images!.first),
                                                            radius: 25 * a,
                                                          )
                                                              : CircleAvatar(
                                                            foregroundImage:const AssetImage('assets/profile.png'),
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
                                                      snapshot.data!.data!.name!,
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
                                                          formatNumber(diamondsSum),
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
                                          }
                                        },
                                    );
                                  },
                                )),
                            SizedBox(
                              height: 26 * a,
                            ),
                            if(list.length>3)ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children:

                              List.generate(
                                list.length-3,
                                    (index) {
                                      int i = index + 3;
                                  final userId = list.keys.elementAt(i);
                                  final List<GiftHistory> history = list[userId]!;
                                  int diamondsSum = 0;
                                  for(var g in history){
                                    diamondsSum = diamondsSum+(g.gift!.coin!*g.count!);
                                  }
                                  return FutureBuilder(
                                    future: Provider.of<UserDataProvider>(context,listen: false).getUser(id: userId),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return const Text('none...');
                                        case ConnectionState.active:
                                          return const Text('active...');
                                        case ConnectionState.waiting:
                                          return Shimmer.fromColors(
                                            baseColor: const Color.fromARGB(
                                                248, 188, 187, 187),
                                            highlightColor: Colors.white,
                                            period: const Duration(seconds: 1),
                                            child: ListTile(
                                              dense: true,
                                              minVerticalPadding: 26 * a,
                                              contentPadding: EdgeInsets.zero,
                                              leading: CircleAvatar(radius: 25 * a,foregroundColor: Colors.white),
                                              title: Container(height: 16*a, width: 50*a, color: Colors.white,),
                                            ),
                                          );
                                        case ConnectionState.done:
                                          if(snapshot.hasError || snapshot.data?.data == null){
                                            return const SizedBox.shrink();
                                          }
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
                                                snapshot.data!.data!.images!.isNotEmpty
                                                    ? CircleAvatar(
                                                  foregroundImage:NetworkImage(snapshot.data!.data!.images!.first),
                                                  radius: 25 * a,
                                                )
                                                    : CircleAvatar(
                                                  foregroundImage:const AssetImage('assets/profile.png'),
                                                  radius: 25 * a,
                                                ),
                                              ],
                                            ),
                                            title: Text(
                                              snapshot.data!.data!.name!,
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
                                                  formatNumber(diamondsSum),
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

                                      }
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        );
                        },
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
                      child: Consumer<GiftsProvider>(
                        builder:(context, value, child) {
                          final list = value.sevenDaysRoomContribution;
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
                              if(list.isEmpty)
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
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    list.length>2?3:list.length,
                                        (i) {
                                      final userId = list.keys.elementAt(i);
                                      final List<GiftHistory> history = list[userId]!;
                                      int diamondsSum = 0;
                                      for(var g in history){
                                        diamondsSum = diamondsSum+(g.gift!.coin!*g.count!);
                                      }
                                      return FutureBuilder(
                                        future: Provider.of<UserDataProvider>(context,listen: false).getUser(id: userId),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.none:
                                              return const Text('none...');
                                            case ConnectionState.active:
                                              return const Text('active...');
                                            case ConnectionState.waiting:
                                              return Shimmer.fromColors(
                                                baseColor: const Color.fromARGB(
                                                    248, 188, 187, 187),
                                                highlightColor: Colors.white,
                                                period: const Duration(seconds: 1),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  margin: const EdgeInsets.only(bottom: 36),
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white
                                                  ),
                                                ),
                                              );
                                            case ConnectionState.done:
                                              if(snapshot.hasError || snapshot.data?.data == null){
                                                return const SizedBox.shrink();
                                              }
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 58 * a,
                                                    child: Stack(
                                                      children: [
                                                        snapshot.data!.data!.images!.isNotEmpty
                                                            ? CircleAvatar(
                                                          foregroundImage:NetworkImage(snapshot.data!.data!.images!.first),
                                                          radius: 25 * a,
                                                        )
                                                            : CircleAvatar(
                                                          foregroundImage:const AssetImage('assets/profile.png'),
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
                                                    snapshot.data!.data!.name!,
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
                                                        formatNumber(diamondsSum),
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
                                          }
                                        },
                                      );
                                    },
                                  )),
                              SizedBox(
                                height: 26 * a,
                              ),
                              if(list.length>3)ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children:

                                List.generate(
                                  list.length-3,
                                      (index) {
                                    int i = index + 3;
                                    final userId = list.keys.elementAt(i);
                                    final List<GiftHistory> history = list[userId]!;
                                    int diamondsSum = 0;
                                    for(var g in history){
                                      diamondsSum = diamondsSum+(g.gift!.coin!*g.count!);
                                    }
                                    return FutureBuilder(
                                      future: Provider.of<UserDataProvider>(context,listen: false).getUser(id: userId),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                            return const Text('none...');
                                          case ConnectionState.active:
                                            return const Text('active...');
                                          case ConnectionState.waiting:
                                            return Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
                                                  248, 188, 187, 187),
                                              highlightColor: Colors.white,
                                              period: const Duration(seconds: 1),
                                              child: ListTile(
                                                dense: true,
                                                minVerticalPadding: 26 * a,
                                                contentPadding: EdgeInsets.zero,
                                                leading: CircleAvatar(radius: 25 * a,foregroundColor: Colors.white),
                                                title: Container(height: 16*a, width: 50*a, color: Colors.white,),
                                              ),
                                            );
                                          case ConnectionState.done:
                                            if(snapshot.hasError || snapshot.data?.data == null){
                                              return const SizedBox.shrink();
                                            }
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
                                                  snapshot.data!.data!.images!.isNotEmpty
                                                      ? CircleAvatar(
                                                    foregroundImage:NetworkImage(snapshot.data!.data!.images!.first),
                                                    radius: 25 * a,
                                                  )
                                                      : CircleAvatar(
                                                    foregroundImage:const AssetImage('assets/profile.png'),
                                                    radius: 25 * a,
                                                  ),
                                                ],
                                              ),
                                              title: Text(
                                                snapshot.data!.data!.name!,
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
                                                    formatNumber(diamondsSum),
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

                                        }
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          );
                        },
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
