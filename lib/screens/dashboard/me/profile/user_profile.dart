import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/me/profile/profile_tab_view.dart';
import 'package:live_app/subscreens/scree/homescreens/honor.dart';
import 'package:live_app/screens/dashboard/me/profile/relationship_tab_view.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/user_data_model.dart';
import '../../../../provider/user_data_provider.dart';
import 'moments_page.dart';
import 'update_profile.dart';
import '../../../../utils/common_widgets.dart';
import '../../../../utils/helper.dart';

class UserProfile extends StatefulWidget {
  final UserData? userData;
  const UserProfile({super.key, this.userData});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserData user;
  late bool isMine;

  @override
  Widget build(BuildContext context) {
    if(widget.userData == null) {
      user = Provider.of<UserDataProvider>(context).userData!.data!;
      isMine = true;
    }else{
      user = widget.userData!;
      isMine = false;
    }

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
            padding: EdgeInsets.all(8*a),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/decoration/profile_bg.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){Get.back();},
                      child: const Icon(CupertinoIcons.back,color: Colors.white),
                    ),
                    Image.asset('assets/dots.png',width: 24*a),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12*a),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70 * a,
                        height: 70 * a,
                        margin: EdgeInsets.only(top:9*a,bottom: 18*a),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 3*a),
                            shape: BoxShape.circle
                          // image: DecorationImage(
                          //   fit: BoxFit.cover,
                          //   image:
                          //   AssetImage('assets/decoration/recharge_agent.png'),
                          // ),
                        ),
                        child: user.images!.isEmpty
                            ? CircleAvatar(
                            foregroundImage: const AssetImage('assets/profile.png'),
                            radius: 30 * a)
                            :CircleAvatar(
                            foregroundImage: NetworkImage(user.images?.first??''),
                            radius: 30 * a),
                      ),
                      Row(
                        children: [
                          Text(
                            user.name??'',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                'Poppins',
                                fontSize: 16 * a,
                                fontWeight: FontWeight.normal,
                                height: 1 * a),
                          ),
                          SizedBox(width: 12*a),
                          if(isMine)InkWell(
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
                      SizedBox(height: 6*a),
                      Text(
                        user.userId??'',
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            'Poppins',
                            fontSize: 11 * a,
                            fontWeight: FontWeight.w300,
                            height: 1 * a),
                      ),
                      if(user.badges!.isNotEmpty)SizedBox(height: 6*a),
                      Row(
                          children:
                          List.generate(user.badges?.length??0, (index) =>
                              SizedBox(
                                  width: 70 * a,
                                  height: 80 * a,
                                  child: Image.network(user.badges![index]!)),
                          )
                      ),
                      SizedBox(height: 6*a),
                      Row(
                        children: [
                          userLevelTag(user.level??0,15 * a,viewZero: true),
                          SizedBox(width: 9*a),
                          Container(
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
                                  user.gender!.toLowerCase() == 'male' ? Icons.male : Icons.female,
                                  color: user.gender!.toLowerCase() == 'male' ? Colors.indigo : Colors.pink,
                                  size: 14 * a,
                                ),
                                Text(AgeCalculator.calculateAge(user.dob??DateTime.now()).toString(),style: TextStyle(fontSize: 11 * b),)
                              ],
                            ),
                          ),
                          SizedBox(width: 9*a),
                          SizedBox(
                              width: 21 * a,
                              height: 30 * a,
                              child: Image.asset("assets/flag.png")),
                        ],
                      ),
                      SizedBox(height: 8*a),
                      Container(
                          width: double.infinity,
                          height: 40 * a,
                          padding: EdgeInsets.symmetric(horizontal: 8*a),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                columnPairWidget(user.followers?.length.toString()??'0','Followers'),
                                columnPairWidget(user.following?.length.toString()??'0','Following'),
                                columnPairWidget(user.likes.toString()??'0','Likes'),
                                columnPairWidget(user.views.toString()??'0','Visitors'),
                              ])
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child:ContainedTabBarView(
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
              views: [
                ProfileTabView(userData: user),
                const RelationshipTabView(),
                const HomeScreen(),
                MomentsPage(appBar: false,userId: widget.userData?.id),
              ],
            )
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
