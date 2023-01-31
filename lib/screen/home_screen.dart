import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget{
  WebViewController? webViewController;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WebView(
      onWebViewCreated: (WebViewController webViewController) {
        this.webViewController = webViewController;
      },
      initialUrl: 'https://www.nhncloud.com/kr',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

}