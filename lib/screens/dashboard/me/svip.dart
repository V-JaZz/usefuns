import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/me/me.dart';
import 'package:live_app/utils/utils_assets.dart';

class Svip extends StatefulWidget {
  const Svip({super.key});

  @override
  State<Svip> createState() => _SvipState();
}

class _SvipState extends State<Svip> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'SVIP',
          textAlign: TextAlign.left,
          style: SafeGoogleFont(
            color: Colors.black,
            'Poppins',
            fontSize: 14 * a,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.normal,
            height: 1 * b / a,
          ),
        ),
        actions: const [
          Icon(
            Icons.help,
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset('assets/bot.png'),
              ),
              textsamemethod(
                  'You have not got the svip', Colors.white, FontWeight.bold),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 179 * a,
                  width: double.infinity,
                  color: const Color(0xffE5B77C),
                  child: Column(
                    children: [
                      Text(
                        'The Month Progress',
                        style: TextStyle(fontSize: 18 * a),
                      ),
                      SizedBox(
                        height: 15 * a,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 65 * a),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/ic_diamond.png',
                height: 12*a,
                fit: BoxFit.fitHeight,),
                                SizedBox(
                                  width: 5 * a,
                                ),
                                Text(
                                  '0/3000',
                                  textAlign: TextAlign.left,
                                  style: SafeGoogleFont(
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      'Poppins',
                                      fontSize: 12 * a,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1 * b / a),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 100 * a),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/ic_diamond.png',
                height: 12*a,
                fit: BoxFit.fitHeight,),
                                SizedBox(
                                  width: 5 * a,
                                ),
                                Text(
                                  '0/3000',
                                  textAlign: TextAlign.left,
                                  style: SafeGoogleFont(
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      'Poppins',
                                      fontSize: 12 * a,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1 * b / a),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 40 * a),
                            child: Container(
                                width: 70 * a,
                                height: 4 * a,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(108, 75, 50, 1),
                                )),
                          ),
                          Container(
                            width: 44 * a,
                            height: 15 * a,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                            child: Center(
                              child: Text(
                                'Svip1',
                                textAlign: TextAlign.left,
                                style: SafeGoogleFont(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    'Poppins',
                                    fontSize: 9 * a,
                                    letterSpacing:
                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1 * b / a),
                              ),
                            ),
                          ),
                          Container(
                              width: 70 * a,
                              height: 4 * a,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(108, 75, 50, 1),
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: 40 * a),
                            child: Container(
                              width: 44 * a,
                              height: 15 * a,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                              child: Center(
                                child: Text(
                                  'Svip2',
                                  textAlign: TextAlign.left,
                                  style: SafeGoogleFont(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      'Poppins',
                                      fontSize: 9 * a,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1 * b / a),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50 * a),
                            child: Row(
                              children: [
                                Text(
                                  'Star',
                                  textAlign: TextAlign.left,
                                  style: SafeGoogleFont(
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      'Poppins',
                                      fontSize: 14 * a,
                                      letterSpacing:
                                          0 /*percentages not used in flutter. defaulting to zero*/,
                                      fontWeight: FontWeight.normal,
                                      height: 1 * b / a),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 50 * a),
                            child: Text(
                              '3k',
                              textAlign: TextAlign.left,
                              style: SafeGoogleFont(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  'Poppins',
                                  fontSize: 14 * a,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1 * b / a),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 110 * a),
                            child: Text(
                              '11k',
                              textAlign: TextAlign.left,
                              style: SafeGoogleFont(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  'Poppins',
                                  fontSize: 14 * a,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1 * b / a),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20 * a,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50 * a),
                            child: Text(
                              'After recharge',
                              textAlign: TextAlign.left,
                              style: SafeGoogleFont(
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                  'Poppins',
                                  fontSize: 14 * a,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1 * b / a),
                            ),
                          ),
                          SizedBox(
                            width: 10 * a,
                          ),
                          Image.asset('assets/icons/ic_diamond.png',
                height: 12*a,
                fit: BoxFit.fitHeight,),
                          SizedBox(
                            width: 10 * a,
                          ),
                          Text(
                            '3000 You get Svip1',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                'Poppins',
                                fontSize: 14 * a,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1 * b / a),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20 * a,
                      ),
                      Container(
                        width: 146 * a,
                        height: 22 * a,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12 * a),
                            topRight: Radius.circular(12 * a),
                            bottomLeft: Radius.circular(12 * a),
                            bottomRight: Radius.circular(12 * a),
                          ),
                          color: const Color.fromRGBO(30, 15, 10, 1),
                        ),
                        child: Center(
                          child: Text(
                            'Go to recharge',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                                color: Colors.white,
                                'Poppins',
                                fontSize: 14 * a,
                                fontWeight: FontWeight.normal,
                                height: 1 * b / a),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              textsamemethod(
                  'SVIP Benefits', const Color(0xffBDB24B), FontWeight.bold),
              const SizedBox(
                height: 15,
              ),
              textsamemethod(
                  'Different SVIP levels can enjoy the following different\nbenefits, You can enjoy more benefits With higher level',
                  Colors.white,
                  FontWeight.normal),
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 24 * a),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      // crossAxisAlignment: WrapCrossAlignment.end,
                      // runSpacing: 24 * a,
                      // spacing: 18 * a,
                      children: List.generate(21, (index) => Container(
                        child: Image.asset(
                          'assets/svip_benefits_ic/${index+1}.png',
                          width: Get.width * 0.27,
                        ),
                      ))
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  iconTextRow(String path, String txt,{ String? vip}) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SizedBox(
      width: 95 * a,
      height: 108 * a,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 12*a
              ),
              Image.asset(
                path,
                width: 58 * a,
                height: 57 * a,
              ),
              SizedBox(
                  height: 6*a
              ),
              Text(
                txt,
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    'Poppins',
                    fontSize: 14 * a,
                    letterSpacing:
                    0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1 * a),
              ),
            ],
          ),
          if (vip!=null)
            Positioned(
              left: 35 * a,
              top: 0 * a,
              child: Container(
                width: 58 * a,
                height: 18 * a,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9 * a),
                  color: const Color(0xffFF9933),
                ),
                child: Center(
                  child: Text(
                    vip,
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 12 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.171875 * b / a,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  ElevatedButton buttonuseeverywhere(color, col) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // background (button) color
        foregroundColor: col, // foreground (text) color
      ),
      onPressed: () {},
      child: const Text('Go to Recharge'),
    );
  }

  Center textsamemethod(text, color, ff) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: ff,
        ),
      ),
    );
  }
}
