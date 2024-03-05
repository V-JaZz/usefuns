import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class DailyTask extends StatefulWidget {
  const DailyTask({super.key});

  @override
  State<DailyTask> createState() => _DailyTaskState();
}

class _DailyTaskState extends State<DailyTask> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75 * a,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: Text(
          'Daily Tasks',
          style: safeGoogleFont(
              color: const Color.fromRGBO(0, 0, 0, 1),
              'Poppins',
              fontSize: 20 * a,
              fontWeight: FontWeight.normal,
              height: 1 * b / a),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 19 * a,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              '  Daily Tasks',
              textAlign: TextAlign.left,
              style: safeGoogleFont(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  'Poppins',
                  fontSize: 20 * a,
                  fontWeight: FontWeight.normal,
                  height: 1 * a),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.watch_later_outlined),
            title: Column(
              children: [
                SizedBox(
                  height: 10 * a,
                ),
                Text(
                  'The total time stay in any room',
                  textAlign: TextAlign.left,
                  style: safeGoogleFont(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      'Poppins',
                      fontSize: 12 * a,
                      fontWeight: FontWeight.normal,
                      height: 1 * b / a),
                ),
                SizedBox(
                  height: 5 * a,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '   (5/5min)',
                    textAlign: TextAlign.left,
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.normal,
                        height: 1 * b / a),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 52 * a,
              height: 14 * a,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9 * a),
                  topRight: Radius.circular(9 * a),
                  bottomLeft: Radius.circular(9 * a),
                  bottomRight: Radius.circular(9 * a),
                ),
                color: const Color.fromRGBO(255, 229, 0, 1),
              ),
              child: const Center(child: Text('GET')),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 60 * a),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9 * a),
                ),
                width: 140 * a,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: SliderComponentShape.noThumb,
                    ),
                    child: Slider(
                      min: 0,
                      max: 10,
                      value: 5,
                      onChanged: (double value) {},
                      inactiveColor: Colors.grey,
                      activeColor: Colors.yellow,
                    )),
              ),
              const Text('  '),
              Image.asset('assets/icons/ic_diamond.png'),
              Text(
                '+30',
                textAlign: TextAlign.left,
                style: safeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12 * a,
                    fontWeight: FontWeight.normal,
                    height: 1 * b / a),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.watch_later_outlined),
            title: Column(
              children: [
                SizedBox(
                  height: 10 * a,
                ),
                Text(
                  'The total time stay in any room',
                  textAlign: TextAlign.left,
                  style: safeGoogleFont(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      'Poppins',
                      fontSize: 12 * a,
                      fontWeight: FontWeight.normal,
                      height: 1 * b / a),
                ),
                SizedBox(
                  height: 5 * a,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '   (5/5min)',
                    textAlign: TextAlign.left,
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.normal,
                        height: 1 * b / a),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 52 * a,
              height: 17 * a,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(255, 229, 0, 1),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9 * a),
                  topRight: Radius.circular(9 * a),
                  bottomLeft: Radius.circular(9 * a),
                  bottomRight: Radius.circular(9 * a),
                ),
              ),
              child: const Center(
                child: Text('Go'),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 60 * a),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9 * a),
                ),
                width: 140 * a,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: SliderComponentShape.noThumb,
                    ),
                    child: Slider(
                      min: 0,
                      max: 10,
                      value: 5,
                      onChanged: (double value) {},
                      inactiveColor: Colors.yellow,
                      activeColor: Colors.yellow,
                    )),
              ),
              const Text('  '),
              Image.asset('assets/icons/ic_diamond.png'),
              Text(
                '+50',
                textAlign: TextAlign.left,
                style: safeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12 * a,
                    fontWeight: FontWeight.normal,
                    height: 1 * b / a),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.watch_later_outlined),
            title: Column(
              children: [
                SizedBox(
                  height: 10 * a,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '   The total mic in any room',
                    textAlign: TextAlign.left,
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.normal,
                        height: 1 * b / a),
                  ),
                ),
                SizedBox(
                  height: 5 * a,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '   (5/5min)',
                    textAlign: TextAlign.left,
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.normal,
                        height: 1 * b / a),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 52 * a,
              height: 17 * a,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(255, 229, 0, 1),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9 * a),
                  topRight: Radius.circular(9 * a),
                  bottomLeft: Radius.circular(9 * a),
                  bottomRight: Radius.circular(9 * a),
                ),
              ),
              child: const Center(
                child: Text('Go'),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 60 * a),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9 * a),
                ),
                width: 140 * a,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: SliderComponentShape.noThumb,
                    ),
                    child: Slider(
                      min: 0,
                      max: 10,
                      value: 7,
                      onChanged: (double value) {},
                      inactiveColor: Colors.grey,
                      activeColor: Colors.yellow,
                    )),
              ),
              const Text('  '),
              Image.asset('assets/icons/ic_diamond.png'),
              Text(
                '+80',
                textAlign: TextAlign.left,
                style: safeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12 * a,
                    fontWeight: FontWeight.normal,
                    height: 1 * b / a),
              ),
            ],
          ),
          ListTile(
            leading: Image.asset('assets/dailytasks.png'),
            title: Column(
              children: [
                SizedBox(
                  height: 10 * a,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '  Recharge Diamonds',
                    textAlign: TextAlign.left,
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.normal,
                        height: 1 * b / a),
                  ),
                ),
                SizedBox(
                  height: 5 * a,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '   (5/5min)',
                    textAlign: TextAlign.left,
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.normal,
                        height: 1 * b / a),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 52 * a,
              height: 17 * a,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(255, 229, 0, 1),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9 * a),
                  topRight: Radius.circular(9 * a),
                  bottomLeft: Radius.circular(9 * a),
                  bottomRight: Radius.circular(9 * a),
                ),
              ),
              child: const Center(
                child: Text('Go'),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 60 * a),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9 * a),
                ),
                width: 140 * a,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: SliderComponentShape.noThumb,
                    ),
                    child: Slider(
                      min: 0,
                      max: 10,
                      value: 1,
                      onChanged: (double value) {},
                      inactiveColor: Colors.grey,
                      activeColor: Colors.yellow,
                    )),
              ),
              const Text('  '),
              Image.asset('assets/icons/ic_diamond.png'),
              Text(
                '+20',
                textAlign: TextAlign.left,
                style: safeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12 * a,
                    fontWeight: FontWeight.normal,
                    height: 1 * b / a),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.watch_later_outlined),
            title: Column(
              children: [
                SizedBox(
                  height: 10 * a,
                ),
                Text(
                  'Sending Diamond in any Room',
                  textAlign: TextAlign.left,
                  style: safeGoogleFont(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      'Poppins',
                      fontSize: 12 * a,
                      fontWeight: FontWeight.normal,
                      height: 1 * b / a),
                ),
                SizedBox(
                  height: 5 * a,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '   (5/5min)',
                    textAlign: TextAlign.left,
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.normal,
                        height: 1 * b / a),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 52 * a,
              height: 17 * a,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(255, 229, 0, 1),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9 * a),
                  topRight: Radius.circular(9 * a),
                  bottomLeft: Radius.circular(9 * a),
                  bottomRight: Radius.circular(9 * a),
                ),
              ),
              child: const Center(
                child: Text('Go'),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 60 * a),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9 * a),
                ),
                width: 140 * a,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: SliderComponentShape.noThumb,
                    ),
                    child: Slider(
                      min: 0,
                      max: 10,
                      value: 10,
                      onChanged: (double value) {},
                      inactiveColor: Colors.yellow,
                      activeColor: Colors.yellow,
                    )),
              ),
              const Text('  '),
              Image.asset('assets/icons/ic_diamond.png'),
              Text(
                '+250',
                textAlign: TextAlign.left,
                style: safeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12 * a,
                    fontWeight: FontWeight.normal,
                    height: 1 * b / a),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.watch_later_outlined),
            title: Column(
              children: [
                SizedBox(
                  height: 10 * a,
                ),
                Text(
                  'Sending Diamond in any Room',
                  textAlign: TextAlign.left,
                  style: safeGoogleFont(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      'Poppins',
                      fontSize: 12 * a,
                      fontWeight: FontWeight.normal,
                      height: 1 * b / a),
                ),
                SizedBox(
                  height: 5 * a,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '   (5/5min)',
                    textAlign: TextAlign.left,
                    style: safeGoogleFont(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        'Poppins',
                        fontSize: 12 * a,
                        fontWeight: FontWeight.normal,
                        height: 1 * b / a),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 52 * a,
              height: 17 * a,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(255, 229, 0, 1),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9 * a),
                  topRight: Radius.circular(9 * a),
                  bottomLeft: Radius.circular(9 * a),
                  bottomRight: Radius.circular(9 * a),
                ),
              ),
              child: const Center(
                child: Text('Go'),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 60 * a),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9 * a),
                ),
                width: 140 * a,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 10,
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: SliderComponentShape.noThumb,
                    ),
                    child: Slider(
                      min: 0,
                      max: 10,
                      value: 9,
                      onChanged: (double value) {},
                      inactiveColor: Colors.grey,
                      activeColor: Colors.yellow,
                    )),
              ),
              const Text('  '),
              Image.asset('assets/icons/ic_diamond.png'),
              Text(
                '+80',
                textAlign: TextAlign.left,
                style: safeGoogleFont(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    'Poppins',
                    fontSize: 12 * a,
                    fontWeight: FontWeight.normal,
                    height: 1 * b / a),
              ),
            ],
          )
        ],
      ),
    );
  }
}
