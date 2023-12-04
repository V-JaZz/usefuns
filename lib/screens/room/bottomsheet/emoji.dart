import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';


class EmojiBottomSheet extends StatefulWidget {
  const EmojiBottomSheet({Key? key}) : super(key: key);

  @override
  State<EmojiBottomSheet> createState() => _EmojiBottomSheetState();
}

class _EmojiBottomSheetState extends State<EmojiBottomSheet>  with TickerProviderStateMixin{

  void loadAnimation(SVGAAnimationController ac, String path) async {
    ac.videoItem = await SVGAParser.shared.decodeFromAssets(path);
    ac.forward(from: 0.8);
    ac.addListener(() {ac.stop();});
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 24 * a),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            runSpacing: 24 * a,
            spacing: 0 * a,
            children: [
              emojiThumbnailView('assets/emoji/broken.svga', false),
              emojiThumbnailView('assets/emoji/dead.svga', false),
              emojiThumbnailView('assets/emoji/disdain.svga', false),
              emojiThumbnailView('assets/emoji/laugh.svga', false),
              emojiThumbnailView('assets/emoji/laughcry.svga', false),
              emojiThumbnailView('assets/emoji/love.svga', false),
              emojiThumbnailView('assets/emoji/scared.svga', false),
              emojiThumbnailView('assets/emoji/sleep.svga', false),
            ],
          ),
        ],
      ),
    );
  }

  emojiThumbnailView(String path, bool vip) {
    SVGAAnimationController ac = SVGAAnimationController(vsync: this);
    loadAnimation(ac, path);
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    return GestureDetector(
      onTap: (){
        Provider.of<ZegoRoomProvider>(context,listen: false).reactEmoji(path);
        Get.back();
      },
      child: SizedBox(
        width: Get.width/4,
        height: 68 * a,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              // top: 11 * a,
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                width: 54 * a,
                height: 54 * a,
                child: SVGAImage(ac),
              ),
            ),
            if (vip)
              Positioned(
                left: 35 * a,
                top: 0 * a,
                child: Container(
                  width: 58 * a,
                  height: 18 * a,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9 * a),
                    color: const Color(0xffffe500),
                  ),
                  child: Center(
                    child: Text(
                      'SVIP',
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 12 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.171875 * b / a,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
