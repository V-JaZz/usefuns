import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:live_app/data/model/response/moments_model.dart';
import 'package:live_app/provider/moments_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/common_widgets.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/utils_assets.dart';

class ViewMoment extends StatefulWidget {
  final Moment moment;
  const ViewMoment({super.key,required this.moment});

  @override
  State<ViewMoment> createState() => _ViewMomentState();
}

class _ViewMomentState extends State<ViewMoment> {
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
                        leading: (widget.moment.userDetails?.images.toString()??'[]') == '[]'
                            ? CircleAvatar(
                          foregroundImage: const AssetImage("assets/profile.png"),
                          radius: 22 * a,
                        )
                            :CircleAvatar(
                          foregroundImage: NetworkImage(widget.moment.userDetails!.images!.first),
                          radius: 22 * a,
                        ),
                        title: Text(
                          widget.moment.userDetails!.name!,
                          style: safeGoogleFont(
                            'Poppins',
                            fontSize: 18 * b,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * b / a,
                            letterSpacing: 0.8 * a,
                            color: const Color(0xff000000),
                          ),
                        ),
                        subtitle: Text(
                            TimeUtil.getTimeDifferenceString(widget.moment.createdAt!),
                            overflow: TextOverflow.ellipsis,
                            style: safeGoogleFont(
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
                  (widget.moment.images?.toString()??'[]') != '[]'
                      ?Image.network(
                      widget.moment.images!.first,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.moment.caption != null
                                      ? Text(
                                    widget.moment.caption.toString(),
                                    style: safeGoogleFont(
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
                          fit: BoxFit.cover)
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
                          isLiked: value.checkLike(widget.moment.id!,all: true),
                          onTap: (isLiked) async {
                            value.likePost(widget.moment.id!,all: true);
                            return !isLiked;
                          },
                          circleColor: const CircleColor(start: Color(0x339E26BC),end: Color(0xff9e26bc)),
                          bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff9e26bc),dotSecondaryColor: Color(0x339E26BC)),
                          likeBuilder: (bool isLiked) => Icon(
                            Icons.thumb_up,
                            color: isLiked ? const Color(0xff9e26bc) : Colors.grey,
                          ),
                          likeCount: widget.moment.likes?.length??0,
                          countBuilder: (int? count, bool isLiked, String text) {
                            var color = isLiked ? const Color(0xff9e26bc)  : Colors.grey;
                            Widget result;
                            result = Text(
                              text,
                              style: safeGoogleFont(
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
                        if(widget.moment.userDetails!.isCommentRestricted == false)Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.mode_comment_outlined,color: Colors.grey),
                            SizedBox(width: 5 * a),
                            Text(
                              widget.moment.comments?.length.toString()??'0',
                              style: safeGoogleFont(
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
                  if(widget.moment.userDetails!.isCommentRestricted == false)Text(
                    '${widget.moment.comments?.length} Comments',
                    style: safeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.8 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                  if(widget.moment.userDetails!.isCommentRestricted == false)Column(
                    children: List.generate(widget.moment.comments?.length??0, (index) {
                      return ListTile(
                        // leading: (value.allMoments[widget.index].comments?[index].userId?[0].images?.toString()??'[]') == '[]'
                        //     ? CircleAvatar(
                        //   foregroundImage: const AssetImage("assets/profile.png"),
                        //   radius: 22 * a,
                        // )
                        //     :CircleAvatar(
                        //   foregroundImage: NetworkImage(value.allMoments[widget.index].comments![index].userId![0].images!.first),
                        //   radius: 22 * a,
                        // ),
                        // title: Text(value.allMoments[widget.index].comments?[index].userId?[0].name??''),
                        subtitle: Text(widget.moment.comments?[index].comment??''),
                        trailing: widget.moment.comments?[index].userId == value.storageService.getString(Constants.id)
                            ?IconButton(
                          onPressed: (){
                            value.deleteComment(widget.moment.id!, widget.moment.comments![index].id!,all: true);
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
        bottomSheet: widget.moment.userDetails!.isCommentRestricted == false
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
                      value.makeComment(widget.moment.id!, _commentValue!,all: true).then((value) {
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
    );
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

  void reportUser(String id, String message) async {
    final value = Provider.of<MomentsProvider>(context,listen: false);
    await value.reportUser(id: id,message: message);
    showCustomSnackBar('Reported!',Get.context!,isError: false,isToaster: true);
  }
}
