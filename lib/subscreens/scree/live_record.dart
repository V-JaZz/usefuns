import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveRecord extends StatefulWidget {
  const LiveRecord({super.key});

  @override
  State<LiveRecord> createState() => _LiveRecordState();
}

class _LiveRecordState extends State<LiveRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        title: const Text('Live Record'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            redwidget('Agency Host'),
            const SizedBox(
              height: 10,
            ),
            textmethod(
                'Room id:58948762', FontWeight.normal, const Color(0xff000000)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textmethod('Agency: ', FontWeight.w300,
                    const Color(0xff000000).withOpacity(0.8)),
                textmethod(
                    'MK agency', FontWeight.normal, const Color(0xff000000)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textmethod('Joining date:: ', FontWeight.w300,
                    const Color(0xff000000).withOpacity(0.8)),
                textmethod(
                    '08-02-23', FontWeight.normal, const Color(0xff000000)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: const Color(0xFFFFE500),
              ),
              child: const Text(
                'Left Agency',
                style: TextStyle(color: Colors.black,fontSize: 9),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            redwidget('Weekly data'),
            Row(
              children: [
                heading_widget("Week"),
                heading_widget("ValidDays"),
                heading_widget("Room\nGifts"),
                heading_widget("Room\nGifts"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
                children: [
                  tablerow('05-22-05-28', '0', '0', '0'),
                  tablerow('05-08-05-28', '0', '0', '0'),
                  tablerow('07-08-05-28', '0', '0', '0'),
                  tablerow('03-08-05-28', '0', '0', '0'),
                ],
              ),
            ),
            redwidget('Monthly data'),
            Row(
              children: [
                heading_widget("Month"),
                heading_widget("ValidDays"),
                heading_widget("Room\nGifts"),
                heading_widget("Room\nGifts"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
                children: [
                  tablerow('May', '0', '0', '0'),
                  tablerow('April', '0', '0', '0'),
                ],
              ),
            ),
            redwidget('Daily data'),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                heading_widget("Data"),
                heading_widget("Visitor"),
                heading_widget("Room\nGifts"),
                heading_widget("Room\nGifts"),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
                children: [
                  tablerow('564756689', '0', '10', '0'),
                  tablerow('564756689', '0', '10', '0'),
                  tablerow('564756689', '0', '10', '0'),
                  tablerow('564756689', '0', '10', '0'),
                  tablerow('564756689', '0', '10', '0'),
                  tablerow('564756689', '0', '10', '0'),
                  tablerow('564756689', '0', '10', '0'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Text textmethod(text, fo, color) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          color: color,
          fontFamily: 'Poppins',
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: fo,
          height: 1),
    );
  }

  Container redwidget(text) {
    return Container(
      width: 158,
      height: 30,
      color: const Color(0xffFF0000),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      )),
    );
  }

  Padding heading_widget(text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: 100,
        decoration:
            BoxDecoration(color: const Color(0xffFFE500).withOpacity(0.4)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12.0, color: Colors.black),
          ),
        ),
      ),
    );
  }

  TableRow tablerow(text, t1, t2, t3) {
    return TableRow(children: [
      Text(
        text,
        style: const TextStyle(fontSize: 15.0),
      ),
      Center(
        child: Text(
          t1,
          style: const TextStyle(fontSize: 15.0),
        ),
      ),
      Center(
        child: Text(
          t2,
          style: const TextStyle(fontSize: 15.0),
        ),
      ),
      Center(
        child: Text(
          t3,
          style: const TextStyle(fontSize: 15.0),
        ),
      ),
    ]);
  }
}
