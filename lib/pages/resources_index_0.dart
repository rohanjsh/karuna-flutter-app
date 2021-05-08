import 'package:flutter/material.dart';
import 'package:karuna_flutter_app/custom.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

//resources - index 0 for BNB
class Resources extends StatelessWidget {
  const Resources({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            SimpleListTile(
              title: 'Need Help?',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1z08HHtOXb3xbiijlobLbRGLKmb4X5Lk4=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Live Oxygen Leads',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1GcwItk-hhdPjt0GeeueFT-5GJByxszzg=w150-h150?authuser=0',
              toPage: OxygenMap(),
            ),
            SimpleListTile(
              title: 'Vacant Beds',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1Rc4AYhu4DSGt6PxaEmVPBbuYvI_Z6r29=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Donate/Request Plasma',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1Eoz-SeMc8hU3ccAiOVGEb4NVBV5HxJR2=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Contribute by Filling Survey',
              imageURL:
                  'https://lh3.googleusercontent.com/d/121mHxEMbWiddmObragKhA-qMvhgyJMsw=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Food',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1v8213hT6ApSqOc0-tdnnb4Kg9Ni50N-T=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Resource List',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1NUUcC4GhntQsJgwl-pXyxteZ64o_BLZ-=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Statewise Covid Helplines',
              imageURL:
                  'https://lh3.googleusercontent.com/d/10zbFZyxKo5R2xap6TrRY6gfhVD5mqRtX=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'City Stress Meter',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1sRfnaKbnlkj097yU20SFL4e-TP5Etj2i=w150-h150?authuser=0',
            ),
            SimpleListTile(
              title: 'Feedback',
              imageURL:
                  'https://lh3.googleusercontent.com/d/1aSqL01ePzn9S3kjhzkyNJQQfRx_gQrqF=w150-h150?authuser=0',
            ),
          ],
        ),
      ),
    );
  }
}

class OxygenMap extends StatefulWidget {
  const OxygenMap({Key key}) : super(key: key);
  @override
  _OxygenMapState createState() => _OxygenMapState();
}

class _OxygenMapState extends State<OxygenMap> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(5, 5),
                  blurRadius: 10)
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NavigationControls(_controller.future),
              ],
            ),
            Flexible(
              child: WebView(
                initialUrl: 'https://www.google.com/maps',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller, goBack: true),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller, goBack: false),
            ),
          ],
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      );
    }
  }
}

_pushTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}
