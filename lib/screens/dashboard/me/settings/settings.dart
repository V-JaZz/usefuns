import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/rooms_provider.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/dashboard/me/contact_us.dart';
import 'package:live_app/subscreens/ref_useFuns.dart';
import 'package:live_app/subscreens/refund.dart';
import 'package:live_app/subscreens/sanitize.dart';
import 'package:live_app/utils/constants.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../subscreens/intellectual.dart';
import '../../../../utils/common_widgets.dart';
import '../../../auth/login_screen.dart';
import 'info_text_view.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<Map> settingsList = [
    {
      "icon": "assets/icons/ic_person.png",
      "title": "Account",
      "trailing": "number"
    },
    // {
    //   "icon": "assets/icons/ic_eng.png",
    //   "title": "English Mode",
    //   "trailing": "switch1"
    // },
    // {
    //   "icon": "assets/icons/ic_privacy.png",
    //   "title": "Privacy Settings",
    //   "trailing": "view"
    // },
    // {
    //   "icon": "assets/icons/ic_notify.png",
    //   "title": "Push Notification",
    //   "trailing": "switch2"
    // },
    // {
    //   "icon": "assets/icons/ic_clean.png",
    //   "title": "Clean Cache",
    // },
    // {
    //   "icon": "assets/icons/ic_privacy.png",
    //   "title": "Santize Room",
    //   "onTap": () {
    //     Get.to(() => const Sanitize());
    //   }
    // }
  ];
  final List<Map> settingsList2 = [
    {
      "title": "Terms of Service",
      "ontap": () {
        Get.to(() => InfoTextView(title: "Terms of Service",info: Constants.termsOfService));
      }
    },
    {
      "title": "Privacy Policy",
      "ontap": () {
        Get.to(() => InfoTextView(title: "Privacy Policy",info: Constants.privacyPolicy));
      }
    },
    {
      "title": "Community Policy",
      "ontap": () {
        Get.to(() => InfoTextView(title: "Community Policy",info: Constants.communityPolicy));
      }
    },
    {
      "title": "Refund Policy",
      "ontap": () {
        Get.to(() => InfoTextView(title: "Refund Policy",info: Constants.refundPolicy));
      }
    },
    {
      "title": "Intellectual Property Rights",
      "ontap": () {
        Get.to(() => InfoTextView(title: "Intellectual Property Rights",info: Constants.intellectualPropertyRights));
      }
    },
    {
      "title": "About us",
      "ontap": () {
        Get.to(() => InfoTextView(title: "About us",info: Constants.aboutUs));
      }
    },
    {
      "title": "Contact us",
      "ontap": () {
        Get.to(() => InfoTextView(title: "Contact us",info: Constants.contactUs));
      }
    }
  ];
  bool engMode = true;
  bool pushNotify = true;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 1,
        title: Text('Settings',
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Poppins',
              fontSize: 20 * b,
              fontWeight: FontWeight.w400,
              height: 1.5 * b / a,
              letterSpacing: 0.8 * a,
              color: const Color(0xff000000),
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34 * a, vertical: 14 * a),
        child: ListView(
          children: [
            for (Map m in settingsList)
              Container(
                margin: EdgeInsets.only(bottom: 12 * a),
                height: 21 * a,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      m['icon'],
                      fit: BoxFit.cover,
                      width: 14 * a,
                      height: 14 * a,
                    ),
                    SizedBox(width: 12 * a),
                    InkWell(
                      onTap: m["onTap"],
                      child: Text(
                        m['title'],
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.48 * a,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (m['trailing'] == 'view')
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 14 * a,
                      ),
                    if (m['trailing'] == 'number')
                      Text(
                        '${Provider.of<UserDataProvider>(context).userData?.data?.mobile??0}',
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 12 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.5 * b / a,
                          letterSpacing: 0.36 * a,
                          color: const Color(0x99000000),
                        ),
                      ),
                    if (m['trailing'] == 'switch1')
                      Transform.scale(
                        scale: 0.54 * a,
                        child: Switch(
                          activeColor: const Color(0xFFFFE500),
                          value: engMode,
                          onChanged: (value) {
                            setState(() {
                              engMode = value;
                            });
                          },
                        ),
                      ),
                    if (m['trailing'] == 'switch2')
                      Transform.scale(
                        scale: 0.54 * a,
                        child: Switch(
                          activeColor: const Color(0xFFFFE500),
                          value: pushNotify,
                          onChanged: (value) {
                            setState(() {
                              pushNotify = value;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
            SizedBox(height: 12 * a),
            for (Map m in settingsList2)
              Container(
                margin: EdgeInsets.only(bottom: 12 * a),
                height: 21 * a,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: m["ontap"],
                      child: Text(
                        m['title'],
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                          'Poppins',
                          fontSize: 14 * b,
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
            SizedBox(height: 36 * a),
            Consumer<AuthProvider>(
              builder: (context, value, child) => GestureDetector(
                onTap: (){
                  Provider.of<RoomsProvider>(context,listen: false).myRoom = null;
                  Provider.of<ZegoRoomProvider>(context,listen: false).destroy();
                  value.logout();
                },
                child: Container(
                  width: 316 * a,
                  height: 44 * a,
                  decoration: BoxDecoration(
                    color: const Color(0xff9e26bc),
                    borderRadius: BorderRadius.circular(12 * a),
                  ),
                  child: Center(
                    child: Text(
                      value.isLoading?'Logging out..':'Logout',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 16 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.64 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 36 * a),
          ],
        ),
      ),
    );
  }
}
