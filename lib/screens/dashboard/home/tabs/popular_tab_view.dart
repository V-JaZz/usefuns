import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/utils_assets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../provider/rooms_provider.dart';
import '../../../../utils/common_widgets.dart';
import '../../../room/widget/pre_loading_dailog.dart';
import '../../../web/web_view.dart';

class PopularTabView extends StatefulWidget {
  const PopularTabView({super.key});

  @override
  State<PopularTabView> createState() => _PopularTabViewState();
}

class _PopularTabViewState extends State<PopularTabView> {
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  Future<void> loadData({bool refresh = false}) async {
    await Provider.of<RoomsProvider>(context,listen: false).getAllPopular(refresh);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;
    return SmartRefresher(
      enablePullDown: true,
      onRefresh: () async {
        await loadData(refresh: true);
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
                                          String link = value.bannerList[index].link!;
                                          Get.to(()=>WebPageViewer(url: link));
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
                          itemCount: value.popularRooms.length,
                          itemBuilder: (context, index) {
                            final room = value.popularRooms[index];
                            return roomListTile(
                              image: room.images!.isEmpty
                                  ? null
                                  : room.images!.first,
                              title: room.name.toString(),
                              subTitle: room.announcement,
                              iso: room.countryCode,
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
