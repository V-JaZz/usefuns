import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class BannedCountdown extends StatefulWidget {
  const BannedCountdown({super.key});

  @override
  BannedCountdownState createState() => BannedCountdownState();
}

class BannedCountdownState extends State<BannedCountdown> {
  int countdownSeconds = 30;

  @override
  void initState() {
    super.initState();
    startLogoutTimer();
  }

  void startLogoutTimer() {
    const oneSecond = Duration(seconds: 1);

    Timer.periodic(oneSecond, (Timer timer) {
      if (countdownSeconds == 0) {
        timer.cancel();
        Get.offAll(const LogInScreen());
      } else {
        setState(() {
          countdownSeconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Account Banned',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'We regret to inform you that your account has been banned due to violations of our community regulations and terms and conditions. Our commitment to maintaining a safe and respectful environment for all users is paramount, and any breach of our policies undermines this commitment.\n  The decision to suspend your account is not taken lightly, and it is a result of a careful review of your activities on our platform. We encourage all users to familiarize themselves with our regulations to ensure a positive and inclusive experience for everyone.\n If you believe there has been a misunderstanding or if you have questions regarding the ban, please feel free to contact our support team at https://usefuns.live/',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1), () {}),
                builder: (context, snapshot) {
                  return Text(
                    'Logout in: $countdownSeconds seconds',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87
                ),
                onPressed: () {
                  Get.offAll(const LogInScreen());
                },
                child: const Text('Logout Now', style: TextStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
