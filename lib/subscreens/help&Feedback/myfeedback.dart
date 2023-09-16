import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFeedBack extends StatefulWidget {
  const MyFeedBack({super.key});

  @override
  State<MyFeedBack> createState() => _MyFeedBackState();
}

class _MyFeedBackState extends State<MyFeedBack> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/rec.png'),
              const Text('No Data'),
            ],
          ),
        ),
      ),
    );
  }
}
