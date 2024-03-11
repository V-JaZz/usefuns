import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/screens/room/bottomsheet/manager.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_data_provider.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/utils_assets.dart';

class GamesBottomSheet extends StatelessWidget {
  final bool owner;
  const GamesBottomSheet({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    final udp = Provider.of<UserDataProvider>(Get.context!,listen: false);
    LiveRoomBottomSheets bs = LiveRoomBottomSheets(context);
    final List<Map> gamesList = [
      {
        "image": 'assets/games/Sudan-15.png',
        "name": "Sudan",
        "rank": "516",
        "isActive":true,
        "onTap" : (){
          Get.back();
          int recharge = udp.userData?.data?.totalPurchasedDiamonds??0;
          if(recharge >= 3000) {
            bs.showJoyGamesBottomSheet(15);
          }else{
            showCustomSnackBar('Recharge of total 3000 diamonds required!', context, isError: false);
          }
        }
      },
      {
        "image": 'assets/games/Neon Wheel-17.png',
        "name": "Neon Wheel",
        "rank": "516",
        "isActive":true,
        "recharge":5000,
        "onTap" : (){
          Get.back();
          int recharge = udp.userData?.data?.totalPurchasedDiamonds??0;
          if(recharge >= 5000) {
            bs.showJoyGamesBottomSheet(17);
          }else{
            showCustomSnackBar('Recharge of total 5000 diamonds required!', context, isError: false);
          }
        }
      },
      {
        "image": 'assets/games/Dragon Tiger-12.png',
        "name": "Dragon Tiger",
        "rank": "516",
        "isActive":true,
        "recharge":10000,
        "onTap" : (){
          Get.back();
          int recharge = udp.userData?.data?.totalPurchasedDiamonds??0;
          if(recharge >= 10000) {
            bs.showJoyGamesBottomSheet(12);
          }else{
            showCustomSnackBar('Recharge of total 10000 diamonds required!', context, isError: false);
          }
        }
      },
      {
        "image": 'assets/games/Horse Race-13.png',
        "name": "Horse Race",
        "rank": "516",
        "isActive":false,
        "recharge":12000,
        "onTap" : (){}
      },
      {
        "image": 'assets/games/Happy Fruit-20.png',
        "name": "Happy Fruit",
        "rank": "412",
        "isActive":false,
        "recharge":12000,
        "onTap" : (){}
      },
      {
        "image": 'assets/games/777-1.png',
        "name": "777",
        "rank": "510",
        "isActive":true,
        "recharge":12000,
        "onTap" : (){
          Get.back();
          int recharge = udp.userData?.data?.totalPurchasedDiamonds??0;
          if(recharge >= 12000) {
            bs.showJoyGamesBottomSheet(1);
          }else{
            showCustomSnackBar('Recharge of total 12000 diamonds required!', context, isError: false);
          }
        }
      },
      {
        "image": 'assets/games/Roulette-10.png',
        "name": "Roulette",
        "rank": "440",
        "isActive":false,
        "recharge":12000,
        "onTap" : (){}
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
        "image": 'assets/star.jpg',
        "name": "Calculator",
        "rank": null,
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
                style: safeGoogleFont(
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
                          Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          gamesList[index]["image"],
                                      ),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                              if(gamesList[index]["isActive"] == false)
                                Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      child: Text(
                                        'Upcoming',
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 6 * a),
                          Text(
                            gamesList[index]["name"],
                            textAlign: TextAlign.center,
                            style: safeGoogleFont(
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
                              if(gamesList[index]["rank"]!=null)SizedBox(
                                width: 12 * a,
                                height: 12 * a,
                                child: Image.asset(
                                  'assets/icons/ic_game.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // SizedBox(width: 9 * a),
                              // SizedBox(
                              //   width: 21 * a,
                              //   height: 18 * a,
                              //   child: Text(
                              //     gamesList[index]["rank"],
                              //     style: SafeGoogleFont(
                              //       'Poppins',
                              //       fontSize: 12 * b,
                              //       fontWeight: FontWeight.w400,
                              //       height: 1.5 * b / a,
                              //       letterSpacing: 0.48 * a,
                              //       color: const Color(0x99000000),
                              //     ),
                              //   ),
                              // ),
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
                      style: safeGoogleFont(
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
                      style: safeGoogleFont(
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
