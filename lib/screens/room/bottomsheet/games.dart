import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils_assets.dart';

class GamesBottomSheet extends StatelessWidget {
  final bool owner;
  const GamesBottomSheet({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    final List<Map> gamesList = [
      {
        "image": 'assets/jackpot.gif',
        "name": "JackPot",
        "rank": "516",
      },
      {
        "image": 'assets/ludo.gif',
        "name": "Ludo",
        "rank": "412",
      },
      {
        "image": 'assets/777.png',
        "name": "777 game",
        "rank": "510",
      },
      {
        "image": 'assets/wheel.gif',
        "name": "Wheel",
        "rank": "524",
      },
      {
        "image": 'assets/dias.png',
        "name": "Ludo Dias",
        "rank": "440",
      },
      if(owner){
        "image": 'assets/star.gif',
        "name": "Calculator",
        "rank": "440",
      },
    ];
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 16.0 * a, vertical: 9 * a),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PLAY WITH ANYONE',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  letterSpacing: 0.64 * a,
                  color: const Color(0xff000000),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) => GridView.count(
                  padding: EdgeInsets.all(22 * a),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 3 / 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    gamesList.length,
                        (index) => InkWell(
                      onTap: () {
                        if (index == 5) {
                          showCalculatorOptions(context);
                        }
                        ;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 6 * a),
                          CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 20,
                              foregroundImage:
                              AssetImage(gamesList[index]["image"])),
                          SizedBox(width: 6 * a),
                          Text(
                            gamesList[index]["name"],
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 14 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.64 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 12 * a,
                                height: 12 * a,
                                child: Image.asset(
                                  'assets/icons/ic_game.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 9 * a),
                              SizedBox(
                                width: 21 * a,
                                height: 18 * a,
                                child: Text(
                                  gamesList[index]["rank"],
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 12 * b,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5 * b / a,
                                    letterSpacing: 0.48 * a,
                                    color: const Color(0x99000000),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showCalculatorOptions(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          double baseWidth = 360;
          double a = Get.width / baseWidth;
          double b = a * 0.97;
          return Consumer<ZegoRoomProvider>(
            builder: (context, value, _) => Container(
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                    children: [
                  SizedBox(height: 10 * a),
                  TextButton(
                    onPressed: (){
                      value.resetCalculator();
                      Get.back();
                    },
                    child: Text(
                      'Reset',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 16 * b,
                        fontWeight: FontWeight.w400,
                        height: 1 * b / a,
                        letterSpacing: 0.64 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Divider(
                    height: 12 * a,
                  ),
                  TextButton(
                    onPressed: (){
                      value.updateViewCalculator();
                      Get.back();
                    },
                    child: Text(
                      value.zegoRoom!.viewCalculator?'Hide Calculator':'View Calculator',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 14 * b,
                        fontWeight: FontWeight.w400,
                        height: 1 * b / a,
                        letterSpacing: 0.64 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 10 * a)
                ])),
          );
        });
  }
}
