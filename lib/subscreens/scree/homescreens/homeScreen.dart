import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/subscreens/scree/homescreens/honor.dart';
import 'package:live_app/subscreens/scree/loverspage.dart';
import 'package:live_app/subscreens/scree/homescreens/moments_page.dart';
import 'package:live_app/subscreens/scree/homescreens/profile_screen.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_data_provider.dart';
import '../../../screens/dashboard/me/update_profile.dart';
import '../../../utils/helper.dart';

class Homescreens extends StatefulWidget {
  const Homescreens({super.key});

  @override
  State<Homescreens> createState() => _HomescreensState();
}

class _HomescreensState extends State<Homescreens> {
  UserDataProvider providerUserData = UserDataProvider();
  @override
  Widget build(BuildContext context) {
    providerUserData = Provider.of<UserDataProvider>(context);
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 321 * a,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/1.png",
                  ),
                  fit: BoxFit.fitWidth),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 5,
                    right: 5 * a,
                    child: Image.asset('assets/dots.png')),
                Positioned(
                  top: 43 * a,
                  left: 12 * a,
                  child: Container(
                    padding:
                    EdgeInsets.fromLTRB(13 * a, 16 * a, 11 * a, 17.86 * a),
                    width: 70 * a,
                    height: 78.86 * a,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                        AssetImage('assets/decoration/recharge_agent.png'),
                      ),
                    ),
                    child: providerUserData.userData!.data!.images!.isEmpty
                        ? CircleAvatar(
                        foregroundImage: const AssetImage('assets/profile.png'),
                        radius: 23 * a)
                        :CircleAvatar(
                        foregroundImage: NetworkImage(providerUserData.userData?.data?.images?.first??''),
                        radius: 23 * a),
                  ),
                ),
                Positioned(
                  top: 129 * a,
                  left: 8 * a,
                  child: Row(
                    children: [
                      Text(
                        providerUserData.userData?.data?.name?.toUpperCase()??'',
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            'Poppins',
                            fontSize: 16 * a,
                            fontWeight: FontWeight.normal,
                            height: 1 * a),
                      ),
                      SizedBox(width: 12*a),
                      InkWell(
                        onTap: (){
                          Get.to(()=>const UpdateProfile());
                        },
                        child: Container(
                            color:Colors.white, child:
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.edit,color: const Color(0xff9e26bc),size: 12*a),
                        )),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 151 * a,
                  left: 8 * a,
                  child: Text(
                    providerUserData.userData?.data?.userId??'',
                    textAlign: TextAlign.left,
                    style: SafeGoogleFont(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        'Poppins',
                        fontSize: 11 * a,
                        fontWeight: FontWeight.w300,
                        height: 1 * a),
                  ),
                ),
                Positioned(
                    top: 172 * a,
                    left: 8 * a,
                    child: Image.asset("assets/4.png")),
                Positioned(
                    top: 172 * a,
                    left: 70 * a,
                    child: Image.asset("assets/5.png")),
                Positioned(
                    top: 172 * a,
                    left: 135 * a,
                    child: Image.asset("assets/6.png")),
                Positioned(
                  top: 207 * a,
                  left: 6 * a,
                  child: SizedBox(
                      width: 70 * a,
                      height: 80 * a,
                      child: Image.asset("assets/lv.png")),
                ),
                Positioned(
                  top: 240 * a,
                  left: 31 * a,
                  child: SizedBox(
                    child: Text(
                      'LV. ${providerUserData.userData?.data?.level}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                  top: 241 * a,
                  left: 80 * a,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10 * a),
                      color: Colors.white,
                    ),
                    width: 39 * a,
                    height: 14 * a,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          providerUserData.userData?.data?.gender!.toLowerCase() == 'male' ? Icons.male : Icons.female,
                          color: providerUserData.userData?.data?.gender!.toLowerCase() == 'male' ? Colors.indigo : Colors.pink,
                          size: 14 * a,
                        ),
                        Text(AgeCalculator.calculateAge(providerUserData.userData?.data?.dob??DateTime.now()).toString(),style: TextStyle(fontSize: 11 * b),)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 234 * a,
                  left: 134 * a,
                  child: SizedBox(
                      width: 21 * a,
                      height: 30 * a,
                      child: Image.asset("assets/flag.png")),
                ),
                Positioned(
                  top: 265 * a,
                  left: 10 * a,
                  child: SizedBox(
                      width: 232 * a,
                      height: 40 * a,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            columnPairWidget(providerUserData.userData?.data?.followers?.length.toString()??'0','Followers'),
                            columnPairWidget(providerUserData.userData?.data?.following?.length.toString()??'0','Following'),
                            columnPairWidget(providerUserData.userData?.data?.likes.toString()??'0','Likes'),
                            columnPairWidget(providerUserData.userData?.data?.views.toString()??'0','Visitors'),
                          ])
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ContainedTabBarView(
              tabs: [
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 10 * a),
                ),
                Text(
                  'Relationship',
                  style: TextStyle(fontSize: 10 * a),
                ),
                Text(
                  'Honour',
                  style: TextStyle(fontSize: 10 * a),
                ),
                Text(
                  'Moments',
                  style: TextStyle(fontSize: 10 * a),
                ),
              ],
              views: const [
                Prof(),
                Lovers(),
                HomeScreen(),
                MomentsPage(appBar: false),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.search,
      //         color: Colors.black,
      //       ),
      //       label: "Find me",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.person,
      //         color: Colors.blue,
      //       ),
      //       label: "Profile",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.messenger_outline_rounded,
      //         color: Colors.purple,
      //       ),
      //       label: "Chat",
      //     ),
      //   ],
      //   // currentIndex: _selectedIndex,
      //   // selectedItemColor: Colors.amber[800],
      //   // onTap: _onItemTapped,
      // ),
    );
  }

  columnPairWidget(String top, String below) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        Text(
          top,
          textAlign: TextAlign.left,
          style: SafeGoogleFont(
              color: const Color.fromRGBO(255, 255, 255, 1),
              'Poppins',
              fontSize: 12 * a,
              letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1 * b / a)
        ),
        const Spacer(flex:3),
        Text(
          below,
          textAlign: TextAlign.left,
          style: SafeGoogleFont(
              color: const Color.fromRGBO(255, 255, 255, 1),
              'Poppins',
              fontSize: 11 * a,
              letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1 * b / a),
        ),
        const Spacer(),
      ],
    );
  }
}
