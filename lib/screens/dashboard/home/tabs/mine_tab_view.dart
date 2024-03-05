import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../provider/rooms_provider.dart';
import '../../../../utils/common_widgets.dart';
import '../../../room/widget/pre_loading_dailog.dart';
import '../create_room.dart';

class MineTabView extends StatefulWidget {
  const MineTabView({super.key});

  @override
  State<MineTabView> createState() => _MineTabViewState();
}

class _MineTabViewState extends State<MineTabView> {
  RefreshController refreshController = RefreshController();

  @override
  void dispose() {
  refreshController.dispose();
  super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SmartRefresher(
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
                        style: safeGoogleFont(
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
                        style: safeGoogleFont(
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
                        Get.dialog(RoomPreLoadingDialog(room: room),barrierDismissible: false);
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
                        style: safeGoogleFont(
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
                        style: safeGoogleFont(
                          'Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: const Color(0x99000000),
                        ),
                      ),
                      trailing: room.isLocked == true
                          ? Icon(Icons.lock, color: Colors.grey.shade600, size: 18*a)
                          : null,
                    ),
                  );
                }
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
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 18 * a, right: 18 * a, top: 8 * a),
                                child:
                                Consumer<RoomsProvider>(
                                  builder: (context, value, child) => FutureBuilder(
                                    future: value.getAllMyRecent(),
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.waiting && value.recentRooms.isEmpty){
                                        return const Center(child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(height: 18),
                                            Text('Loading'),
                                          ],
                                        ));
                                      }
                                      else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if(value.recentRooms.isEmpty){
                                        return const Center(child: Text('No Recent Rooms!'));
                                      } else {
                                        return ListView(
                                            children: List.generate(value.recentRooms.length, (index) {
                                              final room = value.recentRooms[index];
                                              return roomListTile(
                                                image: room.images!.isEmpty?null:room.images!.first,
                                                title: room.name.toString(),
                                                subTitle: room.announcement,
                                                iso: room.countryCode,
                                                active: room.activeUsers?.length.toString()??'0',
                                                isLocked: room.isLocked??false,
                                                onTap: (){
                                                  Get.dialog(RoomPreLoadingDialog(room: room),barrierDismissible: false);
                                                },
                                              );
                                            })
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              viewUsersByIds(Provider.of<UserDataProvider>(context,listen: false).userData?.data?.following),
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
                                                  iso: room.countryCode,
                                                  active: room.activeUsers?.length.toString()??'0',
                                                  isLocked: room.isLocked??false,
                                                  onTap: (){
                                                    Get.dialog(RoomPreLoadingDialog(room: room),barrierDismissible: false);
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
      );
  }
}
