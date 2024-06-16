import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay_core/helppay_core.dart';

class WebViewTestScreen extends StatefulWidget {
  const WebViewTestScreen({
    Key? key,
  }) : super(key: key);

  @override
  _WebViewTestScreenState createState() => _WebViewTestScreenState();
}

class _WebViewTestScreenState extends State<WebViewTestScreen> {
  ProductsTab selectedTab = ProductsTab.accounts;

  double get titleSize => 40;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is ProductsErrorKomplat) {
            final isTokenError = state.errorCode == 403;
            if (!isTokenError) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
            }
            if (isTokenError) {
              // Future<void>.delayed(const Duration(seconds: 1),
              //     () => Navigation.navigatorKey.currentState?.pop());
              Multiplatform.onExpiredTokenScreenLock(context);
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              context.t.mobileScreens.products.title,
              style: const TextStyle(
                color: AppStyles.mainColorDark,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF000000))),
                  child: const Text('Create Card'),
                  onPressed: () async {
                    await Navigation.toCardCreationScreenScreen();
                  },
                ),
                ElevatedButton(
                  child: const Text('Open WebView'),
                  onPressed: () async {
                    await Navigation.toWebViewScreen();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
