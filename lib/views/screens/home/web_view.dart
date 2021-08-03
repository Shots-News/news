import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_const/flutter_const.dart';
import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news/constant/app_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/utils/url_open.dart';

class MyWebViewPage extends StatefulWidget {
  const MyWebViewPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _MyWebViewPageState createState() => _MyWebViewPageState();
}

class _MyWebViewPageState extends State<MyWebViewPage> {
  final GlobalKey webViewKey = GlobalKey();
  Choice selectedChoice = choices[0];
  var _currentUrl;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
        javaScriptCanOpenWindowsAutomatically: true,
        incognito: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: MyColors.googleBlue),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _select(Choice choice) {
    setState(() {
      selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backwardsCompatibility: false,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.lightBlack,
          actions: [
            PopupMenuButton(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: InkWell(
                      onTap: () async {
                        if (choice.index == 1) {
                          await webViewController?.reload();
                        }
                        if (choice.index == 2) {
                          await webViewController?.getUrl().then((value) => _currentUrl = value);
                          await Clipboard.setData(new ClipboardData(text: _currentUrl.toString())).then((_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Copied to your clipboard ! $_currentUrl')));
                          });
                        }
                        if (choice.index == 3) {
                          await webViewController?.getUrl().then((value) => openUrl(value.toString()));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(choice.title),
                          fcHSizedBox2,
                          Icon(
                            choice.icon,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList();
              },
            ),
            fcHSizedBox1,
          ],
        ),
        body: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              androidOnPermissionRequest: (controller, origin, resources) async {
                return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
            progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon, required this.index});

  final String title;
  final IconData icon;
  final int index;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Reload', icon: MyIcons.reload, index: 1),
  const Choice(title: 'Copy Link', icon: Icons.content_copy_outlined, index: 2),
  const Choice(title: 'Open in browser', icon: Icons.open_in_browser_outlined, index: 3),
];
