import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:live_app/provider/moments_provider.dart';
import 'package:live_app/screens/dashboard/moments/post_moments.dart';
import 'package:live_app/screens/dashboard/moments/view_featured_post.dart';
import 'package:live_app/screens/dashboard/moments/view_following_post.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/datasource/local/sharedpreferences/storage_service.dart';
import '../../../provider/user_data_provider.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper.dart';
import '../me/profile/user_profile.dart';

class Moments extends StatefulWidget {
  const Moments({Key? key}) : super(key: key);

  @override
  State<Moments> createState() => _MomentsState();
}

class _MomentsState extends State<Moments> with TickerProviderStateMixin {
  late TabController tabController;
  RefreshController refreshController = RefreshController();
  RefreshController refreshController2 = RefreshController();
  RefreshController refreshController3 = RefreshController();

  int index = 0;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    final momentsProvider = Provider.of<MomentsProvider>(context, listen: false);
    if((Provider.of<UserDataProvider>(context,listen: false).userData?.data?.following?.toString()??'[]') != '[]') {
      momentsProvider.emptyFollowings = false;
      momentsProvider.getFollowingMoments();
    }
    tabController.addListener(() {
      print('value1 ${tabController.index}');
      index = tabController.index;
      switch(tabController.index){
        case 0 :
          momentsProvider.getFollowingMoments();
        case 1:
          momentsProvider.getAllMoments();
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    tabController.removeListener((){});
    tabController.dispose();
    refreshController.dispose();
    refreshController2.dispose();
    refreshController3.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    String myId =StorageService().getString(Constants.userId);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1,
        title: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 6 * a),
          indicatorWeight: 1.3,
          dividerColor: Colors.transparent,
          labelColor: const Color(0xff000000),
          unselectedLabelColor: const Color(0x99000000),
          labelStyle: SafeGoogleFont(
            'Poppins',
            fontSize: 18 * b,
            fontWeight: FontWeight.w400,
            height: 1.5 * b / a,
            letterSpacing: 0.96 * a,
            color: const Color(0xff000000),
          ),
          unselectedLabelStyle: SafeGoogleFont(
            'Poppins',
            fontSize: 18 * b,
            fontWeight: FontWeight.w400,
            height: 1.5 * b / a,
            letterSpacing: 0.96 * a,
            color: const Color(0x99000000),
          ),
          padding: EdgeInsets.symmetric(horizontal: 36 * a),
          labelPadding: EdgeInsets.zero,
          tabs: const [
            Tab(
              text: "Following",
            ),
            Tab(
              text: "Featured",
            ),
          ],
        ),
      ),
      body: Consumer<MomentsProvider>(
          builder:(context, value, child) => SmartRefresher(
          enablePullDown: true,
          onRefresh: ()async{
            if(index==0){
              await value.getFollowingMoments(refresh: true);
            }else{
              await value.getAllMoments(refresh: true);
            }
            refreshController.refreshCompleted();
            return;
          },
          physics: const BouncingScrollPhysics(),
          header: WaterDropMaterialHeader(distance: 36*a),
          controller: refreshController,
            child: TabBarView(
              controller: tabController,
            children: [
              !value.emptyFollowings
                  ? (!value.isLoadedFollowing
                  ?const Center(child: CircularProgressIndicator(color: Color(0xff9e26bc)))
                  :( value.followingMoments.isEmpty
                  ?Column(
                children: [
                  SizedBox(
                    height: Get.width / 4,
                  ),
                  Image.asset(
                    "assets/icons/ic_empty.png",
                    width: Get.width / 2,
                    height: Get.width / 2,
                  ),
                  Text(
                    'No Posts yet',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.64 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              )
                  :SmartRefresher(
                enablePullDown: true,
                onRefresh: ()async{
                  await value.getFollowingMoments(refresh: true);
                  refreshController2.refreshCompleted();
                  return;
                },
                physics: const BouncingScrollPhysics(),
                header: WaterDropMaterialHeader(distance: 36*a),
                controller: refreshController2,
                    child: ListView(
                children: List.generate(value.followingMoments.length,(index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 21 * a, right: 21 * a, top: 12 * a, bottom: 12 * a),
                    margin: (value.followingMoments.length-1)==index ? EdgeInsets.only(bottom: 63*a):null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        value.followingMoments[index].userDetails!.isNotEmpty
                            ?ListTile(
                          onTap: (){
                            if(value.followingMoments[index].userDetails?[0].userId == myId){
                              Get.to(()=>const UserProfile());
                              return;
                            }
                            Provider.of<UserDataProvider>(context,listen: false).addVisitor(value.followingMoments[index].userDetails![0].id!);
                            Get.to(()=>UserProfile(userData: value.followingMoments[index].userDetails![0]));
                          },
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: (value.followingMoments[index].userDetails?[0].images.toString()??'[]') == '[]'
                              ? CircleAvatar(
                            foregroundImage: const AssetImage("assets/profile.png"),
                            radius: 22 * a,
                          )
                              :CircleAvatar(
                            foregroundImage: NetworkImage(value.followingMoments[index].userDetails!.first.images!.first),
                            radius: 22 * a,
                          ),
                          title: Text(
                            value.followingMoments[index].userDetails![0].name!,
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
                              TimeUtil.getTimeDifferenceString(value.followingMoments[index].createdAt!),
                              overflow: TextOverflow.ellipsis,
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 15 * b,
                                fontWeight: FontWeight.w300,
                                height: 1.5 * b / a,
                                letterSpacing: 0.8 * a,
                                color: const Color(0x99000000),
                              )),
                          trailing:
                          IconButton(
                            onPressed: () => report(value.followingMoments[index].userDetails![0].id!),
                            icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
                          ),
                        )
                            :const ListTile(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if(value.followingMoments[index].caption != null) Text(
                              value.followingMoments[index].caption.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: SafeGoogleFont(
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
                                Get.to(()=>ViewFollowingPost(index: index));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  (value.followingMoments[index].images?.toString()??'[]') != '[]'
                                      ?Hero(
                                    tag: value.followingMoments[index].id!,
                                    child: Image.network(
                                        value.followingMoments[index].images!.first,
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
                                    ),
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
                                          isLiked: value.checkLike(index,all: true),
                                          onTap: (isLiked) async {
                                            value.likePost(value.followingMoments[index].id!,all: true);
                                            return !isLiked;
                                          },
                                          circleColor: const CircleColor(start: Color(0x339E26BC),end: Color(0xff9e26bc)),
                                          bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff9e26bc),dotSecondaryColor: Color(0x339E26BC)),
                                          likeBuilder: (bool isLiked) => Icon(
                                            Icons.thumb_up,
                                            color: isLiked ? const Color(0xff9e26bc) : Colors.grey,
                                          ),
                                          likeCount: value.followingMoments[index].likes?.length??0,
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
                                        if(value.followingMoments[index].userDetails!.first.isCommentRestricted == false)Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.mode_comment_outlined,color: Colors.grey),
                                            SizedBox(width: 5 * a),
                                            Text(
                                              value.followingMoments[index].comments?.length.toString()??'0',
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
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ),
                  )))
                  :Column(
                children: [
                  SizedBox(
                    height: Get.width / 4,
                  ),
                  Image.asset(
                    "assets/icons/ic_empty.png",
                    width: Get.width / 2,
                    height: Get.width / 2,
                  ),
                  Text(
                    'No Following yet',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.64 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              ),

              !value.isLoadedAll
                  ?const Center(child: CircularProgressIndicator(color: Color(0xff9e26bc)))
                  :( value.allMoments.isEmpty
                  ?Column(
                children: [
                  SizedBox(
                    height: Get.width / 4,
                  ),
                  Image.asset(
                    "assets/icons/ic_empty.png",
                    width: Get.width / 2,
                    height: Get.width / 2,
                  ),
                  Text(
                    'No Posts yet',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.64 * a,
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              )
                  :SmartRefresher(
                enablePullDown: true,
                onRefresh: ()async{
                  await value.getAllMoments(refresh: true);
                  refreshController3.refreshCompleted();
                  return;
                },
                physics: const BouncingScrollPhysics(),
                header: WaterDropMaterialHeader(distance: 36*a),
                controller: refreshController3,
                    child: ListView(
                children: List.generate(value.allMoments.length??0, (index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 21 * a, right: 21 * a, top: 12 * a, bottom: 12 * a),
                      margin: (value.allMoments.length-1)==index ? EdgeInsets.only(bottom: 63*a):null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          value.allMoments[index].userDetails!.isNotEmpty
                              ?ListTile(
                            onTap: (){
                              if(value.allMoments[index].userDetails?[0].userId == myId){
                                Get.to(()=>const UserProfile());
                                return;
                              }
                              Provider.of<UserDataProvider>(context,listen: false).addVisitor(value.allMoments[index].userDetails![0].id!);
                              Get.to(()=>UserProfile(userData: value.allMoments[index].userDetails![0]));
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: (value.allMoments[index].userDetails?[0].images.toString()??'[]') == '[]'
                            ? CircleAvatar(
                          foregroundImage: const AssetImage("assets/profile.png"),
                          radius: 22 * a,
                            )
                            :CircleAvatar(
                          foregroundImage: NetworkImage(value.allMoments[index].userDetails!.first.images!.first),
                          radius: 22 * a,
                            ),
                            title: Text(
                          value.allMoments[index].userDetails![0].name!,
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
                            TimeUtil.getTimeDifferenceString(value.allMoments[index].createdAt!),
                            overflow: TextOverflow.ellipsis,
                            style: SafeGoogleFont(
                              'Poppins',
                              fontSize: 15 * b,
                              fontWeight: FontWeight.w300,
                              height: 1.5 * b / a,
                              letterSpacing: 0.8 * a,
                              color: const Color(0x99000000),
                            )),
                            trailing:
                            IconButton(
                              onPressed: () => report(value.allMoments[index].userDetails![0].id!),
                              icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
                            ),
                          )
                              :const ListTile(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if(value.allMoments[index].caption != null) Text(
                                value.allMoments[index].caption.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: SafeGoogleFont(
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
                                  Get.to(()=>ViewFeaturedPost(index: index));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    (value.allMoments[index].images?.toString()??'[]') != '[]'
                                        ?Hero(
                                      tag: value.allMoments[index].id!,
                                      child: Image.network(
                                          value.allMoments[index].images!.first,
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
                                      ),
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
                                              isLiked: value.checkLike(index,all: true),
                                              onTap: (isLiked) async {
                                                value.likePost(value.allMoments[index].id!,all: true);
                                                return !isLiked;
                                              },
                                              circleColor: const CircleColor(start: Color(0x339E26BC),end: Color(0xff9e26bc)),
                                              bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff9e26bc),dotSecondaryColor: Color(0x339E26BC)),
                                              likeBuilder: (bool isLiked) => Icon(
                                              Icons.thumb_up,
                                              color: isLiked ? const Color(0xff9e26bc) : Colors.grey,
                                            ),
                                              likeCount: value.allMoments[index].likes?.length??0,
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
                                          if(value.allMoments[index].userDetails!.first.isCommentRestricted == false)Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.mode_comment_outlined,color: Colors.grey),
                                              SizedBox(width: 5 * a),
                                              Text(
                                                value.allMoments[index].comments?.length.toString()??'0',
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
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                }),
              ),
                  )
              )
            ],
        ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){Get.to(()=>const PostMoments());},
          tooltip: 'Add Moment',
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
