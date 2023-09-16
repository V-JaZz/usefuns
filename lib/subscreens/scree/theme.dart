import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Center(child: Text('Theme')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
          ),
          children: [
            Image.asset('assets/7.png'),
            Image.asset('assets/8.png'),
            Image.asset('assets/9.png'),
            Image.asset('assets/10.png'),
            Image.asset('assets/11.png'),
            Image.asset('assets/12.png'),
            Image.asset('assets/13.png'),
            Image.asset('assets/14.png'),
            Image.asset('assets/15.png'),
            Image.asset('assets/16.png'),
          ],
        ),
      ),
    );
  }
}
