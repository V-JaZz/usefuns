import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/screens/dashboard/home/home.dart';
import 'package:live_app/screens/room/live_room.dart';
import 'package:live_app/utils/common_widgets.dart';
import 'package:provider/provider.dart';
import '../../provider/user_data_provider.dart';
import '../../provider/zego_room_provider.dart';
import 'game/games.dart';
import 'me/me.dart';
import 'message/notifications.dart';
import 'moments/moments.dart';

class BottomNavigator extends StatefulWidget {
  static String routeName = "/BottomNavigator";
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  Timer? timer;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    // Games(),
    Notifications(),
    // Moments(),
    Me(),
  ];

  late UserDataProvider userDataProvider;

  @override
  void initState() {
    _fetchUserData(refresh: false, initLoad: true);
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _fetchUserData(refresh: false);
    });
    Provider.of<RoomsProvider>(context, listen: false).getBannerList();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    final zp = Provider.of<ZegoRoomProvider>(context,listen:false);
    if(zp.room != null)zp.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    return Scaffold(
        body: Consumer<UserDataProvider>(
          builder: (context, value, child) => Center(
            child: value.isUserDataLoading
                ? const CircularProgressIndicator(color: Color(0xff9e26bc))
                : (value.userData?.status == 1
                    ? _widgetOptions.elementAt(_selectedIndex)
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Error loading data!',
                              style: TextStyle(color: Colors.black)),
                          const SizedBox(height: 15),
                          ElevatedButton(
                              onPressed: _fetchUserData,
                              child: const Text('Retry'))
                        ],
                      )),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(248, 188, 187, 187),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: GNav(
            style: GnavStyle.oldSchool,
            rippleColor: Colors.black45,
            hoverColor: Colors.black45,
            textStyle: TextStyle(fontSize: 12 * a),
            iconSize: 18 * a,
            gap: 0,
            padding: EdgeInsets.all(6 * a),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            tabMargin: EdgeInsets.zero,
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.transparent,
            backgroundColor: const Color(0xff9e26bc),
            tabs: const [
              GButton(
                text: 'Home',
                icon: Icons.home,
                iconColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
              // GButton(
              //   text: 'Games',
              //   icon: Icons.gamepad,
              //   iconColor: Colors.black,
              //   iconActiveColor: Colors.black,
              // ),
              GButton(
                text: 'Message',
                icon: Icons.message,
                iconColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
              // GButton(
              //   text: 'Moments',
              //   icon: Icons.timelapse,
              //   iconColor: Colors.black,
              //   iconActiveColor: Colors.black,
              // ),
              GButton(
                text: 'Me',
                icon: Icons.person,
                iconColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              if (index != _selectedIndex) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
          ),
        ),
        floatingActionButton:
        Consumer<ZegoRoomProvider>(builder: (context, value, child) {
          if(!value.minimized) return const SizedBox.shrink();
          bool roomIcon = value.room!.images!.isNotEmpty;
          return FloatingActionButton(
              tooltip: 'Goto Room',
              child: Stack(
                children: [
                  if (roomIcon)
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    value.room?.images?.first ?? ''
                                )
                            ),
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  Center(
                      child: SizedBox(
                          height: 30,
                          width: 40,
                          child:
                              WaveAnimation(color: roomIcon ? Colors.white : null))),
                ],
              ),
              onPressed: () {
                value.minimized = false;
                value.broadcastMessageList?.clear();
                Get.to(const LiveRoom());
              });
        })
    );
  }

  Future<void> _fetchUserData({bool refresh = true, bool initLoad = false}) async {
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    await userDataProvider.getUser(loading: refresh);
    if(initLoad) Provider.of<RoomsProvider>(Get.context!,listen: false).selectedCountryCode = Provider.of<UserDataProvider>(Get.context!,listen: false).userData?.data?.countryCode??'All';
  }
}
