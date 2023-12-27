import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoTextView extends StatelessWidget {
  final String title;
  final String info;
  const InfoTextView({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67 * a,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: Center(child: Text(title)),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0 * a),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(info),
            ],
          ),
        ),
      ),
    );
  }
}
