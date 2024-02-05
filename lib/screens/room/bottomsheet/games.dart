import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/room/bottomsheet/manager.dart';
import 'package:provider/provider.dart';
import '../../../utils/utils_assets.dart';
import 'joy_games.dart';

class GamesBottomSheet extends StatelessWidget {
  final bool owner;
  const GamesBottomSheet({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    LiveRoomBottomSheets bs = LiveRoomBottomSheets(context);
    final List<Map> gamesList = [
      {
        "image": 'assets/Crazy_racing.png',
        "name": "Crazy racing",
        "rank": "516",
        "onTap" : (){
          Get.back();
          bs.showJoyGamesBottomSheet(10002);
        }
      },
      {
        "image": 'assets/Grady_bord.png',
        "name": "Greedy",
        "rank": "412",
        "onTap" : (){
          Get.back();
          bs.showJoyGamesBottomSheet(14);
        }
      },
      {
        "image": 'assets/Lucky_7.png',
        "name": "Lucky 7",
        "rank": "510",
        "onTap" : (){
          Get.back();
          bs.showJoyGamesBottomSheet(17);
        }
      },
      {
        "image": 'assets/dias.png',
        "name": "Dice",
        "rank": "440",
        "onTap" : (){
          Get.back();
          bs.showJoyGamesBottomSheet(601);
        }
      },
      {
        "image": 'assets/wheel.gif',
        "name": "Wheel",
        "rank": "524",
        "onTap" : (){
          Get.back();
          bs.showLuckyWheelBottomSheet();
        }
      },
      if(owner){
        "image": 'assets/star.gif',
        "name": "Calculator",
        "rank": "440",
        "onTap" : (){showCalculatorOptions(context);}
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
                  padding: EdgeInsets.symmetric(vertical: 22 * a),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  childAspectRatio: 1.2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    gamesList.length,
                        (index) => InkWell(
                      onTap: gamesList[index]["onTap"],
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
                            textAlign: TextAlign.center,
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
