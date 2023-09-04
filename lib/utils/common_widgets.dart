import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;

void showCustomSnackBar(String? message, BuildContext context, {bool isError = true, bool isToaster = false}) {
  if(isToaster){
    Fluttertoast.showToast(
        msg: message??'error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(message??'error'),
    ));
  }

}
Widget loadingWidget() {
  return WillPopScope(
    onWillPop: () async => false,
    child: Stack(
      children: [
        // Background with blur effect
        Positioned.fill(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black.withOpacity(0.1), // Adjust opacity as needed
            ),
          ),
        ),
        // Centered circular progress indicator
        const Positioned.fill(
          child: Center(
            child: CircularProgressIndicator(
              color: Color(0xff9e26bc),
            ),
          ),
        ),
      ],
    ),
  );
}
