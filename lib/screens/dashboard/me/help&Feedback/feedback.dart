import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                upperbuttons(
                    'App Problems', const Color(0xffFFE500), Colors.yellow),
                upperbuttons('Suggestions',
                    const Color.fromARGB(255, 252, 252, 250), Colors.black),
                upperbuttons('Others', const Color.fromARGB(255, 253, 253, 251),
                    Colors.black),
              ],
            ),
            SizedBox(
              height: 15 * a,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Problem Description',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                ),
              ),
            ),
            SizedBox(
              height: 10 * a,
            ),
            TextFormField(),
            SizedBox(
              height: 20 * a,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Attachment',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                ),
              ),
            ),
            SizedBox(
              height: 20 * a,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  width: 76,
                  height: 68,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 0.4000000059604645),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  )),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'How to contact you',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(Icons.circle_outlined),
                    Text(
                      'Whatsapp',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 14 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.circle_outlined),
                    Text(
                      'Email',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 14 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.circle_outlined),
                    Text(
                      'Phone Number',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 14 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  Align upperbuttons(txt, f, col) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(color: col),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(9),
            topRight: Radius.circular(9),
            bottomLeft: Radius.circular(9),
            bottomRight: Radius.circular(9),
          ),
          color: f,
        ),
        child: Center(
          child: Text(
            txt,
            style: SafeGoogleFont(
              'Roboto',
              fontSize: 12 * b,
              fontWeight: FontWeight.w400,
              height: 1.1725 * b / a,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
