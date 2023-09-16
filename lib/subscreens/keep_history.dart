import 'package:flutter/material.dart';

class KeepHistory extends StatefulWidget {
  const KeepHistory({super.key});

  @override
  State<KeepHistory> createState() => _KeepHistoryState();
}

class _KeepHistoryState extends State<KeepHistory>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: const Center(child: Text('Keep History')),
      ),
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