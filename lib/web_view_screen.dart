import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  final TextEditingController _urlController = TextEditingController();
  bool _showExitButton = false;

  @override
  void initState() {
    super.initState();
    _urlController.text = widget.url;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    _urlController.addListener(_onUrlChanged);
  }

  void _onUrlChanged() {
    setState(() {
      _showExitButton = _urlController.text.toLowerCase() == 'selesai';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _urlController,
          decoration: const InputDecoration(
            hintText: 'ketika sudah, ketik selesai',
            border: InputBorder.none,
            fillColor: Colors.white,
            filled: true,
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty && value.toLowerCase() != 'selesai') {
              _controller.loadRequest(Uri.parse(value));
            }
          },
        ),
        actions: [
          if (_showExitButton)
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _urlController.clear();
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  @override
  void dispose() {
    _urlController.removeListener(_onUrlChanged);
    _urlController.dispose();
    super.dispose();
  }
}