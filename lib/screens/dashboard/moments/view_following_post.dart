import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:live_app/provider/moments_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/utils_assets.dart';

class ViewFollowingPost extends StatefulWidget {
  final int index;
  const ViewFollowingPost({super.key, required this.index});

  @override
  State<ViewFollowingPost> createState() => _ViewFollowingPostState();
}

class _ViewFollowingPostState extends State<ViewFollowingPost> {
  String? _commentValue;
  final TextEditingController _comment = TextEditingController();
  bool submit = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return  Consumer<MomentsProvider>(
        builder: (context, value, child) => Scaffold(
          body:Container(
            padding: EdgeInsets.only(
                left: 21 * a, right: 21 * a, top: 12 * a),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: (value.followingMoments[widget.index].userDetails?[0].images.toString()??'[]') == '[]'
                              ? CircleAvatar(
                            foregroundImage: const AssetImage("assets/profile.png"),
                            radius: 22 * a,
                          )
                              :CircleAvatar(
                            foregroundImage: NetworkImage(value.followingMoments[widget.index].userDetails!.first.images!.first!),
                            radius: 22 * a,
                          ),
                          title: Text(
                            value.followingMoments[widget.index].userDetails![0].name!,
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 18 * b,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * b / a,
                              letterSpacing: 0.8 * a,
                              color: const Color(0xff000000),
                            ),
                          ),
                          subtitle: Text(
                              TimeUtil.getTimeDifferenceString(value.followingMoments[widget.index].createdAt!),
                              overflow: TextOverflow.ellipsis,
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 15 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * b / a,
                                letterSpacing: 0.8 * a,
                                color: const Color(0x99000000),
                              )),
                        )),
                    GestureDetector(
                      onTap: report,
                      child: Container(
                        height: 17 * a,
                        margin: EdgeInsets.symmetric(
                            horizontal: 7 * a, vertical: 15 * a),
                        child: Image.asset(
                          'assets/icons/ic_three_dots.png',
                          width: 28 * a,
                          height: 8 * a,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (value.followingMoments[widget.index].images?.toString()??'[]') != '[]'
                        ?Hero(
                          tag: value.followingMoments[widget.index].id!,
                          child: Image.network(
                          value.followingMoments[widget.index].images!.first,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  value.followingMoments[widget.index].caption != null
                                      ? Text(
                                    value.followingMoments[widget.index].caption.toString(),
                                    style: SafeGoogleFont(
                                      'Poppins',
                                      fontSize: 14 * b,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5 * b / a,
                                      letterSpacing: 0.8 * a,
                                      color: const Color(0xff000000),
                                    ),
                                  )
                                      :const SizedBox.shrink(),
                                  child
                                ],
                              );
                            }
                            return Shimmer.fromColors(
                              baseColor: const Color.fromARGB(248, 188, 187, 187),
                              highlightColor: Colors.white,
                              period: const Duration(seconds: 1),
                              child: Container(
                                color: Colors.white,
                                width: 160 * a,
                                height: 160 * a,
                              ),
                            );
                          },
                          width: double.infinity,
                          fit: BoxFit.cover),
                        )
                        :Image.asset("assets/dummy/b1.png",
                        height: 160 * a,
                        fit: BoxFit.fitHeight),
                    Container(
                      height: 18 * a,
                      margin: EdgeInsets.symmetric(
                          horizontal: 9 * a, vertical: 12 * a),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LikeButton(
                            size: 27,
                            isLiked: value.checkLike(widget.index,all: true),
                            onTap: (isLiked) async {
                              value.likePost(value.followingMoments[widget.index].id!,all: true);
                              return !isLiked;
                            },
                            circleColor: const CircleColor(start: Color(0x339E26BC),end: Color(0xff9e26bc)),
                            bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff9e26bc),dotSecondaryColor: Color(0x339E26BC)),
                            likeBuilder: (bool isLiked) => Icon(
                              Icons.thumb_up,
                              color: isLiked ? const Color(0xff9e26bc) : Colors.grey,
                            ),
                            likeCount: value.followingMoments[widget.index].likes?.length??0,
                            countBuilder: (int? count, bool isLiked, String text) {
                              var color = isLiked ? const Color(0xff9e26bc)  : Colors.grey;
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
                          if(value.followingMoments[widget.index].userDetails!.first.isCommentRestricted == false)Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.mode_comment_outlined,color: Colors.grey),
                              SizedBox(width: 5 * a),
                              Text(
                                value.followingMoments[widget.index].comments?.length.toString()??'0',
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
                    const Divider(),
                    if(value.followingMoments[widget.index].userDetails!.first.isCommentRestricted == false)Text(
                      '${value.followingMoments[widget.index].comments?.length} Comments',
                      style: SafeGoogleFont(
                        'Poppins',
                        fontSize: 16 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.8 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                    if(value.followingMoments[widget.index].userDetails!.first.isCommentRestricted == false)Column(
                      children: List.generate(value.followingMoments[widget.index].comments?.length??0, (index) {
                        return ListTile(
                          leading: (value.followingMoments[widget.index].comments?[index].userId?[0].images?.toString()??'[]') == '[]'
                              ? CircleAvatar(
                            foregroundImage: const AssetImage("assets/profile.png"),
                            radius: 22 * a,
                          )
                              :CircleAvatar(
                            foregroundImage: NetworkImage(value.followingMoments[widget.index].comments![index].userId![0].images!.first),
                            radius: 22 * a,
                          ),
                          title: Text(value.followingMoments[widget.index].comments?[index].userId?[0].name??''),
                          subtitle: Text(value.followingMoments[widget.index].comments?[index].comment??''),
                          trailing: value.followingMoments[widget.index].comments?[index].userId?[0].id == value.storageService.getString(Constants.id)
                              ?IconButton(
                            onPressed: (){
                              value.deleteComment(widget.index,value.followingMoments[widget.index].id!, value.followingMoments[widget.index].comments![index].id!,all: true);
                            },
                            icon: const Icon(Icons.delete,color: Colors.grey),
                          )
                              :null,
                        );
                      }),
                    ),
                    SizedBox(height: 90*a),
                  ],
                ),
              ],
            ),
          ),
          bottomSheet: value.followingMoments[widget.index].userDetails!.first.isCommentRestricted == false
              ?Container(
            width: Get.width,
            color: const Color(0xFFD9D9D9),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      controller: _comment,
                      decoration: InputDecoration(
                          isDense: true,
                        errorText: _emptyValidator(_commentValue),
                        hintText: 'Write Comment',
                        hintStyle: const TextStyle(color: Colors.grey)
                      ),
                      onChanged: (value) {
                        setState(() {
                          _commentValue = value;
                        });
                      },

                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        submit = true;
                      });
                      if(_emptyValidator(_commentValue)==null) {
                        FocusScope.of(context).unfocus();
                        value.makeComment(widget.index,value.followingMoments[widget.index].id!, _commentValue!,all: true).then((value) {
                          if(value){
                            _comment.clear();
                          }else{
                            showCustomSnackBar('Error!',Get.context!);
                          }
                          return null;
                        });
                      }
                  },
                    child: value.isCommenting
                        ?Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 30,
                          width: 30,
                          child: const CircularProgressIndicator(color: Color(0xff9e26bc)),
                        )
                        :const Text('Send'))
              ],
            ),
          )
              :null,
      ),
    );;
  }

  void report() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report'),
            onTap: showReportReasons,
          ),
        );
      },
    );
  }

  void showReportReasons() {
    Get.back();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Reason for Reporting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Spam'),
                onTap: reportPost,
              ),
              ListTile(
                title: const Text('Inappropriate Content'),
                onTap: reportPost,
              ),
              ListTile(
                title: const Text('Other'),
                onTap: reportPost,
              ),
            ],
          ),
        );
      },
    );

  }

  void reportPost() {
    Get.back();
    showCustomSnackBar('Reported!',context,isError: false,isToaster: true);
  }

  _emptyValidator(value) {
    if ((value == null || value.isEmpty) && submit) {
      return 'This field cannot be empty';
    }
    return null;
  }
}
