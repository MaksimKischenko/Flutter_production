import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const pageRoute = '/';

  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    DesktopWindow.setWindowSize(const Size(720,1280));

    WidgetsBinding.instance.addPostFrameCallback((_) => _navigate());
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.maxFinite),
        LoadingIndicator()
      ],
    ),
  );

  void _navigate() {
    Navigation.toPopularServices();
  }
}