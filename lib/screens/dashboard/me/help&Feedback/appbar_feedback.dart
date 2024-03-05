import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feedback.dart';
import 'myfeedback.dart';

class AppbarFeedBack extends StatefulWidget {
  const AppbarFeedBack({super.key});

  @override
  State<AppbarFeedBack> createState() => _AppbarFeedBackState();
}

class _AppbarFeedBackState extends State<AppbarFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Help Center &Feedback',
        ),
        actions: const [],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(8.0),
        child: ContainedTabBarView(
          tabs: const [
            Text('Feedback'),
            Text('My FeedBack'),
          ],
          views: const [
            FeedBack(),
            MyFeedBack(),
          ],
        ),
      ),
    );
  }
}
