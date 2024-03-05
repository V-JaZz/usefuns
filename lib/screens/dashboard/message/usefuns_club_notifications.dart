import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsefunsClubNotification extends StatelessWidget {
  const UsefunsClubNotification({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0x339E26BC),
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 1,
          title: const Text('Usefuns'),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 61 * a),
            height: 81 * a,
            width: 81 * a,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0x33FF9933)),
            child: const Icon(Icons.message_outlined),
          ),
        ));
  }
}
