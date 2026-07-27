import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

const String kAppUrl = 'https://goriya-entreprise.vercel.app/auth/signin';

void main() {
  runApp(const GoriyaSaasApp());
}

class GoriyaSaasApp extends StatelessWidget {
  const GoriyaSaasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goriya SaaS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const WebViewScreen(),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final WebviewController _controller = WebviewController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await _controller.initialize();
      await _controller.loadUrl(kAppUrl);
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _error != null
            ? Center(child: Text('Erreur de chargement du webview :\n$_error'))
            : _controller.value.isInitialized
                ? Webview(_controller)
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
