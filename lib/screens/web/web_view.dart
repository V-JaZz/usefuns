import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_app/utils/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../utils/utils_assets.dart';

class WebPageViewer extends StatefulWidget {
  final String url;
  const WebPageViewer({super.key, required this.url});

  @override
  WebPageViewerState createState() => WebPageViewerState();
}

class WebPageViewerState extends State<WebPageViewer> {
  late final WebViewController _webViewController;
  double _progress = 0;
  @override
  void initState() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
                setState(() {
                  _progress = progress / 100;
                });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
                setState(() {
                  _progress = 0;
                });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
            },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double a = Get.width / baseWidth;
    double b = a * 0.97;

    bool isChatView =  widget.url == Constants.ufTeamSupportChat;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isChatView? Colors.white: const Color(0x339E26BC),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: isChatView? const Color(0xff03a84e): Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        title: Text(
          isChatView?'Usefuns Support':'Usefuns',
          style: safeGoogleFont(
            'Poppins',
            fontSize: 20 * b,
            fontWeight: FontWeight.w400,
            height: 1.5 * b / a,
            letterSpacing: 0.8 * a,
            color: isChatView? const Color(0xff03a84e): Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
              value: _progress,
            color: isChatView? const Color(0xff03a84e): null,
          ),
          Expanded(
            child: WebViewWidget(
              controller: _webViewController
            ),
          ),
        ],
      ),
    );
  }
}
