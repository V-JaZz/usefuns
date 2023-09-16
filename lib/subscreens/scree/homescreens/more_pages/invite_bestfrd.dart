import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class InviteBestie extends StatefulWidget {
  const InviteBestie({super.key});

  @override
  State<InviteBestie> createState() => _InviteBestieState();
}

class _InviteBestieState extends State<InviteBestie> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'The Best Friend Space',
          style: SafeGoogleFont(
              color: Color.fromRGBO(0, 0, 0, 0.6000000238418579),
              'Poppins',
              fontSize: 14,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.w300,
              height: 1),
        ),
        actions: [Icon(Icons.watch_later_outlined)],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  foregroundImage: AssetImage('assets/agency/seats.png')),
              SizedBox(
                height: 10 * a,
              ),
              Text('How to invite your best friends?'),
              SizedBox(
                height: 10 * a,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {},
                child: const Text(
                  'Click to know',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
      ),
    );
  }
}
