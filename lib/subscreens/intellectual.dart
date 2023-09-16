import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Intellectual extends StatefulWidget {
  const Intellectual({super.key});

  @override
  State<Intellectual> createState() => _IntellectualState();
}

class _IntellectualState extends State<Intellectual> {
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
        title: const Center(child: Text('INTELLECTUAL PROPERTY RIGHTS')),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0 * a),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'INTELLECTUAL PROPERTY RIGHTS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20 * a,
              ),
              Text(
                  'In the Event of any Concerns Or\nComplaints about Possible Violation of\nIntellectual Property Rights, Please Send \nus an email at ip@usefuns.com\nidentifying with specificity the rights\nalleged to be violated and the accused\nProducts. Note: This email address is \njust for intellectual Property Rights and\nLegal issuses, other requests may not \nget respondence'),
            ],
          ),
        ),
      ),
    );
  }
}
