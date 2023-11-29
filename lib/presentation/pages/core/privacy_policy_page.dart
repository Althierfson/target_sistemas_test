import 'package:flutter/material.dart';
import 'package:target_sistemas_test/custom_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final String _privacyPolicyUrl = "https://www.google.com.br/";
  late WebViewController _controller;
  int _progress = 0;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
        setState(() {
          _progress = progress;
        });
      }))
      ..loadRequest(Uri.parse(_privacyPolicyUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Política de privacidade",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _controller.reload();
              },
              icon: const Icon(
                Icons.replay_outlined,
                color: Colors.white,
              )),
          PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: const Text("Abrir no Navegador"),
                      onTap: () {
                        launchUrl(Uri.parse(_privacyPolicyUrl),
                            mode: LaunchMode.externalApplication);
                      },
                    )
                  ])
        ],
        backgroundColor: CustomColors.lochinvar,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: _progress < 100
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : WebViewWidget(controller: _controller),
    );
  }
}
