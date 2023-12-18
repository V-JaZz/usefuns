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
          // SizedBox(
          //   height: 30 * b,
          // ),
          // Container(
          //   width: 158 * a,
          //   height: 30 * a,
          //   color: const Color(0xffFF0000),
          //   child: const Center(
          //       child: Text(
          //     'Monthly data',
          //     style: TextStyle(color: Colors.white),
          //   )),
          // ),
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
            'Monthly Data',
            style: TextStyle(color: Colors.black),
          ),
          const HostDataTable(),
        ]),
      ),
    );
  }
}

class HostDataTable extends StatelessWidget {
  const HostDataTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange)),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.5),
          },
          border: TableBorder.all(color: Colors.black12),
          children: [
            TableRow(
              children: [
                Container(
                  height: 42,
                  decoration: const BoxDecoration(color: Colors.deepOrange),
                  alignment: Alignment.center,
                  child: const Text(
                    "Usefuns ID",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 42,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.deepOrange),
                  child: const Text(
                    "Room Gifts\n(04.6.23)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 42,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.deepOrange),
                  child: const Text(
                    "Valid Days\n(04.6.23)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                Container(
                  height: 42,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.deepOrange),
                  child: const Text(
                    "Valid Days\n(04.6.23)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
              ],
            ),
            tableRow(),
            tableRow(),
            tableRow(),
            tableRow(),
            tableRow()
          ],
        ),
      ),
    );
  }

  TableRow tableRow() {
    return const TableRow(children: [
      Text(
        "564756689",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "0",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "0",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0),
      ),
      Text(
        "0",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.0),
      ),
    ]);
  }
}
