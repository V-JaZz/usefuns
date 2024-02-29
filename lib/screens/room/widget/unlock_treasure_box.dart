import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/shop_wallet_provider.dart';
import 'package:provider/provider.dart';

class UnlockTreasureBox extends StatefulWidget {
  final int level;
  const UnlockTreasureBox({super.key, required this.level});

  @override
  State<UnlockTreasureBox> createState() => _UnlockTreasureBoxState();
}

class _UnlockTreasureBoxState extends State<UnlockTreasureBox> {
  int countDown = 10;
  bool size = false;
  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        size = !size;
      });
    });
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (countDown == 0) {
        timer.cancel();
        await Get.dialog(TreasureBoxReward(level: widget.level));
        Get.back();
      } else {
        setState(() {
          countDown--;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 140,
        width: 210,
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/ic_treasure_box/${widget.level}.png',
                height: 60,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: size ? 20 : 30,
                width: size ? 20 : 30,
                child: FittedBox(
                  child: Text(
                    '$countDown',
                    style: const TextStyle(
                        color: Colors.white, decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TreasureBoxReward extends StatelessWidget {
  final int level;
  const TreasureBoxReward({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    String reward = getRandomDiamondReward(level);
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
              Text(reward,
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
                  onPressed: () => Get.back(),
                  child: Text(reward.contains('Diamonds')?'Claim':'Okay'))
            ],
          ),
        ),
      ),
    );
  }
}

String getRandomDiamondReward(int level) {
  List<int> diamonds = [0, 50*level, 100*level, 300*level];
  String reward;
  Random random = Random();

  int randomIndex = random.nextInt(diamonds.length);
  final wonDiamonds = diamonds[randomIndex].toInt();
  if(wonDiamonds == 0){
      reward = 'Better Luck\nNext Time';
  }else {
    reward = 'You Won\n$wonDiamonds Diamonds!';
    Provider.of<ShopWalletProvider>(Get.context!,listen: false).treasureBoxReward(wonDiamonds);
  }
  return reward;
}
