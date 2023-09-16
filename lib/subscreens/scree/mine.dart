import 'package:flutter/material.dart';

class MinPage extends StatefulWidget {
  const MinPage({super.key});

  @override
  State<MinPage> createState() => _MinPageState();
}

class _MinPageState extends State<MinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: const Text('Mine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 500,
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
            const SizedBox(
              height: 25,
            ),
            Container(
              width: 154,
              height: 32,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 229, 0, 1),
              ),
              child: const Center(child: Text('Use Now')),
            ),
          ],
        ),
      ),
    );
  }
}
