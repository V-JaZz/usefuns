import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/datasource/local/sharedpreferences/storage_service.dart';
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
  late final String url;

  @override
  void initState() {
    url = '${Constants.joyGameBaseURL}?gameId=${widget.gameId}&mini=${widget.mini??1}&lan=${widget.language??'en'}&appKey=${Constants.joyAppKey}&token=${StorageService().getString(Constants.token)}';
    print(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _webViewController = webViewController;
      },
      javascriptChannels: <JavascriptChannel>{
        JavascriptChannel(
          name: 'Flutter',
          onMessageReceived: (JavascriptMessage message) {
            var data = jsonDecode(message.message);
            //The user clicks the close button in the game lobby
            if (data['name'] == 'newTppClose') {
              print('newTppClose');
            }
            //The user actively clicks the button to increase gold coins
            if (data['name'] == 'clickRecharge') {
              print('clickRecharge');
            }
            //When the user places a bet, the balance is insufficient callback
            if (data['name'] == 'recharge') {
              print('recharge');
            }
          },
        ),
      },
    );
  }

  //  If the user's balance changes due to non-in-game business, such as recharging in-game currency
  void _sendMessageToJavascript() {
    _webViewController
        .runJavascript("javascript:HttpTool.NativeToJs('recharge')")
        .then((_) {

      print('Message sent to JavaScript successfully');
    }).catchError((error) {

      print('Failed to send message to JavaScript: $error');
    });
  }
}