import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/screens/dashboard/me/profile/moments_page.dart';
import 'package:live_app/screens/dashboard/me/settings/settings.dart';
import 'package:live_app/screens/dashboard/me/shop/shop.dart';
import 'package:live_app/screens/dashboard/me/wallet/wallet.dart';
import 'package:live_app/screens/dashboard/me/diamond_seller/diamond_seller.dart';
import 'package:live_app/screens/dashboard/me/profile/user_profile.dart';
import 'package:live_app/screens/dashboard/me/levelPriveleges.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/helper.dart';
import 'agency/agency.dart';
import 'help&Feedback/appbar_feedback.dart';
import 'security_pannel.dart';
import 'package:country_flags/country_flags.dart';

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  UserDataProvider providerUserData = UserDataProvider();
  RefreshController refreshController = RefreshController();
  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    providerUserData = Provider.of<UserDataProvider>(context);
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

      if (providerUserData.userData?.data?.isAgencyPanel == true)
        {
          "icon": "assets/icons/ic_person.png",
          "title": "Agency Center",
          "onTap": () {
            Get.to(() => const AgencyTab());
          }
        },
      if (providerUserData.userData?.data?.isCoinseller == true)
        {
          "icon": "assets/icons/ic_person.png",
          "title": "Diamond Seller",
          "onTap": () {
            Get.to(() => const DiamondSeller());
          }
        },
      if (providerUserData.userData?.data?.isSequrityPanel == true)
        {
          "icon": "assets/icons/ic_person.png",
          "title": "Security Panel",
          "onTap": () {
            Get.to(() => const SecurityPanel());
          }
        },
      // {
      //   "icon": "assets/icons/ic_aristocracy.png",
      //   "title": "Aristocracy",
      //   "onTap": () {
      //     showCustomSnackBar('Upcoming', context,isError: false);
      //     // Get.to(() => const TabsBar());
      //   }
      // },
      {
        "icon": "assets/icons/ic_star.png",
        "title": "Svip",
        "onTap": () {
          showCustomSnackBar('Upcoming', context,isError: false);
          // Get.to(() => const Svip());
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
        "title": "Level Privileges",
        "onTap": () {
          Get.to(() => const LevelPrivileges());
        }
      },
      // {
      //   "icon": "assets/icons/ic_calender.png",
      //   "title": "Daily Task",
      //   "onTap": () {
      //     showCustomSnackBar('Upcoming', context,isError: false);
      //     // Get.to(() => const DailyTask());
      //   }
      // },
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
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body:
      SmartRefresher(
        enablePullDown: true,
        onRefresh: ()async{
          await providerUserData.getUser(loading:false);
          refreshController.refreshCompleted();
          return;
        },
        physics: const BouncingScrollPhysics(),
        controller: refreshController,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0x339E26BC),
                  image: providerUserData.userData!.data!.level! > 1
                      ? const DecorationImage(

                      image: AssetImage(
                          'assets/decoration/profile_bg.png'),
                      fit: BoxFit.cover)
                      : null,
                ),
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18*a,vertical: 12*a),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text(
                          //   'You had Complete 50% Profile\nInformation',
                          //   textAlign: TextAlign.left,
                          //   style: SafeGoogleFont(
                          //       color: const Color.fromRGBO(
                          //           0, 0, 0, 0.6000000238418579),
                          //       'Poppins',
                          //       fontSize: 12,
                          //       letterSpacing:
                          //           0 /*percentages not used in flutter. defaulting to zero*/,
                          //       fontWeight: FontWeight.normal,
                          //       height: 1),
                          // ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const UserProfile());
                            },
                            child: Row(
                              children: [
                                userProfileDisplay(
                                  size: 87*a,
                                  image: providerUserData.userData!.data!.images!.isEmpty?'':providerUserData.userData?.data?.images?.first??'',
                                  frame: userValidItemSelection(providerUserData.userData?.data?.frame)
                                ),
                                SizedBox(width: 8*a),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      providerUserData.userData?.data?.name ?? 'null',
                                      textAlign: TextAlign.left,
                                      style: SafeGoogleFont(
                                          color: Colors.black.withOpacity(0.7),
                                          'Poppins',
                                          fontSize: 16,
                                          letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                          fontWeight: FontWeight.w500,
                                          height: 1),
                                    ),
                                    SizedBox(height: 8*a),
                                    Text(
                                      'View Or Edit Your Profile',
                                      textAlign: TextAlign.left,
                                      style: SafeGoogleFont(
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.6000000238418579),
                                          'Poppins',
                                          fontSize: 12,
                                          letterSpacing:
                                              0 /*percentages not used in flutter. defaulting to zero*/,
                                          fontWeight: FontWeight.w300,
                                          height: 1),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black54),
                              ],
                            ),
                          ),
                          SizedBox(height: 8*a),
                          Row(
                            children: [
                              SizedBox(width: 3*a),
                              Text(
                                'ID: ${providerUserData.userData?.data?.userId}',
                                textAlign: TextAlign.left,
                                style: SafeGoogleFont(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    'Poppins',
                                    fontSize: 10 * a,
                                    fontWeight: FontWeight.normal,
                                    height: 1 * a),
                              ),
                              SizedBox(width: 8 * a),
                              InkWell(
                                onTap: (){
                                  FlutterClipboard.copy('${providerUserData.userData?.data?.userId}').then((value) {
                                    showCustomSnackBar('Copied to Clipboard!', context, isToaster: true, isError: false);
                                  });
                                },
                                child: Container(
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
                              ),
                            ],
                          ),
                          Container(
                              height: 36 *a,
                              margin: EdgeInsets.only(top: 16*a),
                              child: Row(
                                  children: <Widget>[
                                    columnPairWidget(
                                        providerUserData
                                                .userData?.data?.followers?.length
                                                .toString() ??
                                            '0',
                                        'Followers',
                                      listing: providerUserData.userData?.data?.followers
                                    ),
                                    columnPairWidget(
                                        providerUserData
                                                .userData?.data?.following?.length
                                                .toString() ??
                                            '0',
                                        'Following',
                                        listing: providerUserData.userData?.data?.following
                                    ),
                                    columnPairWidget(
                                        providerUserData.userData?.data?.likes
                                                .toString() ??
                                            '0',
                                        'Likes'),
                                    columnPairWidget(
                                        providerUserData.userData?.data?.views
                                                .toString() ??
                                            '0',
                                        'Visitors'),
                                  ])),
                          SizedBox(height: 12*a),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                  children:
                                  List.generate(providerUserData.userData!.data!.tags?.length??0, (index) =>
                                  (providerUserData.userData?.data?.tags?[index].images?.first??'')!=''
                                      ?Padding(
                                    padding: EdgeInsets.only(right: 8*a),
                                    child: SvgPicture.network(
                                      providerUserData.userData!.data!.tags![index].images!.first,
                                      fit: BoxFit.fitHeight,
                                      height: 17 * a,
                                    )
                                  ):const SizedBox.shrink()
                                  )
                              ),
                              userLevelTag(
                                  providerUserData.userData?.data?.level??0,
                                  15 * a,
                                  viewZero: true),
                              SizedBox(width: 8*a),
                              Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SizedBox(width: 3 * a),
                                        Icon(
                                          providerUserData.userData?.data?.gender!
                                                      .toLowerCase() ==
                                                  'male'
                                              ? Icons.male
                                              : Icons.female,
                                          size: 11 * a,
                                        ),
                                        const SizedBox(width: 1),
                                        Text(
                                          AgeCalculator.calculateAge(
                                                  providerUserData
                                                          .userData?.data?.dob ??
                                                      DateTime.now())
                                              .toString(),
                                          style: TextStyle(fontSize: 9 * a),
                                        ),
                                        SizedBox(width: 4 * a)
                                      ])),
                              SizedBox(width: 8*a),
                              CountryFlag.fromCountryCode(
                                providerUserData
                                    .userData?.data?.countryCode??'IN',
                                height: 14*a,
                                width: 21*a,
                                borderRadius: 4,
                              ),
                            ],
                          ),
                          SizedBox(height: 8*a),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // todo: club/ family
              // if (providerUserData.userData?.data?.club == null)
                Padding(
                  padding:
                  EdgeInsets.only(top: 12 * a, left: 12 * a, right: 12 * a),
                  child: GestureDetector(
                    onTap: () {
                      showCustomSnackBar('Upcoming', context,isError: false);
                      // Get.to(() => const UsefunsClub());
                    },
                    child: Container(
                      height: 54 * a,
                      color: const Color(0xFFFEA42C),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0 * a),
                            child: Image.asset('assets/usefun_club.png'),
                          ),
                          const Text('Join family to make more friends\n (Upcoming)',
                              style: TextStyle(color: Colors.white)),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.white),
                          SizedBox(width: 10 * a)
                        ],
                      ),
                    ),
                  ),
                ),
              Column(
                children: [
                  SizedBox(height: 6*a),
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
            ],
          ),
        ),
      ),
    );
  }

  columnPairWidget(String top, String below, {List<String>? listing}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if(listing!=null) {
            showModalBottomSheet(
                backgroundColor: Colors.white,
                shape: InputBorder.none,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return DraggableScrollableSheet(
                    expand: false,
                      minChildSize: 0.5,
                      snap: true,
                      builder: (context, scrollController) => viewUsersByIds(listing,controller: scrollController,popCount: 1),
                  );
                });
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
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
              const Spacer(flex: 2),
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
          ),
        ),
      ),
    );
  }
}
