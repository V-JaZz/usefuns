import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/screens/dashboard/me/wallet/wallet.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/datasource/local/sharedpreferences/storage_service.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/constants.dart';

class JoyGames extends StatefulWidget {
  final int gameId;
  final int? mini;
  final String? language;
  const JoyGames({super.key, required this.gameId, this.mini, this.language});

  @override
  State<JoyGames> createState() => _JoyGamesState();
}

class _JoyGamesState extends State<JoyGames> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    String url = '${Constants.joyGameBaseURL}?gameId=${widget.gameId}&mini=${widget.mini??1}&lan=${widget.language??'en'}&appKey=${Constants.joyAppKey}&token=${StorageService().getString(Constants.token)}';
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Usefuns',
        onMessageReceived: (JavaScriptMessage message) {
          var data = jsonDecode(message.message);
          //The user clicks the close button in the game lobby
          if (data['name'] == 'newTppClose') {
            Get.back();
          }
          //The user actively clicks the button to increase diamonds coins
          if (data['name'] == 'clickRecharge') {
            Get.to(const Wallet());
          }
          //When the user places a bet, the balance is insufficient callback
          if (data['name'] == 'recharge') {
            showInsufficientDialog(context,1000);
          }
          },
    )
      ..loadRequest(Uri.parse(url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: SizedBox(
        height: widget.mini==0?double.infinity:Get.width,
        child: WebViewWidget(
          controller: _webViewController
        ),
      ),
    );
  }

  // //  If the user's balance changes due to non-in-game business, such as recharging in-game currency
  // void _sendMessageToJavascript() {
  //   _webViewController
  //       .runJavaScript("javascript:HttpTool.NativeToJs('recharge')")
  //       .then((_) {
  //     print('Message sent to JavaScript successfully');
  //   }).catchError((error) {
  //
  //     print('Failed to send message to JavaScript: $error');
  //   });
  // }
}