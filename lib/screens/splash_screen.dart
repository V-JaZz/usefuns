import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/datasource/local/sharedpreferences/storage_service.dart';
import 'package:live_app/screens/dashboard/bottom_navigation.dart';
import 'package:live_app/utils/constants.dart';

import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 4);
    return Future.delayed(
      duration,
      () => Get.off(() {
        return StorageService().getString(Constants.id) == ''?const LogInScreen():const BottomNavigator();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/splash.gif',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
