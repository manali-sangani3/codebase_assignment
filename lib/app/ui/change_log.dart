import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChangeLogs extends StatefulWidget {
  const ChangeLogs({super.key});

  @override
  State<ChangeLogs> createState() => _ChangeLogsState();
}

class _ChangeLogsState extends State<ChangeLogs> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadFlutterAsset('assets/change_log/changelog.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.changeLog),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
