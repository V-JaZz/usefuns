import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../provider/rooms_provider.dart';
import '../../../utils/common_widgets.dart';
import '../me/profile/user_profile.dart';
import 'create_room.dart';
import 'ranking.dart';
import 'search_room_user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RefreshController refreshController = RefreshController();
  RefreshController refreshController2 = RefreshController();
  RefreshController refreshController3 = RefreshController();

  @override
  void initState() {
    checkUserRoom();
    super.initState();
  }
  @override
  void dispose() {
    refreshController.dispose();
    refreshController2.dispose();
    refreshController3.dispose();
    super.dispose();
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
            SmartRefresher(
              enablePullDown: true,
              onRefresh: ()async{
                await Future.delayed(const Duration(milliseconds: 500),() {
                  setState(() {});
                });
                refreshController.refreshCompleted();
                return;
                },
              physics: const BouncingScrollPhysics(),
              header: WaterDropMaterialHeader(distance: 36*a),
              controller: refreshController,
                child: Column(
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
                              value.joinRoom(room);
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
                                  padding: EdgeInsets.only(
                                      left: 18 * a, right: 18 * a, top: 8 * a),
                                  child:
                                  Consumer<RoomsProvider>(
                                    builder: (context, value, child) => FutureBuilder(
                                      future: value.getAllMyRecent(),
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
                                              return const Center(child: Text('No Recent Rooms!'));
                                            } else {
                                              return ListView(
                                                children: List.generate(snapshot.data?.data?.length??0, (index) {
                                                  final room = snapshot.data!.data![index];
                                                  return roomListTile(
                                                    image: room.images!.isEmpty?null:room.images!.first,
                                                    title: room.name.toString(),
                                                    subTitle: room.announcement,
                                                    active: room.activeUsers?.length.toString()??'0',
                                                    onTap: (){
                                                      value.joinRoom(room);
                                                    },
                                                  );
                                                })
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
                                  child:
                                  Consumer<UserDataProvider>(
                                    builder: (context, value, child) {
                                      final following = value.userData!.data!.following!;
                                      if(following.isEmpty){
                                        return const Center(child: Text('Not Followed any user until now!'));
                                      }else {
                                        return ListView.builder(
                                          itemCount: following.length,
                                          itemBuilder: (context, index) {
                                            return FutureBuilder(
                                                future: Provider.of<UserDataProvider>(context,
                                                    listen: false)
                                                    .getUser(id: following[index]),
                                                builder: (context, snapshot) {
                                                  switch (snapshot.connectionState) {
                                                    case ConnectionState.none:
                                                      return const Text('none...');
                                                    case ConnectionState.active:
                                                      return const Text('active...');
                                                    case ConnectionState.waiting:
                                                      return Container(
                                                          width: double.infinity,
                                                          height: 70 * a,
                                                          decoration: BoxDecoration(
                                                            border: Border(
                                                                top: BorderSide(
                                                                    color:
                                                                    Colors.black.withOpacity(0.06),
                                                                    width: 1)),
                                                          ),
                                                          padding: EdgeInsets.all(10 * a),
                                                          child: Row(
                                                            children: [
                                                              Shimmer.fromColors(
                                                                baseColor: const Color.fromARGB(
                                                                    248, 188, 187, 187),
                                                                highlightColor: Colors.white,
                                                                period: const Duration(seconds: 1),
                                                                child: Container(
                                                                  margin: EdgeInsets.fromLTRB(
                                                                      0 * a, 0 * a, 12 * a, 0 * a),
                                                                  width: 50 * a,
                                                                  height: 50 * a,
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    image: DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: AssetImage(
                                                                          'assets/profile.png'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: Shimmer.fromColors(
                                                                    baseColor: const Color.fromARGB(
                                                                        248, 188, 187, 187),
                                                                    highlightColor: Colors.white,
                                                                    period: const Duration(seconds: 1),
                                                                    child: Container(
                                                                      margin: EdgeInsets.fromLTRB(
                                                                          0 * a, 2 * a, 7 * a, 8 * a),
                                                                      height: 21 * a,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius:
                                                                          BorderRadius.circular(8)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                                    case ConnectionState.done:
                                                      if (snapshot.hasError ||
                                                          snapshot.data?.status == 0 ||
                                                          snapshot.data?.data == null) {
                                                        return ListTile(
                                                          title: Text('Error: ${snapshot.error}'),
                                                        );
                                                      } else {
                                                        final user = snapshot.data!.data;

                                                        return Container(
                                                          width: double.infinity,
                                                          height: 70 * a,
                                                          decoration: BoxDecoration(
                                                            border: Border(
                                                                top: BorderSide(
                                                                    color:
                                                                    Colors.black.withOpacity(0.06),
                                                                    width: 1)),
                                                          ),
                                                          padding: EdgeInsets.all(10 * a),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              Provider.of<UserDataProvider>(context,listen: false).addVisitor(following[index]);
                                                              Get.to(()=> UserProfile(userData: user));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.fromLTRB(
                                                                      0 * a, 0 * a, 7 * a, 0 * a),
                                                                  width: 50 * a,
                                                                  height: 50 * a,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    image: user!.images!.isEmpty
                                                                        ? const DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: AssetImage(
                                                                          'assets/profile.png'),
                                                                    )
                                                                        : DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: NetworkImage(
                                                                          user.images!.first),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.fromLTRB(
                                                                      3 * a, 0 * a, 6 * a, 2 * a),
                                                                  child: Text(
                                                                    user.name.toString(),
                                                                    style: SafeGoogleFont(
                                                                      'Poppins',
                                                                      fontSize: 15 * b,
                                                                      fontWeight: FontWeight.w400,
                                                                      height: 1.5 * b / a,
                                                                      letterSpacing: 0.48 * a,
                                                                      color:
                                                                      const Color(0xff000000),
                                                                    ),
                                                                  ),
                                                                ),
                                                                userLevelTag(
                                                                    user.level ?? 0, 17 * a)
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  }
                                                });
                                          },
                                        );
                                        }
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18 * a, vertical: 8 * a),
                                  child:
                                  Consumer<RoomsProvider>(
                                    builder: (context, value, child) => FutureBuilder(
                                      future: value.getAllGroups(),
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
                                              return ListView.builder(
                                                itemCount: snapshot.data?.data?.length??0,
                                                itemBuilder: (context, index) {
                                                  final room = snapshot.data!.data![index];
                                                  return roomListTile(
                                                    image: room.images!.isEmpty?null:room.images!.first,
                                                    title: room.name.toString(),
                                                    subTitle: room.announcement,
                                                    active: room.activeUsers?.length.toString()??'0',
                                                    onTap: (){
                                                      value.joinRoom(room);
                                                    },
                                                  );
                                                },
                                              );
                                            }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
            SmartRefresher(
              enablePullDown: true,
              onRefresh: ()async{
                await Future.delayed(const Duration(milliseconds: 500),() {
                  setState(() {});
                });
                refreshController2.refreshCompleted();
                return;
              },
              physics: const BouncingScrollPhysics(),
              header: WaterDropMaterialHeader(distance: 36*a),
              controller: refreshController2,
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        "assets/decoration/reward_program.png",
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
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
                                      //todo
                                      // Get.to(() => const UsefunsClub());
                                      showCustomSnackBar('Upcoming!', context,isError: false);
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset('assets/icons/club.png',
                                            width: 30 * a, height: 30 * a),
                                        Text(
                                          'Family',
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
                                      //todo:
                                      // Get.to(() => const Party());
                                      showCustomSnackBar('Upcoming!', context,isError: false);
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
                                    default:
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }else {
                                        return
                                          ListView.builder(
                                            itemCount: snapshot.data?.data?.length??0,
                                            itemBuilder: (context, index) {
                                              final room = snapshot.data!.data![index];
                                              return roomListTile(
                                                image: room.images!.isEmpty?null:room.images!.first,
                                                title: room.name.toString(),
                                                subTitle: room.announcement,
                                                active: room.activeUsers?.length.toString()??'0',
                                                onTap: (){
                                                  value.joinRoom(room);
                                                },
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
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 18 * a),
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
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }else {
                            return
                              SmartRefresher(
                                enablePullDown: true,
                                header: WaterDropMaterialHeader(distance: 36*a),
                                onRefresh: ()async{
                                  await Future.delayed(const Duration(milliseconds: 500),() {
                                    setState(() {});
                                  });
                                  refreshController3.refreshCompleted();
                                  return;
                                },
                                physics: const BouncingScrollPhysics(),
                                controller: refreshController3,
                              child: ListView.builder(
                                itemCount: snapshot.data?.data?.length??0,
                                  itemBuilder: (context, index) {
                                  final room = snapshot.data!.data![index];
                                    return roomListTile(
                                      image: room.images!.isEmpty?null:room.images!.first,
                                      title: room.name.toString(),
                                      subTitle: room.announcement,
                                      active: room.activeUsers?.length.toString()??'0',
                                      onTap: (){
                                        value.joinRoom(room);
                                      },
                                    );
                                  },
                              ),
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
    provider.getAllMine();
  }
}
