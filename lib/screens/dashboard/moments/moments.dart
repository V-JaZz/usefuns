import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/provider/moments_provider.dart';
import 'package:live_app/screens/dashboard/moments/post_moments.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../provider/user_data_provider.dart';
import 'common/moments_tab_view.dart';

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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0x189E26BC),
      appBar: AppBar(
        backgroundColor: const Color(0x339E26BC),
        surfaceTintColor: Colors.transparent,
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
                    color: Colors.black54,
                  ),
                  Text(
                    'No Posts yet',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.64 * a,
                      color: Colors.black54,
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
                    child: const MomentsTabView(all: false),
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
                    color: Colors.black54,
                  ),
                  Text(
                    'No Following yet',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.64 * a,
                      color: Colors.black54,
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
                    color: Colors.black54,
                  ),
                  Text(
                    'No Posts yet',
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 16 * b,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * b / a,
                      letterSpacing: 0.64 * a,
                      color: Colors.black54,
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
                    child:  const MomentsTabView(all: true),
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
}
