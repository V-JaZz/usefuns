import 'package:flutter/material.dart';

class BeanPage extends StatefulWidget {
  const BeanPage({super.key});

  @override
  State<BeanPage> createState() => _BeanPageState();
}

class _BeanPageState extends State<BeanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              height: 119,
              color: const Color(0xffFEA500),
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 35),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Image.asset(
                          'assets/beans.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 39.0, left: 50),
                      child: Column(
                        children: [
                          balanceupdate('0'),
                          const Text(
                            'Account Balance',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text balanceupdate(text) => Text(
        text,
        style: const TextStyle(color: Colors.white),
      );
}
