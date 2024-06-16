import 'package:flutter/material.dart';
import 'package:helppay/route_helper.dart';
import 'package:helppay/widgets/loading_indicator.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:webview_flutter/webview_flutter.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'web_view_test_screen');

class WebViewScreen extends StatefulWidget {
  static const pageRoute = '/pageViewTest';

  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const LoadingIndicator();
          },
          onUrlChange: (UrlChange url) {
       
          
            final parsed = RouteHelper.parsePath(url.url ?? '', isHashStrategy: false, urlAppender: '/');
            _log(
              'web view url: ${parsed}',
            );

            // final params = parsed.value;
            // final client_id = params['client_id'];
            // final responseType = params['response_type'];
            // final authentication = params['authentication']; 
            // final redirectUri = params['redirect_uri'];
            // final state = params['state'];
            // final scope = params['scope']; 
            
            // _log(
            //   'clientID: ${client_id}; RedirectUrl: $redirectUri',
            // );
            
    
            // if (url.url?.contains('/profile') ?? false) {
            //   Navigator.of(context).pop();
            // }
            // TODO: check failed status return
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://ioauth.raschet.by/oauth/authorize?client_id=5clqBxSM7kmYUmzNvRYmlhnIVjtFp5zA&response_type=code&authentication=online_otp&redirect_uri=https%3A%2F%2Fioauth.raschet.by%2Fclient%2Foauth2%2Fcallback&state=21f5a4eac36f0bf8d7f122a6d23bf6a3&scope=openid+profile+profile_manage+msi_subject+msi_national_id_number+msi_id_document+msi_contact+msi_user_registration_info+msi_session_info+msi_natural_person_tax_info'))
      ..addJavaScriptChannel('WebViewClose',
          onMessageReceived: (JavaScriptMessage message) {
        if (message.message == 'closeWebView') {
          Navigator.of(context).pop();
        }
      });
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(title: const Text('Flutter Simple Example')),
        body: WebViewWidget(
          // initialUrl: 'https://github.com/',
          controller: controller,
        ),
      );
}
