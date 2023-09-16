import 'package:flutter/material.dart';

class Playlist2 extends StatefulWidget {
  const Playlist2({super.key});

  @override
  State<Playlist2> createState() => _Playlist1State();
}

class _Playlist1State extends State<Playlist2> {
    double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
          leading: const Icon(Icons.arrow_back_ios_new_outlined),
          title: const Text(
            'Local',
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
          height: 91,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: ListTile(
            leading: Container(
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
                ),
              ),
            ),
            title: const Text('Over the Horizon', style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),),
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('1:00',style: TextStyle(color: Colors.white),),
            Text('1:00',style: TextStyle(color: Colors.white),),
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
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
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
