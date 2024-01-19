import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionProvider extends ChangeNotifier {
  InternetConnectionStatus _connectionStatus = InternetConnectionStatus.connected;
  StreamSubscription? _connectionSubscription;
  Timer? timer;

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
    timer?.cancel();
    _showDialogIfNeeded();
  }

  void _showDialogIfNeeded() {
    if (_connectionStatus == InternetConnectionStatus.disconnected) {
      noInternetMessage();
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        _checkConnection();
      });
    } else {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _connectionSubscription?.cancel();
    super.dispose();
  }

  InternetConnectionStatus get connectionStatus => _connectionStatus;

  void noInternetMessage() {
    Get.snackbar(
      'Internet Issue!',
      'Retrying...',
      icon: const Icon(Icons.network_check_rounded, color: Colors.black87),
      mainButton: TextButton(
          onPressed: () => _checkConnection(),
          child: const Text('Retry')
      ),
      isDismissible: false,
      backgroundColor: Colors.white70,
      duration: const Duration(seconds: 5)
    );
  }
}
