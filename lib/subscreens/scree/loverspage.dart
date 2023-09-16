import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Lovers extends StatefulWidget {
  const Lovers({super.key});

  @override
  State<Lovers> createState() => _LoversState();
}

class _LoversState extends State<Lovers> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '     Lovers',
                  style: TextStyle(
                      fontSize: 12 * a,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff000000)),
                ),
                Icon(Icons.help_outline_rounded)
              ],
            ),
            SizedBox(
              height: 30 * a,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('assets/dummy/b3.png')),
                CircleAvatar(backgroundImage: AssetImage('assets/hearts.png',),backgroundColor: Colors.white,),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/heart.png'),
                  backgroundColor: Color(0xffD9D9D9).withOpacity(0.4),
                ),
              ],
            ),
            const Text(
              'Lover not bound yet',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 30 * a,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('To be His/her Lover'),
            )
          ],
        ),
      ),
    );
  }
}
