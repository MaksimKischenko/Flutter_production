import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kpm_fl/blocs/blocs.dart';

class ScreenInfo extends InheritedWidget {
  final ScreenInfoData data;

  const ScreenInfo({
    Key? key,
    required this.data,
    required Widget child,
  }): super(key: key, child: child);

  @override
  bool updateShouldNotify(ScreenInfo oldWidget) =>
      data != oldWidget.data;

  static ScreenInfoData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScreenInfo>()!.data;

}

class ScreenInfoWrapper extends StatefulWidget {
  final Widget child;

  const ScreenInfoWrapper({
    Key? key,
    required this.child
  }): super(key: key);

  @override
  ScreenInfoWrapperState createState() => ScreenInfoWrapperState();

}

class ScreenInfoWrapperState extends State<ScreenInfoWrapper> {
  @override
  Widget build(BuildContext context) => BlocBuilder<ScreenInfoBloc, ScreenInfoData>(
    builder: (context, data) => ScreenInfo(
      data: data,
      child: widget.child,
    ),
  );

}