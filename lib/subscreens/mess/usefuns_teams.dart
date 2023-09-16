import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class UsefunsTeam extends StatelessWidget {
  const UsefunsTeam({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 1,
        title: const Text('Usefuns'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 510 * a,
            left: 20 * a,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 85 * a,
                    height: 18 * a,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(9),
                        topRight: Radius.circular(9),
                        bottomLeft: Radius.circular(9),
                        bottomRight: Radius.circular(9),
                      ),
                      color: Color.fromRGBO(158, 38, 188, 1),
                    ),
                    child: Center(
                      child: Text(
                        'App Problems',
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 9 * a,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.4 * b / a),
                      ),
                    )),
                SizedBox(
                  width: 20 * a,
                ),
                Container(
                    width: 85 * a,
                    height: 18 * a,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(9),
                        topRight: Radius.circular(9),
                        bottomLeft: Radius.circular(9),
                        bottomRight: Radius.circular(9),
                      ),
                      border: Border.all(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Suggestions',
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            'Poppins',
                            fontSize: 9 * a,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1.4 * b / a),
                      ),
                    )),
                SizedBox(
                  width: 20 * a,
                ),
                Container(
                  width: 85 * a,
                  height: 18 * a,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Others',
                      textAlign: TextAlign.left,
                      style: SafeGoogleFont(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          'Poppins',
                          fontSize: 9 * a,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1.4 * b / a),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 560 * a,
            left: 20 * a,
            child: Row(
              children: [
                Container(
                  width: 210 * a,
                  height: 25 * a,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9 * a),
                      topRight: Radius.circular(9 * a),
                      bottomLeft: Radius.circular(9 * a),
                      bottomRight: Radius.circular(9 * a),
                    ),
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: '    Type a message',
                    ),
                  ),
                ),
                SizedBox(
                  width: 30 * a,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 41 * a,
                    height: 25 * a,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4 * a),
                        topRight: Radius.circular(4 * a),
                        bottomLeft: Radius.circular(4 * a),
                        bottomRight: Radius.circular(4 * a),
                      ),
                      color: const Color.fromRGBO(204, 196, 196, 1),
                    ),
                    child: Center(
                      child: Text(
                        'Send',
                        textAlign: TextAlign.left,
                        style: SafeGoogleFont(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            'Poppins',
                            fontSize: 9 * a,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1 * b / a),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
