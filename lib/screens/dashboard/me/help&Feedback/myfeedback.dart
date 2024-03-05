import 'package:flutter/material.dart';

class MyFeedBack extends StatefulWidget {
  const MyFeedBack({super.key});

  @override
  State<MyFeedBack> createState() => _MyFeedBackState();
}

class _MyFeedBackState extends State<MyFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/rec.png'),
              const Text('No Data'),
            ],
          ),
        ),
      ),
    );
  }
}
