import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/screens/dashboard/moments/moments.dart';
import 'package:live_app/subscreens/agency/agency.dart';
import 'package:live_app/subscreens/aristrocracy/tab_bar.dart';
import 'package:live_app/subscreens/help&Feedback/appbar_feedback.dart';
import 'package:live_app/subscreens/payment.dart';
import 'package:live_app/subscreens/scree/homescreens/homeScreen.dart';
import 'package:live_app/subscreens/scree/homescreens/moments_page.dart';
import 'package:live_app/subscreens/scree/livePriveleges.dart';
import 'package:live_app/subscreens/shop/shop.dart';
import 'package:live_app/subscreens/wallet_U/security_pannel.dart';
import 'package:live_app/subscreens/wallet_U/svip.dart';
import 'package:live_app/subscreens/wallet_U/wall.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../../subscreens/tasks/dailyTask.dart';
import '../../../utils/helper.dart';
import '../../club/club_page.dart';
import '../home/usefun_clubs.dart';
import 'settings.dart';

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  final List<Map> list = [
    {
      "icon": "assets/icons/ic_moment.png",
      "title": "My moment",
      "onTap": () {
        Get.to(() => const MomentsPage(appBar: true));
      }
    },
    {
      "icon": "assets/icons/ic_mywallet.png",
      "title": "My Live Wallet",
      "onTap": () {
        Get.to(() => const Wallet());
      }
    },
    {
      "icon": "assets/icons/ic_person.png",
      "title": "Agency Center",
      "onTap": () {
        Get.to(() => const AgencyTab());
      }
    },
    {
      "icon": "assets/icons/ic_person.png",
      "title": "Diamond Seller",
      "onTap": () {
        Get.to(() => const Paym());
      }
    },
    {
      "icon": "assets/icons/ic_person.png",
      "title": "Security Pannel",
      "onTap": () {
        Get.to(() => const SecurityPannel());
      }
    },
    {
      "icon": "assets/icons/ic_aristocracy.png",
      "title": "Aristocracy",
      "onTap": () {
        Get.to(() => const TabsBar());
      }
    },
    {
      "icon": "assets/icons/ic_star.png",
      "title": "Svip",
      "onTap": () {
        Get.to(() => const Svip());
      }
    },
    {
      "icon": "assets/icons/ic_shop.png",
      "title": "Shop",
      "onTap": () {
        Get.to(() => const Shop());
      }
    },
    {
      "icon": "assets/icons/ic_level_up.png",
      "title": "Live Level",
      "onTap": () {
        Get.to(() => const LivePrivleges());
      }
    },
    {
      "icon": "assets/icons/ic_calender.png",
      "title": "Dialy Task",
      "onTap": () {
        Get.to(() => const DailyTask());
      }
    },
    {
      "icon": "assets/icons/ic_querry.png",
      "title": "Help Center & Feedback",
      "onTap": () {
        Get.to(() => const AppbarFeedBack());
      }
    },
    {
      "icon": "assets/icons/ic_settings.png",
      "title": "Settings",
      "onTap": () {
        Get.to(() => const Settings());
      }
    }
  ];
  UserDataProvider providerUserData = UserDataProvider();
  @override
  Widget build(BuildContext context) {
    providerUserData = Provider.of<UserDataProvider>(context);
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
                Icons.people_outline,
                color: Colors.black,
                size: 18 * a,
              ),
            ),
            Expanded(
                child: Text('Me',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 20 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.8 * a,
                      color: const Color(0xff000000),
                    ))),
            Image.asset(
              'assets/icons/ic_share.png',
              color: Colors.black,
              height: 18 * a,
              width: 18 * a,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0 * a,
                    child: Container(
                        width: 360 * a,
                        height: 279 * a,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/bgr.png'),
                              fit: BoxFit.cover),
                        ))),
                Positioned(
                    top: 15 * a,
                    left: 20 * a,
                    child: Text(
                      'You had Complete 50% Profile\nInformation',
                      textAlign: TextAlign.left,
                      style: SafeGoogleFont(
                          color: const Color.fromRGBO(0, 0, 0, 0.6000000238418579),
                          'Poppins',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )),
                Positioned(
                  top: 50 * a,
                  left: 10 * a,
                  child: Container(
                    padding:
                        EdgeInsets.fromLTRB(9 * a, 12.5 * a, 9 * a, 14.5 * a),
                    width: 70 * a,
                    height: 78.86 * a,
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
                  top: 50 * a,
                  left: 10 * a,
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
                  ),
                ),
                Positioned(
                    top: 70 * a,
                    left: 90 * a,
                    child: Text(
                      providerUserData.userData?.data?.name??'null',
                      textAlign: TextAlign.left,
                      style: SafeGoogleFont(
                          color: const Color.fromRGBO(0, 0, 0, 0.6000000238418579),
                          'Poppins',
                          fontSize: 14,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                          height: 1),
                    )),
                Positioned(
                    top: 90 * a,
                    left: 90 * a,
                    child: Text(
                      'View Or Edit Your Profile',
                      textAlign: TextAlign.left,
                      style: SafeGoogleFont(
                          color: const Color.fromRGBO(0, 0, 0, 0.6000000238418579),
                          'Poppins',
                          fontSize: 14,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w300,
                          height: 1),
                    )),
                Positioned(
                  top: 72 * a,
                  right: 12 * a,
                  child: InkWell(
                      onTap: () {
                        Get.to(() => const Homescreens());
                      },
                      child: const Icon(Icons.arrow_forward_ios_outlined)),
                ),
                Positioned(
                  top: 150 * a,
                  left: 20 * a,
                  child: Row(
                    children: [
                      Text(
                        'ID: ${providerUserData.userData?.data?.userId.toString()}',
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 10 * a,
                            fontWeight: FontWeight.normal,
                            height: 1 * a),
                      ),
                      SizedBox(width: 10 * a),
                      Container(
                          width: 27 * a,
                          height: 11 * a,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(217, 217, 217, 1),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              width: 1 * b / a,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Copy',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Poppins',
                                fontSize: 7 * a,
                                letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1 * b / a,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Positioned(
                  top: 175 * a,
                  left: 20 * a,
                  child: SizedBox(
                      width: 291.00054931640625,
                      height: 40,
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
                Positioned(
                  top: 215 * a,
                  left: 10 * a,
                  child: SizedBox(
                      width: 65 * a,
                      height: 17 * a,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0 * a,
                            left: 0 * a,
                            child: Container(
                                width: 65 * a,
                                height: 17 * a,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/lv.png'),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 6 * a,
                            left: 28 * a,
                            child: Text(
                              'Lv.${providerUserData.userData?.data?.level}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Poppins',
                                fontSize: 8 * a,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1 * a,
                              ),
                            )),
                      ])),
                ),
                Positioned(
                  top: 218 * a,
                  left: 80 * a,
                  child: Container(
                      height: 14 * a,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12 * a),
                          topRight: Radius.circular(12 * a),
                          bottomLeft: Radius.circular(12 * a),
                          bottomRight: Radius.circular(12 * a),
                        ),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(width: 3*a),
                            Icon(providerUserData.userData?.data?.gender!.toLowerCase() == 'male' ? Icons.male : Icons.female, size: 10 * a,),
                            SizedBox(width: 3*a),
                            Text(AgeCalculator.calculateAge(providerUserData.userData?.data?.dob??DateTime.now()).toString(),style: TextStyle(fontSize: 8 * a),),
                            SizedBox(width: 4*a)
                          ])),
                ),
                Positioned(
                  top: 218 * a,
                  left: 126 * a,
                  child: Container(
                    width: 25 * a,
                    height: 14 * a,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/flag.png'),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                Positioned(
                  top: 229 * a,
                  left: 17 * a,
                  child: Container(
                    width: 50 * a,
                    height: 45 * a,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/official_bd.png'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
                Positioned(
                  top: 225 * a,
                  left: 77 * a,
                  child: Container(
                    width: 50 * a,
                    height: 45 * a,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/seller.png'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
                Positioned(
                  top: 225 * a,
                  left: 137 * a,
                  child: Container(
                    width: 50 * a,
                    height: 45 * a,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/uf.png'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
                Positioned(
                  top: 225 * a,
                  left: 197 * a,
                  child: Container(
                    width: 55 * a,
                    height: 45 * a,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/agency.png'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
                Positioned(
                  top: 225 * a,
                  left: 257 * a,
                  child: Container(
                    width: 55 * a,
                    height: 45 * a,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/official.png'),
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
                if(providerUserData.userData?.data?.club == null) Padding(
                  padding: EdgeInsets.only(top: 290 * a,left: 10 * a,right: 12 * a),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>const UsefunsClub());
                    },
                    child: Container(
                      height: 54 * a,
                      color: const Color(0xFFFEA42C),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0*a),
                            child: Image.asset('assets/usefun_club.png'),
                          ),
                          const Text('Join Usefuns club now to make\nmore Friends',style: TextStyle(color: Colors.white)),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white),
                          SizedBox(width: 10*a)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: providerUserData.userData?.data?.club != null ?260 * a:320 * a),
                  child: Column(
                    children: [
                      SizedBox(height: 24 * a),
                      for (Map m in list)
                        Container(
                          margin: EdgeInsets.only(
                              top: 14 * a, left: 10 * a, right: 50 * a),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                m['icon'],
                                fit: BoxFit.cover,
                                width: 16 * a,
                                height: 16 * a,
                              ),
                              SizedBox(width: 11 * a),
                              InkWell(
                                onTap: m["onTap"],
                                child: Text(
                                  m['title'],
                                  textAlign: TextAlign.left,
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 16 * b,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.48 * a,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 30 * a),
                    ],
                  ),
                ),

                // SizedBox(height: 3 * a),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Column(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.fromLTRB(
                //               13 * a, 16 * a, 11 * a, 17.86 * a),
                //           width: 70 * a,
                //           height: 78.86 * a,
                //           decoration: const BoxDecoration(
                //             image: DecorationImage(
                //               fit: BoxFit.cover,
                //               image: AssetImage(
                //                   'assets/decoration/recharge_agent.png'),
                //             ),
                //           ),
                //           child: CircleAvatar(
                //             foregroundImage: const AssetImage(
                //               'assets/dummy/b3.png',
                //             ),
                //             radius: 23 * a,
                //           ),
                //         ),
                //         SizedBox(height: 22 * a),
                //       ],
                //     ),
                //     SizedBox(width: 11 * a),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           children: [
                //             Text(
                //               '876665',
                //               textAlign: TextAlign.left,
                //               style: SafeGoogleFont(
                //                 'Poppins',
                //                 fontSize: 16 * b,
                //                 fontWeight: FontWeight.w400,
                //                 height: 1.5 * b / a,
                //                 letterSpacing: 0.64 * a,
                //                 color: const Color(0xff000000),
                //               ),
                //             ),
                //             SizedBox(
                //               width: 10 * a,
                //             ),
                //             Container(
                //               height: 15 * a,
                //               width: 41 * a,
                //               padding: EdgeInsets.all(1 * a),
                //               decoration: BoxDecoration(
                //                   border:
                //                       Border.all(color: Colors.black, width: 1)),
                //               child: Center(
                //                 child: InkWell(
                //                   onTap: () {
                //                     FlutterClipboard.copy('876665');
                //                     ScaffoldMessenger.of(context).showSnackBar(
                //                       const SnackBar(
                //                         content: Text('Text copied to clipboard'),
                //                       ),
                //                     );
                //                   },
                //                   child: Text(
                //                     'Copy',
                //                     style: SafeGoogleFont(
                //                       'Poppins',
                //                       fontSize: 9 * b,
                //                       fontWeight: FontWeight.w400,
                //                       height: 1.5 * b / a,
                //                       letterSpacing: 0.32 * a,
                //                       color: Colors.black,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //         Text(
                //           'View Or Edit Your Profile',
                //           textAlign: TextAlign.left,
                //           style: SafeGoogleFont(
                //             'Poppins',
                //             fontSize: 9 * b,
                //             fontWeight: FontWeight.w400,
                //             height: 1.5 * b / a,
                //             letterSpacing: 0.36 * a,
                //             color: const Color(0x99000000),
                //           ),
                //         ),
                //         SizedBox(height: 18 * a),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             RichText(
                //               textAlign: TextAlign.center,
                //               text: TextSpan(children: [
                //                 TextSpan(
                //                   text: '0',
                //                   style: SafeGoogleFont(
                //                     'Poppins',
                //                     fontSize: 12 * b,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1.5 * b / a,
                //                     letterSpacing: 0.36 * a,
                //                     color: const Color(0xff000000),
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '\nFollowers',
                //                   style: SafeGoogleFont(
                //                     'Poppins',
                //                     fontSize: 9 * b,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1.5 * b / a,
                //                     letterSpacing: 0.36 * a,
                //                     color: const Color(0x99000000),
                //                   ),
                //                 )
                //               ]),
                //             ),
                //             SizedBox(width: 17 * a),
                //             RichText(
                //               textAlign: TextAlign.center,
                //               text: TextSpan(children: [
                //                 TextSpan(
                //                   text: '0',
                //                   style: SafeGoogleFont(
                //                     'Poppins',
                //                     fontSize: 12 * b,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1.5 * b / a,
                //                     letterSpacing: 0.36 * a,
                //                     color: const Color(0xff000000),
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '\nFollowing',
                //                   style: SafeGoogleFont(
                //                     'Poppins',
                //                     fontSize: 9 * b,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1.5 * b / a,
                //                     letterSpacing: 0.36 * a,
                //                     color: const Color(0x99000000),
                //                   ),
                //                 )
                //               ]),
                //             ),
                //             SizedBox(width: 27 * a),
                //             RichText(
                //               textAlign: TextAlign.center,
                //               text: TextSpan(children: [
                //                 TextSpan(
                //                   text: '0',
                //                   style: SafeGoogleFont(
                //                     'Poppins',
                //                     fontSize: 12 * b,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1.5 * b / a,
                //                     letterSpacing: 0.36 * a,
                //                     color: const Color(0xff000000),
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '\nLikes',
                //                   style: SafeGoogleFont(
                //                     'Poppins',
                //                     fontSize: 9 * b,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1.5 * b / a,
                //                     letterSpacing: 0.36 * a,
                //                     color: const Color(0x99000000),
                //                   ),
                //                 )
                //               ]),
                //             ),
                //             SizedBox(width: 20 * a),
                //             RichText(
                //               textAlign: TextAlign.center,
                //               text: TextSpan(children: [
                //                 TextSpan(
                //                   text: '1',
                //                   style: SafeGoogleFont(
                //                     'Poppins',
                //                     fontSize: 12 * b,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1.5 * b / a,
                //                     letterSpacing: 0.36 * a,
                //                     color: const Color(0xff000000),
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '\nVisitors',
                //                   style: SafeGoogleFont(
                //                     'Poppins',
                //                     fontSize: 9 * b,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1.5 * b / a,
                //                     letterSpacing: 0.36 * a,
                //                     color: const Color(0x99000000),
                //                   ),
                //                 )
                //               ]),
                //             ),
                //           ],
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                // SizedBox(height: 6 * a),
                // Row(
                //   children: [
                //     Container(
                //       height: 14 * a,
                //       width: 49 * a,
                //       color: const Color(0xFF4285F4),
                //       child: Center(
                //         child: Row(
                //           mainAxisSize: MainAxisSize.min,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Image.asset(
                //               'assets/room_icons/blue_diamond.png',
                //               fit: BoxFit.cover,
                //               width: 11 * a,
                //               height: 11 * a,
                //             ),
                //             SizedBox(width: 7 * a),
                //             Text(
                //               'Lv.0',
                //               style: SafeGoogleFont(
                //                 'Poppins',
                //                 fontSize: 11 * b,
                //                 fontWeight: FontWeight.w400,
                //                 height: 1.5 * b / a,
                //                 letterSpacing: 0.32 * a,
                //                 color: const Color(0xffffffff),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 8 * a),
                //     Container(
                //       height: 14 * a,
                //       width: 42 * a,
                //       padding: EdgeInsets.all(1 * a),
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.black, width: 1)),
                //       child: Center(
                //         child: Row(
                //           mainAxisSize: MainAxisSize.min,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Icon(Icons.male, size: 12 * a),
                //             Text(
                //               ' 26',
                //               style: SafeGoogleFont(
                //                 'Poppins',
                //                 fontSize: 9 * b,
                //                 fontWeight: FontWeight.w400,
                //                 height: 1.5 * b / a,
                //                 letterSpacing: 0.32 * a,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 8 * a),
                //     Image.asset(
                //       'assets/icons/flag_india.png',
                //       fit: BoxFit.cover,
                //       width: 19 * a,
                //       height: 13 * a,
                //     )
                //   ],
                // ),
                // SizedBox(height: 12 * a),
                // Container(
                //   color: const Color(0xFFFEA42C),
                //   width: double.infinity,
                //   child: Row(
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.all(9 * a),
                //         child: Image.asset('assets/usefun_club.png',
                //             height: 30 * a, width: 30 * a, fit: BoxFit.cover),
                //       ),
                //       Expanded(
                //           child: Text(
                //         'Join Usefuns now to make more Friends',
                //         style: SafeGoogleFont(
                //           'Poppins',
                //           fontSize: 12 * b,
                //           fontWeight: FontWeight.w400,
                //           height: 1.5 * b / a,
                //           letterSpacing: 0.48 * a,
                //           color: Colors.white,
                //         ),
                //       ))
                //     ],
                //   ),
                // ),
                // SizedBox(height: 14 * a),
              ],
            ),
          ],
        ),
      ),
    );
  }

  columnPairWidget(String top, String below) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          top,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Poppins',
              fontSize: 12,
              letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        const Spacer(flex:2),
        Text(
          below,
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Poppins',
              fontSize: 9,
              letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
        const Spacer(),
      ],
    );
  }
}
