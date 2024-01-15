import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlist1 extends StatefulWidget {
  const Playlist1({super.key});

  @override
  State<Playlist1> createState() => _Playlist1State();
}

class _Playlist1State extends State<Playlist1> {
  // Main method.
  final OnAudioQuery _audioQuery = OnAudioQuery();
  // Indicate if application has permission to the library.
  bool _hasPermission = false;
  double _currentSliderValue = 1;

  @override
  void initState() {
    super.initState();
    // (Optinal) Set logging level. By default will be set to 'WARN'.
    //
    // Log will appear on:
    //  * XCode: Debug Console
    //  * VsCode: Debug Console
    //  * Android Studio: Debug and Logcat Console
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }

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
            'Songs',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: !_hasPermission
                ? noAccessToLibraryWidget()
                : FutureBuilder<List<SongModel>>(
                    // Default values:
                    future: _audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, item) {
                      // Display error, if any.
                      if (item.hasError) {
                        return Text(item.error.toString());
                      }

                      // Waiting content.
                      if (item.data == null) {
                        return const CircularProgressIndicator();
                      }

                      // 'Library' is empty.
                      if (item.data!.isEmpty)
                        return const Text("Nothing found!");

                      // You can use [item.data!] direct or you can create a:
                      // List<SongModel> songs = item.data!;
                      return ListView.builder(
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(item.data![index].title),
                            subtitle:
                                Text(item.data![index].artist ?? "No Artist"),
                            trailing: const Icon(Icons.arrow_forward_rounded),
                            // This Widget will query/load image.
                            // You can use/create your own widget/method using [queryArtwork].
                            leading: QueryArtworkWidget(
                              controller: _audioQuery,
                              id: item.data![index].id,
                              type: ArtworkType.AUDIO,
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
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

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
