import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/auth_provider.dart';
import 'package:live_app/screens/login/verify_screen.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';

import '../../data/model/response/send_otp_model.dart';
import '../../utils/common_widgets.dart';
import '../../utils/network_util.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String? _selectedCountryCode = '+91';
  String contactNumber = "";
  @override
  void initState() {
    NetworkUtils.checkConnectivity(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xff101137), Color(0x005034ff)],
            stops: <double>[0, 1],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 49 * a),
                width: 370 * a,
                height: 125 * a,
                child: Stack(
                  children: [
                    Positioned(
                      left: 150 * a,
                      top: 50 * a,
                      child: SizedBox(
                        width: 60 * a,
                        height: 60 * a,
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0 * a,
                      top: 0 * a,
                      child: SizedBox(
                        width: 370 * a,
                        height: 67 * a,
                        child: Image.asset(
                          'assets/decoration/welcome_top.png',
                          width: 370 * a,
                          height: 67 * a,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 57 * a),
                child: Text(
                  'Meet new friends and Join live Party',
                  style: SafeGoogleFont(
                    'Roboto',
                    fontSize: 12 * b,
                    fontWeight: FontWeight.w400,
                    height: 1.1725 * b / a,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
              Text(
                'Welcome',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 24 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  letterSpacing: 2.52 * a,
                  color: const Color(0xffffffff),
                ),
              ),
              SizedBox(height: 12 * a),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 24 * a, right: 8 * a),
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  Text(
                    'Enter WhatsApp number',
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 15 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.1725 * b / a,
                      letterSpacing: 1.575 * a,
                      color: const Color(0xffffffff),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 8 * a, right: 24 * a),
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24 * a),
              Container(
                margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 36 * a),
                width: double.infinity,
                height: 45 * a,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 12 * a, 0 * a),
                      width: 90 * a,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12 * a),
                      ),
                      child: CountryCodePicker(
                        onChanged: (value) {
                          print(value.dialCode);
                          setState(() {
                            _selectedCountryCode = value.dialCode;
                          });
                        },
                        initialSelection: '+91',
                        showOnlyCountryWhenClosed: false,
                        hideMainText: true,
                        showDropDownButton: true,
                        padding: EdgeInsets.zero,
                        showCountryOnly: true,
                        comparator: (a, b) => b.name!.compareTo(a.name!),
                        onInit: (code) => debugPrint(
                            "on init ${code?.name} ${code?.dialCode} ${code?.name}"),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.fromLTRB(20 * a, 9 * a, 18 * a, 4 * a),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffffffff)),
                        borderRadius: BorderRadius.circular(52 * a),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(0 * a, 0 * a, 6 * a, 6 * a),
                            child: Text(
                              _selectedCountryCode ?? '',
                              style: SafeGoogleFont(
                                'Kanit',
                                fontSize: 16 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.495 * b / a,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                          Container(
                            width: 111 * a,
                            margin:
                                EdgeInsets.fromLTRB(0 * a, 0 * a, 0 * a, 6 * a),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              decoration: textFieldDecoration(),
                              onChanged: (String text) {
                                setState(() {
                                  contactNumber = text;
                                });
                              },
                              style: SafeGoogleFont(
                                'Kanit',
                                fontSize: 16 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * b / a,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<AuthProvider>(
                builder: (context, provider, child) => GestureDetector(
                  onTap: () async {
                    if(contactNumber!='' && contactNumber.length>9){
                      provider.mobile = _selectedCountryCode!.substring(1)+contactNumber;
                      SendOtpModel otp = await provider.sendOtp();
                      if (otp.status == 1 && otp.data?.otp != null) {
                        Get.to(() => const VerifyScreen());
                      } else {
                        showCustomSnackBar(otp.message, Get.context!);
                      }
                    }else{
                      showCustomSnackBar('Invalid number!', Get.context!);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(90 * a, 0 * a, 90 * a, 54 * a),
                    width: double.infinity,
                    height: 45 * a,
                    decoration: BoxDecoration(
                      color: const Color(0xff9e26bc),
                      borderRadius: BorderRadius.circular(59.5 * a),
                    ),
                    child: Center(
                      child: Text(
                        provider.isLoading ? 'Sending OTP..' : 'Verify',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 16 * b,
                          fontWeight: FontWeight.w700,
                          height: 1.2125 * b / a,
                          letterSpacing: 0.64 * a,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(74 * a, 0 * a, 63 * a, 24 * a),
                padding: EdgeInsets.fromLTRB(27 * a, 4 * a, 0 * a, 4 * a),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(50 * a),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 18 * a, 0 * a),
                      width: 22 * a,
                      height: 22 * a,
                      child: Image.asset(
                        'assets/icons/ic_fb.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Facebook',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 24 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(74 * a, 0 * a, 63 * a, 35 * a),
                padding: EdgeInsets.fromLTRB(27 * a, 4 * a, 0 * a, 4 * a),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(50 * a),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 18 * a, 0 * a),
                      width: 22 * a,
                      height: 22 * a,
                      child: Image.asset(
                        'assets/icons/ic_google.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Google',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 24 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(30 * a, 0 * a, 30 * a, 20 * a),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 14 * b,
                      fontWeight: FontWeight.w300,
                      height: 1.1725 * b / a,
                      color: const Color(0xff000000),
                    ),
                    children: [
                      TextSpan(
                        text: 'Log in means You agree to ',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w300,
                          height: 1.1725 * b / a,
                          color: const Color(0xff000000),
                        ),
                      ),
                      TextSpan(
                        text: 'Term of service, Privacy',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w300,
                          height: 1.1725 * b / a,
                          color: const Color(0xff1877f2),
                        ),
                      ),
                      TextSpan(
                        text: ' Policy',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w300,
                          height: 1.1725 * b / a,
                          color: const Color(0xff1877f2),
                        ),
                      ),
                      TextSpan(
                        text: ' and',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w300,
                          height: 1.1725 * b / a,
                          color: const Color(0xff000000),
                        ),
                      ),
                      TextSpan(
                        text: ' Community Policy',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w300,
                          height: 1.1725 * b / a,
                          color: const Color(0xff4285f4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  textFieldDecoration() {
    return const InputDecoration(
      isDense: true,
      counterText: "",
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );
  }
}
