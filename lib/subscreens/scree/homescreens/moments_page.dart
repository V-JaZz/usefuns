import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/model/response/moments_model.dart';
import '../../../provider/moments_provider.dart';
import '../../../screens/dashboard/moments/post_moments.dart';
import '../../../utils/helper.dart';
import '../../../utils/utils_assets.dart';

class MomentsPage extends StatefulWidget {
  final bool appBar;
  const MomentsPage({super.key, required this.appBar});

  @override
  State<MomentsPage> createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  @override
  void initState() {
    loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: widget.appBar ? AppBar(
        title: const Text('My Moments'),
      ):null,
        body: SafeArea(
          child: Consumer<MomentsProvider>(
            builder:(context, value, child) =>
            !value.isLoadedMy
                ?const Center(child: CircularProgressIndicator(color: Color(0xff9e26bc)))
                :( value.myMoments!.data!.isEmpty
                ? Center(
                  child: Container(
                    height: 50,
                    width: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=>const PostMoments());
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                            Text('  Post ur first moment'),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                :ImageGallery(myMoments: value.myMoments!.data!,)
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){Get.to(()=>const PostMoments());},tooltip: 'Add Moment',child: const Icon(Icons.add)),
    );
  }
  void loadData() {
    final momentsProvider = Provider.of<MomentsProvider>(context,listen: false);
    momentsProvider.getById();
  }
}
class ImageGallery extends StatefulWidget {
  final List<Datum> myMoments;

  const ImageGallery({super.key, required this.myMoments});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  int index = 0 ;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return Column(
      children: [
        Expanded(
          child: PhotoViewGallery.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.myMoments.length,
            onPageChanged: (i) {
              setState(() {
                index = i;
              });
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.myMoments[index].images!.first),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            pageController: PageController(),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 15 * a),
              LikeButton(
                size: 27,
                // isLiked: value.checkLike(widget.index,all: true),
                onTap: (isLiked) async {
                  return null;

                  // value.likePost(value.allMoments!.data![widget.index].id!,all: true);
                  // return !isLiked;
                },
                circleColor: const CircleColor(start: Color(0xff00ddff),end: Color(0xff0099cc)),
                bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff33b5e5),dotSecondaryColor: Color(0xff0099cc)),
                likeBuilder: (bool isLiked) => Icon(
                  Icons.thumb_up,
                  color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                ),
                likeCount: widget.myMoments[index].likes?.length??0,
                countBuilder: (int? count, bool isLiked, String text) {
                  var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                  Widget result;
                  result = Text(
                    text,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: color,
                    ),
                  );
                  return result;
                },
              ),
              SizedBox(width: 15 * a),
              if(widget.myMoments[index].isCommentRestricted == false)Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.mode_comment_outlined,color: Colors.grey),
                  SizedBox(width: 5 * a),
                  Text(
                    widget.myMoments[index].comments?.length.toString()??'0',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.48 * a,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<Widget> details() async {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 15 * a),
          LikeButton(
            size: 27,
            // isLiked: value.checkLike(widget.index,all: true),
            onTap: (isLiked) async {
              return null;

              // value.likePost(value.allMoments!.data![widget.index].id!,all: true);
              // return !isLiked;
            },
            circleColor: const CircleColor(start: Color(0xff00ddff),end: Color(0xff0099cc)),
            bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff33b5e5),dotSecondaryColor: Color(0xff0099cc)),
            likeBuilder: (bool isLiked) => Icon(
              Icons.thumb_up,
              color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
            ),
            likeCount: widget.myMoments[index].likes?.length??0,
            countBuilder: (int? count, bool isLiked, String text) {
              var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
              Widget result;
              result = Text(
                text,
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  letterSpacing: 0.48 * a,
                  color: color,
                ),
              );
              return result;
            },
          ),
          SizedBox(width: 15 * a),
          if(widget.myMoments[index].isCommentRestricted == false)Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.mode_comment_outlined,color: Colors.grey),
              SizedBox(width: 5 * a),
              Text(
                widget.myMoments[index].comments?.length.toString()??'0',
                style: SafeGoogleFont(
                  'Poppins',
                  fontSize: 16 * b,
                  fontWeight: FontWeight.w400,
                  height: 1.5 * b / a,
                  letterSpacing: 0.48 * a,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
