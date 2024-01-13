import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/model/response/rooms_model.dart';
import '../../../../provider/rooms_provider.dart';
import '../../../../utils/common_widgets.dart';
import '../../../room/widget/pre_loading_dailog.dart';

class PopularTabView extends StatefulWidget {
  const PopularTabView({super.key});

  @override
  State<PopularTabView> createState() => _PopularTabViewState();
}

class _PopularTabViewState extends State<PopularTabView> {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  bool loadedAll = false;
  int page = 1;

  @override
  void initState() {
    loadData();
    scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> loadData({bool refresh = false}) async {
    final success = await Provider.of<RoomsProvider>(context,listen: false).getAllPopular(page,refresh);
    if(success == false){
      setState(() => loadedAll = true);
    }else{
      page++;
    }
  }

  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !loadedAll) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SmartRefresher(
      enablePullDown: true,
      onRefresh: () async {
        page = 1;
        await loadData(refresh: true);
        loadedAll = false;
        refreshController.refreshCompleted();
        return;
      },
      physics: const BouncingScrollPhysics(),
      header: WaterDropMaterialHeader(distance: 36 * a),
      controller: refreshController,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10 * a),
        child: Column(
          children: [
            SizedBox(height: 15 * a),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10 * a),
              child: Consumer<RoomsProvider>(
                builder: (context, value, child) {
                  return value.bannerList.isEmpty
                      ? Shimmer.fromColors(
                      highlightColor: Theme.of(context)
                          .primaryColor
                          .withOpacity(0.3),
                      baseColor: Theme.of(context)
                          .primaryColor
                          .withOpacity(0.1),
                      child: Container(height: Get.width / 3, width: Get.width, color: Colors.white))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12 * a),
                          child: SizedBox(
                            height: Get.width / 3,
                            width: Get.width,
                            child: ImageSlideshow(
                              width: Get.width,
                              height: Get.width / 3,
                              initialPage: 0,
                              indicatorColor: Theme.of(context).primaryColor,
                              indicatorBackgroundColor: Colors.grey.shade400,
                              autoPlayInterval: 5400,
                              isLoop: true,
                              children: value.bannerList.isNotEmpty
                                  ? List.generate(value.bannerList.length,
                                      (index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          String link =
                                              value.bannerList[index].link!;
                                          if (await canLaunchUrl(
                                              Uri.parse(link))) {
                                            await launchUrl(Uri.parse(link),
                                                mode: LaunchMode.inAppWebView);
                                          } else {
                                            throw 'Could not launch $link';
                                          }
                                        },
                                        child: Image.network(
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Shimmer.fromColors(
                                                highlightColor: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.3),
                                                baseColor: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                                child: Container(
                                                  color: Colors.white,
                                                ),
                                              );
                                            }
                                          },
                                          value.bannerList[index].images!
                                                  .isEmpty
                                              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXia6hKP5CZMdeV1ti5ayWkDB82w-QFPm8ow&usqp=CAU'
                                              : value.bannerList[index].images!
                                                  .first,
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    })
                                  : [],
                            ),
                          ),
                        );
                },
              ),
            ),
            SizedBox(
              height: 15 * a,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              showCustomSnackBar('Upcoming!', context,
                                  isError: false);
                              // Get.to(() => const Ranking());
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/icons/ranking.png',
                                    width: 30 * a, height: 30 * a),
                                Text(
                                  'Ranking',
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
                          )),
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              //todo
                              // Get.to(() => const UsefunsClub());
                              showCustomSnackBar('Upcoming!', context,
                                  isError: false);
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/icons/club.png',
                                    width: 30 * a, height: 30 * a),
                                Text(
                                  'Family',
                                  maxLines: 1,
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
                          )),
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              //todo:
                              // Get.to(() => const Party());
                              showCustomSnackBar('Upcoming!', context,
                                  isError: false);
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/icons/party.png',
                                    width: 30 * a, height: 30 * a),
                                Text(
                                  'Party',
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
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10 * a,
                  ),
                  Expanded(
                    child: Consumer<RoomsProvider>(
                      builder: (context, value, child) {
                        if(value.popularRooms.isEmpty){
                          return const Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: value.popularRooms.length+1,
                          itemBuilder: (context, index) {
                            if (index < value.popularRooms.length){
                              final room = value.popularRooms[index];
                              return roomListTile(
                                image: room.images!.isEmpty
                                    ? null
                                    : room.images!.first,
                                title: room.name.toString(),
                                subTitle: room.announcement,
                                active:
                                room.activeUsers?.length.toString() ??
                                    '0',
                                isLocked: room.isLocked??false,
                                onTap: () {
                                  Get.dialog(
                                      RoomPreLoadingDialog(room: room),
                                      barrierDismissible: false);
                                },
                              );
                            }else if(loadedAll){
                              return null;
                            }else{
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
