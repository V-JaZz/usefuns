import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/screens/dashboard/me/shop/shop.dart';
import 'package:live_app/screens/room/bottomsheet/joy_games.dart';
import 'package:live_app/utils/common_widgets.dart';

import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';


class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  final List<Map> gamesList = [
    {
      "image": 'assets/games/Teen Patti-16F.png',
      "name": "Teen Patti",
      "isActive":true,
      "recharge":12000,
      "id" : 16

    },
    {
      "image": 'assets/games/Greedy-2F.png',
      "name": "Greedy",
      "isActive":false,
      "recharge":12000,
      "id" : 2
    }
  ];
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Game',
          style: safeGoogleFont(
            'Poppins',
            fontSize: 20 * b,
            fontWeight: FontWeight.w400,
            height: 1.5 * b / a,
            letterSpacing: 0.8 * a,
            color: const Color(0xff000000),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(21 * a, 21 * a, 34 * a, 21 * a),
              width: double.infinity,
              height: 24 * a,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/ic_diamond.png',
                          height: 14 * a, width: 14 * a),
                      SizedBox(width: 3 * a),
                      Text(
                        Provider.of<UserDataProvider>(context)
                            .userData!
                            .data!
                            .diamonds
                            .toString(),
                        style: safeGoogleFont(
                          'Roboto',
                          fontSize: 14 * b,
                          fontWeight: FontWeight.w400,
                          height: 1.171875 * b / a,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>const Shop());
                    },
                    child: Container(
                      width: 24 * a,
                      height: 24 * a,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12 * a),
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/icons/ic_store.png"),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: 24 * a,
                  //   height: 24 * a,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12 * a),
                  //     image: const DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: AssetImage("assets/icons/ic_task.png"),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Image.asset(
            //   "assets/decoration/ludo_cover.png",
            //   width: double.infinity,
            //   fit: BoxFit.contain,
            // ),
            LayoutBuilder(
              builder: (context, constraints) => GridView.count(
                padding: const EdgeInsets.all(22),
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 3 / 4,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  gamesList.length,
                  (index) => InkWell(
                    onTap: () async {
                      if(gamesList[index]["isActive"]){
                        final udp = Provider.of<UserDataProvider>(Get.context!,listen: false);
                        int recharge = udp.userData?.data?.totalPurchasedDiamonds??0;
                        if(recharge >= gamesList[index]["recharge"]) {
                          await Get.to(()=>JoyGames(gameId: gamesList[index]["id"],mini: 0));
                          udp.getUser(loading: false);
                        }else{
                          showCustomSnackBar('Recharge of total ${gamesList[index]["recharge"]} diamonds required!', context, isError: false);
                        }
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(children: [
                          Image.asset(gamesList[index]["image"]),
                          if(!gamesList[index]["isActive"])
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
                                child: Text(
                                  'Upcoming',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                        Text(
                          gamesList[index]["name"],
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 16 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.64 * a,
                            color: const Color(0xff000000),
                          ),
                        )
                      ]
                    )
                  )
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
