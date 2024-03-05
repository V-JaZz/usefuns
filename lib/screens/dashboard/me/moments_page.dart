import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:live_app/screens/dashboard/me/profile/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/datasource/local/sharedpreferences/storage_service.dart';
import '../../../data/model/response/moments_model.dart';
import '../../../provider/moments_provider.dart';
import '../../../provider/user_data_provider.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../../../utils/utils_assets.dart';
import '../moments/common/moment_view.dart';
import '../moments/post_moments.dart';

class MomentsPage extends StatefulWidget {
  final String? userId;
  final bool appBar;
  const MomentsPage({super.key, required this.appBar, this.userId});

  @override
  State<MomentsPage> createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  MomentsModel? momentsModel;
  @override
  void initState() {
    loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.appBar ? AppBar(
        backgroundColor: const Color(0x339E26BC),
        surfaceTintColor: Colors.transparent,
        title: const Text('My Moments'),
      ):null,
        body: Builder(
          builder:(context) =>
          momentsModel?.data == null
              ?const Center(child: CircularProgressIndicator(color: Color(0xff9e26bc)))
              :( momentsModel!.data!.isEmpty
                ? Center(
                child: Container(
                  height: 50,
                  width: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.yellow,
                  ),
                  child: Center(
                    child: widget.userId == null
                        ? GestureDetector(
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
                          )
                        : const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('No moments posted'),
                          ],
                        ),
                  ),
                ),
                )
                : MyMoments(moments: momentsModel!.data!)),
        ),
      floatingActionButton: widget.userId == null?FloatingActionButton(onPressed: (){Get.to(()=>const PostMoments());},tooltip: 'Add Moment',child: const Icon(Icons.add)):null,
    );
  }

  void loadData() async {
    momentsModel = await Provider.of<MomentsProvider>(context,listen: false).getById(id: widget.userId);
    setState(() {
    });
  }
}

class MyMoments extends StatefulWidget {
  final List<Moment> moments;
  const MyMoments({super.key, required this.moments});

  @override
  State<MyMoments> createState() => _MyMomentsState();
}

class _MyMomentsState extends State<MyMoments> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    String myId = StorageService().getString(Constants.userId);

    final moments = widget.moments;

    return ListView(
      children: List.generate(moments.length,(index) {
        return Card(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(
                left: 21 * a, right: 21 * a, top: 12 * a, bottom: 12 * a),
            margin: (moments.length-1)==index ? EdgeInsets.only(bottom: 63*a):null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: (){
                    if(moments[index].userDetails?.userId == myId){
                      Get.to(()=>const UserProfile());
                      return;
                    }
                    Provider.of<UserDataProvider>(context,listen: false).addVisitor(moments[index].userDetails!.id!);
                    Get.to(()=>UserProfile(userData: moments[index].userDetails!));
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: (moments[index].userDetails?.images.toString()??'[]') == '[]'
                      ? CircleAvatar(
                    foregroundImage: const AssetImage("assets/profile.png"),
                    radius: 22 * a,
                  )
                      :CircleAvatar(
                    foregroundImage: NetworkImage(moments[index].userDetails!.images!.first),
                    radius: 22 * a,
                  ),
                  title: Text(
                    moments[index].userDetails!.name!,
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
                      TimeUtil.getTimeDifferenceString(moments[index].createdAt!),
                      overflow: TextOverflow.ellipsis,
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 15 * b,
                        fontWeight: FontWeight.w300,
                        height: 1.5 * b / a,
                        letterSpacing: 0.8 * a,
                        color: const Color(0x99000000),
                      )),
                  trailing:
                  IconButton(
                    onPressed: () => report(moments[index].userDetails!.id!),
                    icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(moments[index].caption != null) Text(
                      moments[index].caption.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: safeGoogleFont(
                        'Poppins',
                        fontSize: 14 * b,
                        fontWeight: FontWeight.w400,
                        height: 1.5 * b / a,
                        letterSpacing: 0.8 * a,
                        color: const Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 3*a),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>ViewMoment(moment: moments[index]));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          (moments[index].images?.toString()??'[]') != '[]'
                              ?Image.network(
                              moments[index].images!.first,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
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
                              height: 160 * a,
                              width: 160 * a,
                              fit: BoxFit.cover
                          )
                              :Image.asset('assets/dummy/b1.png',
                              height: 160 * a,
                              fit: BoxFit.fitHeight),
                          Container(
                            height: 18 * a,
                            margin: EdgeInsets.symmetric(
                                horizontal: 7 * a, vertical: 3 * a),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LikeButton(
                                  size: 27,
                                  isLiked: Provider.of<MomentsProvider>(context).checkLike(moments[index].id!,all: true),
                                  onTap: (isLiked) async {
                                    Provider.of<MomentsProvider>(context,listen: false).likePost(moments[index].id!,all: true);
                                    return !isLiked;
                                  },
                                  circleColor: const CircleColor(start: Color(0x339E26BC),end: Color(0xff9e26bc)),
                                  bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff9e26bc),dotSecondaryColor: Color(0x339E26BC)),
                                  likeBuilder: (bool isLiked) => Icon(
                                    Icons.thumb_up,
                                    color: isLiked ? const Color(0xff9e26bc) : Colors.grey,
                                  ),
                                  likeCount: moments[index].likes?.length??0,
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.mode_comment_outlined,color: Colors.grey),
                                    SizedBox(width: 5 * a),
                                    Text(
                                      moments[index].comments?.length.toString()??'0',
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
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void report(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report'),
            onTap: (){
              showReportReasons(id);
            },
          ),
        );
      },
    );
  }

  void showReportReasons(String id) {
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
                onTap: (){
                  Get.back();
                  reportUser(id,'Spam');
                },
              ),
              ListTile(
                title: const Text('Inappropriate Content'),
                onTap: (){
                  Get.back();
                  reportUser(id,'Inappropriate Content');
                },
              ),
              ListTile(
                title: const Text('Other'),
                onTap: (){
                  Get.back();
                  reportUser(id,'Other');
                },
              ),
            ],
          ),
        );
      },
    );

  }

  void reportUser(String id, String message) async {
    final value = Provider.of<MomentsProvider>(context,listen: false);
    await value.reportUser(id: id,message: message);
    showCustomSnackBar('Reported!',Get.context!,isError: false,isToaster: true);
  }
}
