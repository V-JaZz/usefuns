import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:live_app/data/datasource/local/sharedpreferences/storage_service.dart';
import 'package:live_app/provider/moments_provider.dart';
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
    Games(),
    Notifications(),
    Moments(),
    Me(),
  ];

  late UserDataProvider userDataProvider;

  @override
  void initState() {
    checkReward();
    _fetchUserData(refresh: false);
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _fetchUserData(refresh: false);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
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
              GButton(
                text: 'Games',
                icon: Icons.gamepad,
                iconColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
              GButton(
                text: 'Message',
                icon: Icons.message,
                iconColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
              GButton(
                text: 'Moments',
                icon: Icons.timelapse,
                iconColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
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
                switch (index) {
                  case 0:
                    print('Home');
                    break;
                  case 1:
                    print('Games');
                    break;
                  case 2:
                    print('Message');
                    break;
                  case 3:
                    print('Moments');
                    break;
                  case 4:
                    print('Me');
                    break;
                }
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
          ),
        ),
        floatingActionButton:
        Consumer<ZegoRoomProvider>(builder: (context, value, child) {
          if(value.room==null) return const SizedBox.shrink();
          bool roomIcon = value.room!.images!.isNotEmpty;
          return FloatingActionButton(
              isExtended: true,
              child: Stack(
                children: [
                  if (roomIcon)
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    value.room?.images?.first ?? '')),
                            borderRadius: BorderRadius.circular(15))),
                  Center(
                      child: SizedBox(
                          height: 30,
                          width: 40,
                          child:
                              WaveAnimation(color: roomIcon ? Colors.white : null))),
                ],
              ),
              onPressed: () {
                Get.to(const LiveRoom());
              });
        })
    );
  }

  Future<void> _fetchUserData({bool refresh = true}) async {
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    await userDataProvider.getUser(refresh: refresh);
  }

  void checkReward() {
    if (StorageService().getBool('NEW_USER')) {
      StorageService().setBool('NEW_USER', false);
      Future.delayed(
          const Duration(seconds: 2),
          () => rewardDialog('assets/frame_early_access.png', 'Free Frame',
                  'Congratulations, you have been\nrewarded free frame as you are\njoining in early access period.',
                  () {
                Get.back();
                Future.delayed(
                    const Duration(seconds: 2),
                    () => rewardDialog(
                            'assets/room_bg_early_access.jpg',
                            'Free Room Theme',
                            'Congratulations, you have been\nrewarded free room theme as you\nare joining in early access period.',
                            () {
                          Get.back();
                          Future.delayed(
                              const Duration(seconds: 2),
                              () => rewardDialog(
                                      'assets/icons/ic_diamond.png',
                                      'Free 100 Diamonds',
                                      'Congratulations, you have been\nrewarded free 100 diamonds as you\nare joining in early access period.',
                                      () {
                                    Get.back();
                                  }));
                        }));
              }));
    }
  }
}
