import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Agency extends StatefulWidget {
  const Agency({super.key});

  @override
  State<Agency> createState() => _AgencyState();
}

class _AgencyState extends State<Agency> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 30 * b,
          ),
          Container(
            width: 158 * a,
            height: 30 * a,
            color: const Color(0xffFF0000),
            child: const Center(
                child: Text(
              'Monthly data',
              style: TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(
            height: 30 * a,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Agency: Usefuns'),
                SizedBox(
                  width: 30 * a,
                ),
                const Text('Agency Code: 4257k'),
              ],
            ),
          ),
          SizedBox(
            height: 20 * a,
          ),
          const Text(
            'View Monthly Data',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 30,
          ),
          const table(),
        ]),
      ),
    );
  }
}

class table extends StatelessWidget {
  const table({
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
                    "UseFunds\nID",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xffFF0000)),
                  child: const Text(
                    "Valid Days\n(04.\n6.23",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xffFF0000)),
                  child: const Text(
                    "Room\nGifts(04.\n6.23",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xffFF0000)),
                  child: const Text(
                    "Valid Days\n(04.\n6.23",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Color(0xffFF0000)),
                  child: const Text(
                    "Valid Days\n(04.\n6.23",
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
      Text(
        "     0",
        style: TextStyle(fontSize: 15.0),
      ),
    ]);
  }
}
