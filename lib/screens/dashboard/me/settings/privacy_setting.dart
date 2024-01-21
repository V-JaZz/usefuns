import 'package:flutter/material.dart';

class PrivacySetting extends StatefulWidget {
  const PrivacySetting({super.key});

  @override
  State<PrivacySetting> createState() => _PrivacySettingState();
}

class _PrivacySettingState extends State<PrivacySetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: const Text(
          'Privacy Settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
            const SizedBox(
            height: 40,
          ),
          textmethod('Messages Permission'),
          textmehod('Who can send me messages'),
          const SizedBox(
            height: 40,
          ),
          textmethod('Blocked List'),
          textmehod('Mesage people who have blocked'),
          const SizedBox(
            height: 40,
          ),
          textmethod('Comment Restriction'),
          textmehod('Mesage people who have blocked'),
          const SizedBox(
            height: 40,
          ),
          textmethod('Save Video Restriction'),
          textmehod('Mesage people who have blocked'),
        ]),
      ),
    );
  }

  Text textmethod(txt) => Text(
        txt,
        style: const TextStyle(fontSize: 19),
      );
  Text textmehod(txt) => Text(
        txt,
        style: const TextStyle(fontSize: 14),
      );
}
