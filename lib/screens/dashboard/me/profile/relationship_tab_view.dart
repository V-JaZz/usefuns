import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RelationshipTabView extends StatefulWidget {
  const RelationshipTabView({super.key});

  @override
  State<RelationshipTabView> createState() => _RelationshipTabViewState();
}

class _RelationshipTabViewState extends State<RelationshipTabView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
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
                      color: const Color(0xff000000)),
                ),
                const Icon(Icons.help_outline_rounded)
              ],
            ),
            SizedBox(
              height: 30 * a,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                    backgroundImage: AssetImage('assets/dummy/b3.png')),
                const CircleAvatar(backgroundImage: AssetImage('assets/hearts.png',),backgroundColor: Colors.white,),
                CircleAvatar(
                  backgroundImage: const AssetImage('assets/heart.png'),
                  backgroundColor: const Color(0xffD9D9D9).withOpacity(0.4),
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
