import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/data/model/body/firestore_message_model.dart';
import 'package:live_app/data/model/response/user_data_model.dart';
import 'package:live_app/provider/user_data_provider.dart';
import 'package:provider/provider.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/notification_model.dart';
import '../data/repository/messages_repo.dart';

class MessagesNotificationsProvider with ChangeNotifier {

  void init() async {
    getAllNotifications();
    getAllCommonUsers();
  }

  final storageService = StorageService();
  final MessagesNotificationsRepo _messagesNotificationsRepo = MessagesNotificationsRepo();
  List<UserData>? allEligibleUsersData;

  //Messages
  Future<void> getAllCommonUsers() async {
    List<UserData> list = [];
    final udp = Provider.of<UserDataProvider>(Get.context!,listen: false);
    List<String> followers = udp.userData?.data?.followers??[];
    List<String> followings = udp.userData?.data?.following??[];
    List<String> eligibleUsers = followers.where((follower) => followings.contains(follower)).toList();
    for(String id in eligibleUsers){
      final user = await udp.getUser(id: id);
      if(user.data != null) list.add(user.data!);
    }
    allEligibleUsersData = list;
    notifyListeners();
    return;
  }

  String getConversationId(String myId, String userId) => myId.hashCode >= userId.hashCode
      ?'${myId}_$userId'
      :'${userId}_$myId';

  //Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String withId) {
    final myId = Provider.of<UserDataProvider>(Get.context!,listen: false).userData!.data!.id!;
    return _firestore.collection('chats/${getConversationId(myId,withId)}/messages/')
        .snapshots();
  }

  Future<void> sendMessage(String toId, String messageBody) async {
    final fromId = Provider.of<UserDataProvider>(Get.context!,listen: false).userData!.data!.id!;
    final time = DateTime.timestamp();
    final msSinceEpoch = time.millisecondsSinceEpoch.toString();
    final message = Message(toId: toId, fromId: fromId, type: Type.text, message: messageBody, timeStamp: time);
    final ref = _firestore.collection('chats/${getConversationId(fromId,toId)}/messages/');
    await ref.doc(msSinceEpoch).set(message.toJson());
  }

  //Notifications
  NotificationModel? notifications;

  Future<void> getAllNotifications() async {
    final uid = Provider.of<UserDataProvider>(Get.context!,listen: false).userData!.data!.id!;
    final apiResponse = await _messagesNotificationsRepo.getAll(uid);
    if (apiResponse.statusCode == 200) {
      notifications = notificationModelFromJson(apiResponse.body);
      notifyListeners();
    }
  }

  Future<void> deleteNotification(String id, String uid) async {
    await _messagesNotificationsRepo.deleteNotification(id);
    await getAllNotifications();
    notifyListeners();
  }
}
