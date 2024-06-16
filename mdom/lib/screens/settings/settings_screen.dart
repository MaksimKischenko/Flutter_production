import 'package:auto_route/auto_route.dart';
import 'package:bpc/screens/settings/main_widgets/main_widgets.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  static const pageRoute = '/settings';

  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Настройки'),
        ),
        body: const SettinsScreenBodyBuilder(),
      );
}
