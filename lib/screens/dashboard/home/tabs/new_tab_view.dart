import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../data/model/response/rooms_model.dart';
import '../../../../provider/rooms_provider.dart';
import '../../../../utils/common_widgets.dart';
import '../../../room/widget/pre_loading_dailog.dart';

class NewTabView extends StatefulWidget {
  const NewTabView({super.key});

  @override
  State<NewTabView> createState() => _NewTabViewState();
}

class _NewTabViewState extends State<NewTabView> {
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
    final success = await Provider.of<RoomsProvider>(context,listen: false).getAllNew(page,refresh);
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
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 18 * a),
      child: Consumer<RoomsProvider>(
        builder: (context, value, child) {
          if(value.newRooms.isEmpty){
            return const Center(child: CircularProgressIndicator());
          }
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
            child: ListView.builder(
              controller: scrollController,
              itemCount: value.newRooms.length+1,
              itemBuilder: (context, index) {
                if (index < value.newRooms.length){
                  final room = value.newRooms[index];
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
                }else {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
