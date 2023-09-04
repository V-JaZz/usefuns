import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkUtils {

  static Future<bool> isNetworkAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static void checkConnectivity(BuildContext context) {
    bool firstTime = true;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      print('changed');
      if(!firstTime) {
        //bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        bool isNotConnected;
        if(result == ConnectivityResult.none) {
          isNotConnected = true;
        }else {
          isNotConnected = !await (_updateConnectivityStatus());
        }
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 2),
          content: Text(
            isNotConnected ? 'no_connection' : 'connected',
            textAlign: TextAlign.center,
          ),
        ));
      }
      firstTime = false;
    });
  }

  static Future<bool> _updateConnectivityStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result = await InternetAddress.lookup('google.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    }catch(e) {
      log(e.toString());
    }
    return isConnected;
  }
}
