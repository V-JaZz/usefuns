import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:live_app/utils/common_widgets.dart';

class ConnectionProvider extends ChangeNotifier {
  InternetConnectionStatus _connectionStatus = InternetConnectionStatus.connected;
  StreamSubscription? _connectionSubscription;
  int failCount = 0;

  ConnectionProvider() {
    _connectionSubscription = InternetConnectionCheckerPlus().onStatusChange.listen(
          (status) {
        _connectionStatus = status;
        notifyListeners();
        _checkConnection();
      },
    );
  }

  void _checkConnection() async {
    final status = await InternetConnectionCheckerPlus().connectionStatus;
    _connectionStatus = status;
    notifyListeners();
    _showDialogIfNeeded();
  }

  void _showDialogIfNeeded() {
    if (_connectionStatus == InternetConnectionStatus.disconnected) {
      if(failCount>1) noInternetMessage();
      _checkConnection();
      failCount++;
    } else {
      ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
      failCount = 0;
    }
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    super.dispose();
  }

  InternetConnectionStatus get connectionStatus => _connectionStatus;

  void noInternetMessage() {
    showCustomBanner('Network Error!',onAction: () {
      ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
      failCount = 0;
      _checkConnection();
    });
  }
}
