import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';

class Playlist1 extends StatefulWidget {
  const Playlist1({super.key});

  @override
  State<Playlist1> createState() => _Playlist1State();
}

class _Playlist1State extends State<Playlist1> {
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75 * a,
          automaticallyImplyLeading: true,
          backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
          title: const Text(
            'Playlist',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            playmethod('Over the Horizon', 'samsung'),
            playmethod('Calm', 'samsung'),
            playmethod('Music Box', 'samsung'),
            playmethod('Nudge', 'samsung'),
            playmethod('PiggyBank', 'samsung'),
          ]),
        ),
        bottomNavigationBar: Container(
          height: 91 * a,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: ListTile(
            leading: Container(
              height: 25 * a,
              width: 25 * a,
              decoration: BoxDecoration(
                color: const Color(0xffFF9933),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              'Over the Horizon',
              style: SafeGoogleFont(
                'Roboto',
                fontSize: 12 * b,
                fontWeight: FontWeight.w400,
                height: 1.1725 * b / a,
                color: const Color(0xffffffff),
              ),
            ),
            subtitle: Column(
              children: [
                SliderTheme(
                  data: const SliderThemeData(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Color(0xff8d8e98),
                    thumbColor: Colors.transparent,
                  ),
                  child: Slider(
                    value: _currentSliderValue,
                    max: 50,
                    min: 1,
                    divisions: 5,
                    activeColor: const Color(0xffFF9933),
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0:00',
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 16 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.1725 * b / a,
                        color: const Color(0xffffffff),
                      ),
                    ),
                    Text(
                      '03:30',
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 16 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.1725 * b / a,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  SizedBox playmethod(text, text1) {
    return SizedBox(
      width: double.infinity,
      child: ListTile(
        title: Text(
          text,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        subtitle: Text(
          text1,
          style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.normal),
        ),
        trailing: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: const Color(0xffFF9933),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
              child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
