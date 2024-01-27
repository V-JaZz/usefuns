import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:live_app/provider/auth_provider.dart';
import 'package:live_app/screens/auth/verify_screen.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import '../../data/model/response/send_otp_model.dart';
import '../../utils/common_widgets.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xff101137), Color(0x005034ff)],
            stops: <double>[0, 1]
          ),
        ),
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 150 * a,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 70 * a,
                      child: SizedBox(
                        width: 60 * a,
                        height: 60 * a,
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.fitHeight,
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
                    )
                  ],
                ),
              ),
              Text(
                'Meet new friends and Join live Party',
                style: SafeGoogleFont(
                  'Roboto',
                  fontSize: 14 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.1725 * b / a,
                  color: const Color(0xd0ffffff),
                ),
              ),
              const Spacer(flex: 2),
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
              const Spacer(),
              Container(
                margin: EdgeInsets.fromLTRB(36 * a, 0, 36 * a, 0),
                width: double.infinity,
                child: InternationalPhoneNumberInput(
                  focusNode: focusNode,
                  onInputChanged: (PhoneNumber value) {
                    provider.number = value;
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  spaceBetweenSelectorAndTextField: 0,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(color: Colors.white),
                  textStyle: const TextStyle(color: Colors.white),
                  initialValue: provider.number,
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                  inputDecoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 18*a, vertical: 12*a),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30 * a),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(30 * a),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if(provider.number.phoneNumber == null || provider.number.phoneNumber?.substring(provider.number.dialCode!.length).trim() == ''){
                    showCustomSnackBar('Invalid number!', Get.context!);
                  }else{
                    SendOtpModel otp = await provider.sendOtp();
                  if (otp.status == 1 && otp.data?.otp != null) {
                    Get.to(() => const VerifyScreen());
                  } else {
                    showCustomSnackBar(otp.message, Get.context!);
                  }
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
              const Spacer(flex: 7)
              // Container(
              //   margin: EdgeInsets.fromLTRB(74 * a, 0 * a, 63 * a, 24 * a),
              //   padding: EdgeInsets.fromLTRB(27 * a, 4 * a, 0 * a, 4 * a),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: const Color(0xffffffff),
              //     borderRadius: BorderRadius.circular(50 * a),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 18 * a, 0 * a),
              //         width: 22 * a,
              //         height: 22 * a,
              //         child: Image.asset(
              //           'assets/icons/ic_fb.png',
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       Text(
              //         'Facebook',
              //         style: SafeGoogleFont(
              //           'Poppins',
              //           fontSize: 24 * b,
              //           fontWeight: FontWeight.w400,
              //           height: 1.5 * b / a,
              //           color: const Color(0xff000000),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Consumer<AuthProvider>(
              //   builder: (context, value, _) => GestureDetector(
              //     onTap: () async {
              //       // LoginModel? model = await value.signInWithGoogle();
              //       // if(model?.status == 1){
              //       //   Get.offAll(() => const BottomNavigator());
              //       // }else if(model?.status == 0){
              //       //   Get.off(() => const CreateProfile());
              //       // }
              //     },
              //     child: Container(
              //       margin: EdgeInsets.fromLTRB(74 * a, 0 * a, 63 * a, 35 * a),
              //       padding: EdgeInsets.fromLTRB(27 * a, 4 * a, 0 * a, 4 * a),
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         color: const Color(0xffffffff),
              //         borderRadius: BorderRadius.circular(50 * a),
              //       ),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Container(
              //             margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 18 * a, 0 * a),
              //             width: 22 * a,
              //             height: 22 * a,
              //             child: Image.asset(
              //               'assets/icons/ic_google.png',
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           Text(
              //             'Google',
              //             style: SafeGoogleFont(
              //               'Poppins',
              //               fontSize: 24 * b,
              //               fontWeight: FontWeight.w400,
              //               height: 1.5 * b / a,
              //               color: const Color(0xff000000),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 45*a,
        margin: EdgeInsets.fromLTRB(30 * a, 0 * a, 30 * a, 10 * a),
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
    );
  }
}
