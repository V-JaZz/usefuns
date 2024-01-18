import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class RoomMediaPlayer extends StatefulWidget {
  const RoomMediaPlayer({super.key});

  @override
  State<RoomMediaPlayer> createState() => _RoomMediaPlayerState();
}

class _RoomMediaPlayerState extends State<RoomMediaPlayer> with TickerProviderStateMixin {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _hasPermission = false;
  bool mixer = false;
  late final ZegoRoomProvider zp;
  late AnimationController _controller;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // (Optional) Set logging level. By default will be set to 'WARN'.
    LogConfig logConfig = LogConfig(logType: LogType.WARN);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();

    //init zego media player
    zp =Provider.of<ZegoRoomProvider>(context,listen: false);
    if(zp.mediaPlayer==null) zp.initMediaPlayer();

    //const animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    timer.cancel();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    _hasPermission ? setState(() {}) : null;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Consumer<ZegoRoomProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 75 * a,
            automaticallyImplyLeading: true,
            backgroundColor: const Color(0xffFF9933),
            foregroundColor: Colors.white,
            title: const Text(
              'Songs',
            ),
          ),
          body: Center(
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
                      if (item.data!.isEmpty) {
                        return const Text("Nothing found!");
                      }

                      // You can use [item.data!] direct or you can create a:
                      // List<SongModel> songs = item.data!;
                      return ListView.builder(
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          bool selected = item.data![index].id == value.loadedTrack?.id;
                          return ListTile(
                            tileColor: selected ? const Color(0x33FF9933) : null,
                            onTap: () async {
                              if(value.mediaPlayer==null){
                                print('mediaPlayer == null');
                              }else{
                                bool loadSuccess = await value.loadLocalMedia(item.data![index]);
                                if(loadSuccess){
                                  await value.mediaPlayer?.start();
                                  if (value.isPlaying == false) {
                                    value.isPlaying = true;
                                    _controller.reverse();
                                  }
                                }else{
                                  if (value.isPlaying == true) {
                                    value.isPlaying = false;
                                    _controller.forward();
                                  }
                                }
                              }
                            },
                            title: Text(item.data![index].title),
                            subtitle: Text(item.data![index].artist ?? "No Artist"),
                            // This Widget will query/load image.
                            // You can use/create your own widget/method using [queryArtwork].
                            leading: Icon(
                                selected ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                                color: const Color(0xffFF9933),
                                size: 45*a),
                          );
                        },
                      );
                    },
                  ),
          ),
          bottomNavigationBar: value.loadedTrack != null? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(mixer)Container(
                padding: EdgeInsets.symmetric(horizontal: 15*a, vertical: 8*a),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            Icons.volume_up_rounded,
                            color:Color(0xffFF9933)
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Volume',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      min: 20,
                      max: 160,
                      value: value.trackVolume.toDouble(),
                      activeColor: const Color(0xffFF9933),
                      onChanged: (volume) {
                        int round = volume.round();
                        if(round!=value.trackVolume){
                          value.trackVolume = round;
                        }
                        },
                    ),
                  ],
                ),
              ),
              // SliderTheme(
              //     data: SliderTheme.of(context).copyWith(
              //         trackHeight: 5,
              //         overlayShape: SliderComponentShape.noOverlay,
              //         thumbShape: SliderComponentShape.noThumb,
              //         trackShape: const RectangularSliderTrackShape()
              //     ),
              //     child: Slider(
              //       min: 0,
              //       max: value.trackDuration,
              //       value: progress,
              //       onChanged: (double value) {},
              //       inactiveColor: Colors.white,
              //       activeColor: const Color(0xffFF9933),
              //     )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15*a, vertical: 8*a),
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          value.inLoop = !value.inLoop;
                        },
                        icon: Stack(
                          children: [
                            Icon(
                              Icons.loop_rounded,
                              color: value.inLoop?const Color(0xffFF9933):Colors.white,
                            ),
                            Container(
                              height: 24,
                              width: 24,
                              alignment: Alignment.center,
                              child: Text(
                                '1',
                                style: TextStyle(color: value.inLoop?const Color(0xffFF9933):Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (value.isPlaying == false) {
                            value.isPlaying = true;
                          await value.mediaPlayer?.resume();
                            _controller.reverse();
                        } else {
                            value.isPlaying = false;
                          await value.mediaPlayer?.pause();
                            _controller.forward();
                        }
                      },
                      child: AnimatedIcon(
                        icon: AnimatedIcons.pause_play,
                        progress: _controller,
                        size: 50*a,
                        color: value.isPlaying?const Color(0xffFF9933):Colors.white,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            mixer = !mixer;
                          });
                        },
                        icon: Icon(
                            CupertinoIcons.slider_horizontal_3,
                          color: mixer?const Color(0xffFF9933):Colors.white,
                        )
                    )
                  ],
                ),
              ),
            ],
          ):null
      ),
    );
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
