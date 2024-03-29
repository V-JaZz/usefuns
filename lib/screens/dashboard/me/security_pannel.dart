import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecurityPanel extends StatefulWidget {
  const SecurityPanel({super.key});

  @override
  State<SecurityPanel> createState() => _SecurityPanelState();
}

class _SecurityPanelState extends State<SecurityPanel> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Security Pannel'),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Team member code'),
              Text('Id Code 768567'),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 40 * a,
              right: 20 * a,
              top: 70 * a,
            ),
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const CustomTable(),
        ],
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  const CustomTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Table(
          children: [
            TableRow(
              children: [
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xffFF0000)),
                  child: const Text(
                    "User ID Number",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xffFF0000)),
                  child: const Text(
                    " ID Disable Report",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xffFF0000)),
                  child: const Text(
                    " Profile Picture Band",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xffFF0000)),
                  child: const Text(
                    "Device Band",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
              ],
            ),
            tablerow(),
            tablerow(),
            tablerow(),
            tablerow(),
            tablerow(),
            tablerow(),
            tablerow(),
            tablerow(),
            tablerow(),
            tablerow(),
          ],
        ),
      ),
    );
  }

  TableRow tablerow() {
    return const TableRow(children: [
      Text(
        "564756689",
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "     0",
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "     0",
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "     0",
        style: TextStyle(fontSize: 15.0),
      ),
    ]);
  }
}
