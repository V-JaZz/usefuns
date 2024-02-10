import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../provider/rooms_provider.dart';
import '../../../../utils/common_widgets.dart';
import '../../../../utils/helper.dart';
import '../../../room/widget/pre_loading_dailog.dart';

class NewTabView extends StatefulWidget {
  const NewTabView({super.key});

  @override
  State<NewTabView> createState() => _NewTabViewState();
}

class _NewTabViewState extends State<NewTabView> {
  RefreshController refreshController = RefreshController();
  bool loadedAll = false;

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
    final success = await Provider.of<RoomsProvider>(context,listen: false).getAllNew(refresh);
    if(success == false){
      setState(() => loadedAll = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;

    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 18 * a),
      child: Consumer<RoomsProvider>(
        builder: (context, value, child) {
          if(value.roomLoading){
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Consumer<RoomsProvider>(
                  builder: (context, value, _) => ListTile(
                      onTap: () async {
                        String? iso = await selectCountryDialog();
                        if(iso!=null && value.selectedCountryCode != iso){
                          value.selectedCountryCode = iso;
                          loadData(refresh: true);
                        }
                      },
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if(value.selectedCountryCode != 'all')
                            CountryFlag.fromCountryCode(
                              value.selectedCountryCode,
                              height: 14*a,
                              width: 21*a,
                              borderRadius: 4,
                            ),
                          SizedBox(width: 10*a),
                          Text(getCountryNameFromCode(value.selectedCountryCode)),
                          SizedBox(width: 10*a),
                          const Icon(Icons.arrow_forward_ios_rounded,color: Colors.black54,size: 18)
                        ],
                      )
                  ),
                ),
                Expanded(
                  child:
                  value.newRooms.isEmpty
                      ? const Center(child: Text('No Room Found!'))
                      : SmartRefresher(
                          enablePullDown: true,
                          onRefresh: () async {
                            await loadData(refresh: true);
                            loadedAll = false;
                            refreshController.refreshCompleted();
                            return;
                          },
                          physics: const BouncingScrollPhysics(),
                          controller: refreshController,
                          child: ListView.builder(
                            itemCount: value.newRooms.length,
                            itemBuilder: (context, index) {
                              final room = value.newRooms[index];
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
                          ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
