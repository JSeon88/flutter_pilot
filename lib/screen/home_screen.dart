import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget{
  WebViewController? webViewController;

  HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebView(
      onWebViewCreated: (WebViewController webViewController) {
        webViewController = webViewController;
      },
      initialUrl: 'https://www.nhncloud.com/kr',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  @override
  bool get wantKeepAlive => true;
}