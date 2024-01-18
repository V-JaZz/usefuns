import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionProvider extends ChangeNotifier {
  InternetConnectionStatus _connectionStatus = InternetConnectionStatus.connected;
  StreamSubscription? _connectionSubscription;

  ConnectionProvider() {
    _connectionSubscription = InternetConnectionCheckerPlus().onStatusChange.listen(
          (status) {
        _connectionStatus = status;
        notifyListeners();
        _showDialogIfNeeded();
      },
    );
  }

  void _checkConnection() async {
    final status = await InternetConnectionCheckerPlus().connectionStatus;
    _connectionStatus = status;
    _showDialogIfNeeded();
  }

  void _showDialogIfNeeded() {
    if (_connectionStatus == InternetConnectionStatus.disconnected) {
      Get.dialog(
        const AlertDialog(
          title: Text('No internet connection'),
          content: Text('Retrying...',textAlign: TextAlign.center),
          icon: Icon(Icons.network_check_rounded, color: Colors.black87),
        ),
        barrierDismissible: false,
        barrierColor: Colors.transparent
      );
    } else {
      Get.back(); // Dismiss dialog if connected
    }
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    super.dispose();
  }

  InternetConnectionStatus get connectionStatus => _connectionStatus;
}
