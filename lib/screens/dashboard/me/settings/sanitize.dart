import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sanitize extends StatefulWidget {
  const Sanitize({super.key});

  @override
  State<Sanitize> createState() => _SanitizeState();
}

class _SanitizeState extends State<Sanitize> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Center(
          child: Text('Sanitize'),
        ),
      ),
      body: Column(
        children: [
          container(a, 'assets/dummy/g4.png', 'Dimple Ayesha.'),
          container(a, 'assets/dummy/g1.png', 'Dream Girls.'),
          container(a, 'assets/dummy/g2.png', 'Friendship Clubs'),
          container(a, 'assets/dummy/g3.png', 'GF BF Dating Room'),
          container(a, 'assets/dummy/g5.png', 'Nisha Hosting'),
        ],
      ),
    );
  }

  Container container(double a, img, name) {
    return Container(
      margin: EdgeInsets.only(top: 20 * a),
      height: 64 * a,
      width: double.infinity,
      child: ListTile(
        leading: Image.asset(img),
        title: Text(name),
        subtitle: Text('Banned Forever'),
      ),
    );
  }
}
