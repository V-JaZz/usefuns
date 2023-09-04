import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../../provider/rooms_provider.dart';
import '../../rooms/room_svip_5.dart';
import 'create_room.dart';
import 'party.dart';
import 'ranking.dart';
import 'search_room_user.dart';
import 'usefun_clubs.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  void initState() {
    checkUserRoom();
    super.initState();
  }

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
              Container(
                width: 24 * a,
                height: 24 * a,
                padding: const EdgeInsets.all(3),
                child: Image.asset(
                  'assets/icons/ic_home.png',
                ),
              ),
              Expanded(
                child: TabBar(
                  indicatorColor: Colors.black,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 6 * a),
                  indicatorWeight: 1.3,
                  dividerColor: Colors.transparent,
                  labelColor: const Color(0xff000000),
                  unselectedLabelColor: const Color(0x99000000),
                  labelStyle: SafeGoogleFont(
                    'Poppins',
                    fontSize: 21 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.96 * a,
                    color: const Color(0xff000000),
                  ),
                  unselectedLabelStyle: SafeGoogleFont(
                    'Poppins',
                    fontSize: 18 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.5 * b / a,
                    letterSpacing: 0.96 * a,
                    color: const Color(0x99000000),
                  ),
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      text: "Mine",
                    ),
                    Tab(
                      text: "Popular",
                    ),
                    Tab(
                      text: "New",
                    )
                  ],
                ),
              ),
              Container(
                width: 24 * a,
                height: 24 * a,
                padding: const EdgeInsets.all(3),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const SearchRoomUser());
                  },
                  child: Image.asset(
                    'assets/icons/ic_search.png',
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                SizedBox(height: 30 * a),
                Consumer<RoomsProvider>(
                  builder:(context, value, child) {
                    if (value.myRoom == null) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0x33000000),
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignInside),
                        ),
                        child: const ListTile(
                          title: LinearProgressIndicator(),
                          subtitle: Text(''),
                        ),
                      );
                    } else if (value.myRoom?.status == 0) {
                      return Text('Error: ${value.myRoom?.message}');
                    } else if((value.myRoom?.data?.length??0) == 0){
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0x33000000),
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignInside),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => const CreateRoom());
                          },
                          leading: CircleAvatar(
                            radius: 20 * a,
                            backgroundColor: const Color(0xff9e26bc),
                            child: Image.asset(
                              'assets/icons/ic_create_room.png',
                              width: 24 * a,
                              height: 24 * a,
                            ),
                          ),
                          title: Text(
                            'Create My Room',
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
                            'Start Your live Journey on Use funs',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: const Color(0x99000000),
                            ),
                          ),
                          trailing: Container(
                            width: 24 * a,
                            height: 24 * a,
                            decoration: BoxDecoration(
                              color: const Color(0xff9e26bc),
                              borderRadius: BorderRadius.circular(12 * a),
                            ),
                            child: Center(
                              child: Text(
                                '+',
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
                        ),
                      );
                    } else {
                      final room = value.myRoom!.data!.first;
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0x33000000),
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignInside),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => const RoomSVIP5());
                          },
                          leading:room.images!.isEmpty
                              ? CircleAvatar(
                              radius: 20 * a,
                              backgroundColor: const Color(0xff9e26bc),
                              foregroundImage: const AssetImage('assets/icons/ic_create_room.png')
                          )
                              : CircleAvatar(
                            radius: 20 * a,
                            backgroundColor: const Color(0xff9e26bc),
                            foregroundImage: NetworkImage(room.images!.first),
                          ),
                          title: Text(
                            room.name!,
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
                            'Join room',
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 12 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.48 * a,
                              color: const Color(0x99000000),
                            ),
                          ),
                          trailing: InkWell(
                            child: IconButton(
                              onPressed: (){showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Delete'),
                                    content: const Text('Are you sure you want to delete this item?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      OutlinedButton(
                                        style: ButtonStyle(
                                            side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).primaryColor))
                                        ),
                                        onPressed: () {
                                          value.delete(room.roomId!);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              },
                              icon: Icon(Icons.delete,color: const Color(0xff9e26bc),size: 16*a),
                            ),
                          ),
                        ),
                      );
                    };
                  },
                ),
                SizedBox(height: 10 * a),
                DefaultTabController(
                  length: 3,
                  child: Expanded(
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
                        tabs: const [
                          Tab(
                            text: "Recently",
                          ),
                          Tab(
                            text: "Follow",
                          ),
                          Tab(
                            text: "Group",
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18 * a, vertical: 8 * a),
                                child: Column(
                                  children: [
                                    for (Map club in roomList.take(3))
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              dense: true,
                                              contentPadding: EdgeInsets.zero,
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
                                                  color:
                                                      const Color(0xff000000),
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
                                                  color:
                                                      const Color(0x99000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * a,
                                                      0 * a,
                                                      1 * a,
                                                      4 * a),
                                                  width: 3 * a,
                                                  height: 15 * a,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffff9933),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * a,
                                                      0 * a,
                                                      1 * a,
                                                      4 * a),
                                                  width: 3 * a,
                                                  height: 19 * a,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffff9933),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * a,
                                                      0 * a,
                                                      5 * a,
                                                      4 * a),
                                                  width: 3 * a,
                                                  height: 15 * a,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffff9933),
                                                  ),
                                                ),
                                                Text(
                                                  club["rank"],
                                                  style: SafeGoogleFont(
                                                    'Poppins',
                                                    fontSize: 12 * b,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.5 * b / a,
                                                    letterSpacing: 0.48 * a,
                                                    color:
                                                        const Color(0xff000000),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18 * a, vertical: 8 * a),
                                child:
                                Consumer<RoomsProvider>(
                                  builder: (context, value, child) => FutureBuilder(
                                    future: value.getAllFollowingByMe(),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return const Text('none...');
                                        case ConnectionState.active:
                                          return const Text('active...');
                                        case ConnectionState.waiting:
                                          return const Center(child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircularProgressIndicator(),
                                              SizedBox(height: 18),
                                              Text('Loading'),
                                            ],
                                          ));
                                        case ConnectionState.done:
                                          if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}');
                                          } else if((snapshot.data?.data?.length??0) == 0){
                                            return const Center(child: Text('No Data Found!'));
                                          } else {
                                            return Expanded(
                                              child: ListView.builder(
                                                itemCount: snapshot.data?.data?.length??0,
                                                itemBuilder: (context, index) {
                                                  final club = snapshot.data!.data![index];
                                                  return Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: ListTile(
                                                          dense: true,
                                                          contentPadding: EdgeInsets.zero,
                                                          leading: club.images!.isEmpty? Image.asset(
                                                            "assets/logo_greystyle.png",
                                                            fit: BoxFit.contain,
                                                            width: 64 * a,
                                                            height: 64 * a,
                                                          ) : Image.network(
                                                            club.images!.first,
                                                            fit: BoxFit.contain,
                                                            width: 64 * a,
                                                            height: 64 * a,
                                                          ),
                                                          title: Text(
                                                            club.name.toString(),
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
                                                            club.announcement==''?'Welcome to my room!':club.announcement!,
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
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 10.0),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets.fromLTRB(
                                                                  0 * a, 0 * a, 1 * a, 4 * a),
                                                              width: 3 * a,
                                                              height: 15 * a,
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xffff9933),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.fromLTRB(
                                                                  0 * a, 0 * a, 1 * a, 4 * a),
                                                              width: 3 * a,
                                                              height: 19 * a,
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xffff9933),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.fromLTRB(
                                                                  0 * a, 0 * a, 5 * a, 4 * a),
                                                              width: 3 * a,
                                                              height: 15 * a,
                                                              decoration: const BoxDecoration(
                                                                color: Color(0xffff9933),
                                                              ),
                                                            ),
                                                            Text(
                                                              club.members?.length.toString()??'0',
                                                              style: SafeGoogleFont(
                                                                'Poppins',
                                                                fontSize: 12 * b,
                                                                fontWeight: FontWeight.w400,
                                                                height: 1.5 * b / a,
                                                                letterSpacing: 0.48 * a,
                                                                color: const Color(0xff000000),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18 * a, vertical: 8 * a),
                                child: Column(
                                  children: [
                                    for (Map club in roomList.take(5))
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              dense: true,
                                              contentPadding: EdgeInsets.zero,
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
                                                  color:
                                                      const Color(0xff000000),
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
                                                  color:
                                                      const Color(0x99000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * a,
                                                      0 * a,
                                                      1 * a,
                                                      4 * a),
                                                  width: 3 * a,
                                                  height: 15 * a,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffff9933),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * a,
                                                      0 * a,
                                                      1 * a,
                                                      4 * a),
                                                  width: 3 * a,
                                                  height: 19 * a,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffff9933),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * a,
                                                      0 * a,
                                                      5 * a,
                                                      4 * a),
                                                  width: 3 * a,
                                                  height: 15 * a,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xffff9933),
                                                  ),
                                                ),
                                                Text(
                                                  club["rank"],
                                                  style: SafeGoogleFont(
                                                    'Poppins',
                                                    fontSize: 12 * b,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.5 * b / a,
                                                    letterSpacing: 0.48 * a,
                                                    color:
                                                        const Color(0xff000000),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ]),
                      )
                    ],
                  )),
                )
              ],
            ),
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Image.asset(
                    "assets/decoration/reward_program.png",
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 20 * a,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => const Ranking());
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset('assets/icons/ranking.png',
                                          width: 30 * a, height: 30 * a),
                                      Text(
                                        'Ranking',
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
                                )),
                            Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => const UsefunsClub());
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset('assets/icons/club.png',
                                          width: 30 * a, height: 30 * a),
                                      Text(
                                        'Usefuns Club',
                                        maxLines: 1,
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
                                )),
                            Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => const Party());
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset('assets/icons/party.png',
                                          width: 30 * a, height: 30 * a),
                                      Text(
                                        'Party',
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
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20 * a,
                        ),
                        Expanded(
                          child: Consumer<RoomsProvider>(
                            builder: (context, value, child) => FutureBuilder(
                              future: value.getAllPopular(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return const Text('none...');
                                  case ConnectionState.active:
                                    return const Text('active...');
                                  case ConnectionState.waiting:
                                    return const Center(child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 18),
                                        Text('Loading'),
                                      ],
                                    ));
                                  case ConnectionState.done:
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return ListView.builder(
                                        itemCount: snapshot.data?.data?.length??0,
                                        itemBuilder: (context, index) {
                                          final club = snapshot.data!.data![index];
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: ListTile(
                                                  dense: true,
                                                  contentPadding: EdgeInsets.zero,
                                                  leading: club.images!.isEmpty? Image.asset(
                                                    "assets/logo_greystyle.png",
                                                    fit: BoxFit.contain,
                                                    width: 64 * a,
                                                    height: 64 * a,
                                                  ) : Image.network(
                                                    club.images!.first,
                                                    fit: BoxFit.contain,
                                                    width: 64 * a,
                                                    height: 64 * a,
                                                  ),
                                                  title: Text(
                                                    club.name.toString(),
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
                                                    club.announcement==''?'Welcome to my room!':club.announcement!,
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
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * a, 0 * a, 1 * a, 4 * a),
                                                      width: 3 * a,
                                                      height: 15 * a,
                                                      decoration: const BoxDecoration(
                                                        color: Color(0xffff9933),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * a, 0 * a, 1 * a, 4 * a),
                                                      width: 3 * a,
                                                      height: 19 * a,
                                                      decoration: const BoxDecoration(
                                                        color: Color(0xffff9933),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          0 * a, 0 * a, 5 * a, 4 * a),
                                                      width: 3 * a,
                                                      height: 15 * a,
                                                      decoration: const BoxDecoration(
                                                        color: Color(0xffff9933),
                                                      ),
                                                    ),
                                                    Text(
                                                      club.members?.length.toString()??'0',
                                                      style: SafeGoogleFont(
                                                        'Poppins',
                                                        fontSize: 12 * b,
                                                        fontWeight: FontWeight.w400,
                                                        height: 1.5 * b / a,
                                                        letterSpacing: 0.48 * a,
                                                        color: const Color(0xff000000),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 18 * a, vertical: 8 * a),
              child: Consumer<RoomsProvider>(
                builder: (context, value, child) => FutureBuilder(
                  future: value.getAllNew(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Text('none...');
                        case ConnectionState.active:
                          return const Text('active...');
                        case ConnectionState.waiting:
                          return const Center(child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 18),
                              Text('Loading'),
                            ],
                          ));
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data?.data?.length??0,
                                itemBuilder: (context, index) {
                                final club = snapshot.data!.data![index];
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          leading: club.images!.isEmpty? Image.asset(
                                            "assets/logo_greystyle.png",
                                            fit: BoxFit.contain,
                                            width: 64 * a,
                                            height: 64 * a,
                                          ) : Image.network(
                                            club.images!.first,
                                            fit: BoxFit.contain,
                                            width: 64 * a,
                                            height: 64 * a,
                                          ),
                                          title: Text(
                                            club.name.toString(),
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
                                            club.announcement==''?'Welcome to my room!':club.announcement!,
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
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * a, 0 * a, 1 * a, 4 * a),
                                              width: 3 * a,
                                              height: 15 * a,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffff9933),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * a, 0 * a, 1 * a, 4 * a),
                                              width: 3 * a,
                                              height: 19 * a,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffff9933),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * a, 0 * a, 5 * a, 4 * a),
                                              width: 3 * a,
                                              height: 15 * a,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffff9933),
                                              ),
                                            ),
                                            Text(
                                              club.members?.length.toString()??'0',
                                              style: SafeGoogleFont(
                                                'Poppins',
                                                fontSize: 12 * b,
                                                fontWeight: FontWeight.w400,
                                                height: 1.5 * b / a,
                                                letterSpacing: 0.48 * a,
                                                color: const Color(0xff000000),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                            );

                          }
                      }
                    },
              ),
            ),
            )
          ],
        ),
      ),
    );
  }

  void checkUserRoom() {
    final provider = Provider.of<RoomsProvider>(context,listen: false);
    provider.myRoom??provider.getAllMine();
  }
}
