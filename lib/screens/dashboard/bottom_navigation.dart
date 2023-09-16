import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:live_app/provider/moments_provider.dart';
import 'package:live_app/screens/dashboard/home/home.dart';
import 'package:provider/provider.dart';

import '../../provider/user_data_provider.dart';
import '../../utils/network_util.dart';
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
    _fetchUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      body: Consumer<UserDataProvider>(
        builder: (context, value, child) => Center(
          child: value.isLoading
              ?const CircularProgressIndicator(color:  Color(0xff9e26bc))
              :(value.userData?.status == 1 ? _widgetOptions.elementAt(_selectedIndex) : Column(
            mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Error loading data!',style: TextStyle(color: Colors.black)),
                  const SizedBox(height: 15),
                  ElevatedButton(onPressed: _fetchUserData, child: const Text('Retry'))
                ],
              ) ),
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
            if(index!=_selectedIndex){
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
                  _fetchAllMoments();
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
    );
  }

  Future<void> _fetchUserData() async {
    userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    await userDataProvider.getUser();
  }

  Future<void> _fetchAllMoments() async {
    final momentsProvider = Provider.of<MomentsProvider>(context, listen: false);
    if((userDataProvider.userData?.data?.following?.toString()??'[]') != '[]') {
      momentsProvider.emptyFollowings = false;
      await momentsProvider.getFollowingMoments();
    }
  }
}
