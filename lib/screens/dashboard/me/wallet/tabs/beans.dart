import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../provider/user_data_provider.dart';

class BeanTabView extends StatefulWidget {
  const BeanTabView({super.key});

  @override
  State<BeanTabView> createState() => _BeanTabViewState();
}

class _BeanTabViewState extends State<BeanTabView> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                        beansWidget(Provider.of<UserDataProvider>(context).userData?.data?.beans??0),
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
    );
  }

  Text beansWidget(text) => Text(
        text.toString(),
        style: const TextStyle(color: Colors.white),
      );
}
