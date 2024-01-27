import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/gifts_model.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:live_app/provider/zego_room_provider.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/room_gift_history_model.dart';
import '../data/repository/gifts_repo.dart';
import 'package:collection/collection.dart';
import '../utils/helper.dart';

class GiftsProvider with ChangeNotifier {
  final storageService = StorageService();
  final GiftsRepo _giftsRepo = GiftsRepo();
  Map<String, List<Gift>> allGifts = {};
  Map<String, List<GiftHistory>> todayRoomContribution = {};
  Map<String, List<GiftHistory>> sevenDaysRoomContribution = {};
  bool giftLoading = true;
  List<double>? series;

  Future<void> getAll() async {
    final apiResponse = await _giftsRepo.getAll();
    if (apiResponse.statusCode == 200) {
      GiftsModel gm = giftsModelFromJson(apiResponse.body);
      if (gm.status == 1) {
        allGifts = groupBy(
          gm.data ?? [],
          (Gift g) => g.categoryName ?? '',
        );
      }
    }
    giftLoading = false;
    notifyListeners();
  }

  void sendGift(String senderId, List<String> receiverIds, String giftId, int count,
      String roomId, int giftPrice) async {
    for (String receiverId in receiverIds) {
        await _giftsRepo.sendGift(senderId, receiverId, giftId,count, roomId);
        await _giftsRepo.updateTBoxLevel(roomId, giftPrice*count);
        Provider.of<ZegoRoomProvider>(Get.context!, listen: false).updateTreasureBox();
        Provider.of<UserDataProvider>(Get.context!, listen: false).getUser(loading: false);
    }
  }

  Future<void> getAllContribution(String roomId) async {
    final apiResponse = await _giftsRepo.getAllContribution(roomId);
    if (apiResponse.statusCode == 200) {
      RoomGiftHistoryModel model = roomGiftHistoryModelFromJson(apiResponse.body);
      if (model.status == 1) {
        List<GiftHistory> todayContribution = [];
        List<GiftHistory> sevenDaysContribution = [];
        for(GiftHistory gh in model.data!){
          if (isToday(gh.createdAt!)) {
            todayContribution.add(gh);
          }
          if (inLastSevenDays(gh.createdAt!)) {
            sevenDaysContribution.add(gh);
          }
        }
        final mapToday = groupBy(
          todayContribution,
          (GiftHistory gh) => gh.sender!,
        );
        todayRoomContribution = repositionMap(mapToday);
        final mapSevenDays = groupBy(
          sevenDaysContribution,
              (GiftHistory gh) => gh.sender!,
        );
        sevenDaysRoomContribution = repositionMap(mapSevenDays);
      }
    }
    notifyListeners();
  }

  void generateSeries() {
    if(series == null){
      List<double> s = [100];
      for (int i = 1; i < 99; i++) {
        double lastValue = s.last;
        double newValue = lastValue + (lastValue * 0.8725173730668903);
        s.add(newValue);
      }
      series = s;
    }
  }

  Map<String, List<GiftHistory>> repositionMap(Map<String, List<GiftHistory>> inputMap) {
    // Calculate the sums of coins for each list and store them in a map
    Map<String, int> sums = {};
    inputMap.forEach((key, value) {
      int sum = value.map((gh) => (gh.gift!.coin! * gh.count!)).reduce((a, b) => a + b);
      sums[key] = sum;
    });

    // Sort the map by sum values in ascending order
    var sortedKeys = sums.keys.toList(growable: false)
      ..sort((k1, k2) => sums[k2]!.compareTo(sums[k1]!));

    // Create a new map with lists in the repositioned order based on sums
    Map<String, List<GiftHistory>> repositionedMap = {};
    for (var key in sortedKeys) {
      repositionedMap[key] = inputMap[key]!;
    }

    return repositionedMap;
  }

  void clearContribution(){
    todayRoomContribution.clear();
    sevenDaysRoomContribution.clear();
  }
}
