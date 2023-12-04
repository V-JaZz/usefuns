import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:live_app/utils/utils_assets.dart';

import '../../../utils/common_widgets.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  final List<Map> gamesList = [
    {
      "image": 'assets/dummy/game1.png',
      "name": "Ludo",
      "rank": "516",
    },
    {
      "image": 'assets/dummy/game2.png',
      "name": "Bodycar",
      "rank": "412",
    },
    {
      "image": 'assets/dummy/game3.png',
      "name": "Knife",
      "rank": "510",
    },
    {
      "image": 'assets/dummy/game4.png',
      "name": "Uno",
      "rank": "524",
    },
    {
      "image": 'assets/dummy/game5.png',
      "name": "Domino",
      "rank": "440",
    },
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
          style: SafeGoogleFont(
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
        child: GestureDetector(
          onTap: (){
            showCustomSnackBar('Requires minimum level 10 to play games!',context,isError: false);
          },
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
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 6 * a, 0 * a),
                          width: 16 * a,
                          height: 16 * a,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8 * a),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/icons/ic_coin.png"),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 8 * a, 0 * a),
                          child: Text(
                            '0',
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
                        Container(
                          margin: EdgeInsets.fromLTRB(0 * a, 6 * a, 0 * a, 6 * a),
                          width: 12 * a,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffffe500),
                            borderRadius: BorderRadius.circular(6 * a),
                          ),
                          child: Center(
                            child: Text(
                              '+',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 8 * b,
                                fontWeight: FontWeight.w400,
                                height: 1.5 * b / a,
                                letterSpacing: 0.32 * a,
                                color: const Color( 0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * a, 0 * a, 42 * a, 0 * a),
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
                    Container(
                      width: 24 * a,
                      height: 24 * a,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12 * a),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/icons/ic_task.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/decoration/ludo_cover.png",
                width: double.infinity,
                fit: BoxFit.contain,
              ),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 6),
                          Image.asset(gamesList[index]["image"]),
                          const SizedBox(width: 6),
                          Text(
                            gamesList[index]["name"],
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 16 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.64 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                          Row(
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
                                  '519',
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
}
