import 'package:flutter/material.dart';

class UseFuns1 extends StatefulWidget {
  const UseFuns1({super.key});

  @override
  State<UseFuns1> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UseFuns1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'What is SVIP',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'svip represents a special identity in use fun. it\nContains 7 levels, namely, SVIP 1, SVIP 2, SVIP 3\nSVIP 4, SVIP 5, SVIP 6, SVIP 7,SVIP 8. When you get\ndifferent SVIP levels,You can enjoy different SVIP\nbenefits',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
