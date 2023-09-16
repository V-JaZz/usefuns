import 'package:flutter/material.dart';

class Uid extends StatefulWidget {
  const Uid({super.key});

  @override
  State<Uid> createState() => _UidState();
}

class _UidState extends State<Uid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cont('888888'),
              cont('888888'),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cont('888888'),
              cont('888888'),
            ],
          )
        ],
      ),
    ));
  }

  Container cont(txt) {
    return Container(
      width: 132,
      height: 37,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: const Color.fromRGBO(255, 229, 0, 1),
      ),
      child: Center(child: Text(txt)),
    );
  }
}
