import 'package:flutter/material.dart';

class BlockedList extends StatefulWidget {
  const BlockedList({super.key});

  @override
  State<BlockedList> createState() => _BlockedListState();
}

class _BlockedListState extends State<BlockedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: const Center(child: Text('Blocked List')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/ rec.png'),
              const Text('No Data '),
            ],
          ),
        ),
      ),
    );
  }
}

