import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../provider/shop_wallet_provider.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/utils_assets.dart';

class LuckyWheelBottomSheet extends StatefulWidget {
  const LuckyWheelBottomSheet({super.key});

  @override
  State<LuckyWheelBottomSheet> createState() => _LuckyWheelBottomSheetState();
}

class _LuckyWheelBottomSheetState extends State<LuckyWheelBottomSheet> with TickerProviderStateMixin {
  StreamController<int> selected = StreamController<int>();
  bool isSpinning = false;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final items = <String>[
      '10000',
      '5000',
      '1000',
      '500',
      '100',
      '50',
      '10',
      '5'
    ];
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Spacer(flex: 5),
              Text(
                'Lucky Wheel',
                style: safeGoogleFont(
                  'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffffffff),
                ),
              ),
              const Spacer(flex: 2),
              Image.asset('assets/icons/ic_diamond.png',
                  height: 12, width: 12),
              const SizedBox(width: 6),
              Text(
                Provider.of<UserDataProvider>(context)
                    .userData!
                    .data!
                    .diamonds
                    .toString(),
                style: safeGoogleFont(
                  'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffffffff),
                ),
              ),
              const Spacer(),
            ],
          ),
          Container(
            height: Get.width*0.7,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: Get.width/6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xfff8b817), width: 6,strokeAlign: BorderSide.strokeAlignOutside)
            ),
            child: FortuneWheel(
              indicators: [
                FortuneIndicator(
                    child: Image.asset(
                        'assets/decoration/spin_wheel_pointer.png',
                      width: Get.width*0.12,
                      fit: BoxFit.fitWidth,
                    ),
                )
              ],
              animateFirst: false,
              physics: NoPanPhysics(),
              selected: selected.stream,

              items: [
                for (int i =0 ; i < items.length ; i++)
                  FortuneItem(
                    style: FortuneItemStyle(
                      color: i%2 == 0 ? const Color(0xFFffecae): Colors.white,
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),
                      // borderColor: const Color(0xffffa200)
                        borderColor: Colors.transparent
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(items[i]),
                          Image.asset(
                            'assets/icons/ic_diamond.png',
                            height: 12,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 24)
                        ],
                      )
                  ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffffa200),
              foregroundColor: Colors.white
            ),
              onPressed: () async {
              int userD = Provider.of<UserDataProvider>(context,listen: false).userData?.data?.diamonds??0;
              if(userD<200){
                showInsufficientDialog(context,200-userD);
              }else if(!isSpinning){
                isSpinning = true;
                bool success = await Provider.of<ShopWalletProvider>(context,listen: false).spendUserDiamonds(200,'Lucky Wheel');
                if(success) {
                  final rewardPosition = [2,3,4,5,6,7,4,5,6,7];
                  int value = rewardPosition[Random().nextInt(9)];
                  setState(() => selected.add(value));
                  Future.delayed(
                    const Duration(seconds: 5),
                        () {
                      Get.dialog(
                          LuckyWheelReward(diamonds: int.parse(items[value])),
                          barrierDismissible: false
                      );
                      isSpinning = false;
                    },
                  );
                }
              }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Spin 200'),
                  Image.asset(
                    'assets/icons/ic_diamond.png',
                    height: 12,
                    fit: BoxFit.fitHeight,
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}


class LuckyWheelReward extends StatelessWidget {
  final int diamonds;
  const LuckyWheelReward({super.key, required this.diamonds});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 140,
        width: 210,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You Won\n$diamonds Diamonds!',
                style: const TextStyle(
                    fontSize: 21,
                    color: Colors.deepOrangeAccent,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepOrangeAccent
                  ),
                  onPressed: () {
                    Get.back();
                    Provider.of<ShopWalletProvider>(context,listen: false).luckyWheelReward(diamonds);
                  },
                  child: const Text('Claim'))
            ],
          ),
        ),
      ),
    );
  }
}
