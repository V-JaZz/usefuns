import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/response/gifts_model.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/common_model.dart';
import '../data/repository/gifts_repo.dart';
import 'package:collection/collection.dart';

class GiftsProvider with ChangeNotifier {

  final storageService = StorageService();
  final GiftsRepo _giftsRepo = GiftsRepo();
  Map<String, List<Gift>>? allGifts;
  bool loading = true;

  Future<void> getAll() async {
    final apiResponse = await _giftsRepo.getAll();
    if (apiResponse.statusCode == 200) {
      GiftsModel gm = giftsModelFromJson(apiResponse.body);
      if(gm.status == 1){
          allGifts = groupBy(
            gm.data??[],
                (Gift g) => g.categoryName??'',
          );
      }
    }
    loading = false;
    notifyListeners();
  }

  sendGift(String senderId, List<String> receiverIds, String giftId) async {
    for(String receiverId in receiverIds){
      final apiResponse = await _giftsRepo.sendGift(senderId, receiverId, giftId);
      if (apiResponse.statusCode == 200) {
        Provider.of<UserDataProvider>(Get.context!,listen: false).getUser(refresh: false);
        // model = commonModelFromJson(apiResponse.body);
      }else{
        // model =CommonModel(status: 0,message: apiResponse.reasonPhrase);
      }
    }
  }
}
