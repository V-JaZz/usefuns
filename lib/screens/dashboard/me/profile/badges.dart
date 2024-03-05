import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BadgePage extends StatefulWidget {
  const BadgePage({super.key});

  @override
  State<BadgePage> createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67 * a,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Center(child: Text('Badges')),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0 * a),
        child: Column(
          children: [
            const Text('Badges'),
            SizedBox(
              height: 500 * a,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                ),
                children: [
                  Image.asset('assets/7.png'),
                  Image.asset('assets/8.png'),
                  Image.asset('assets/17.png'),
                  Image.asset('assets/18.png'),
                  Image.asset('assets/19.png'),
                  Image.asset('assets/20.png'),
                  Image.asset('assets/21.png'),
                  Image.asset('assets/22.png'),
                ],
              ),
            ),
            SizedBox(
              height: 25 * a,
            ),
          ],
        ),
      ),
    );
  }
}
