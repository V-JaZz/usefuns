import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_app/data/model/response/club_model.dart';
import '../data/datasource/local/sharedpreferences/storage_service.dart';
import '../data/model/response/notification_model.dart';
import '../data/repository/messages_repo.dart';

class MessagesProvider with ChangeNotifier {

  final storageService = StorageService();
  final MessagesRepo _messagesRepo = MessagesRepo();
  NotificationModel? notifications;
  bool isCreating = false;

  Future<void> getAllNotifications(String uid) async {
    final apiResponse = await _messagesRepo.getAll(uid);
    if (apiResponse.statusCode == 200) {
      notifications = notificationModelFromJson(apiResponse.body);
      notifyListeners();
    }
  }

  Future<void> deleteNotification(String id, String uid) async {
    await _messagesRepo.deleteNotification(id);
    await getAllNotifications(uid);
    notifyListeners();
  }
}
