import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';

class SettingsInfo extends InheritedWidget {
  final SettingsData data;

  const SettingsInfo({
    Key? key,
    required this.data,
    required Widget child,
  }): super(key: key, child: child);

  @override
  bool updateShouldNotify(SettingsInfo oldWidget) =>
      data != oldWidget.data;

  static SettingsData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SettingsInfo>()!.data;

}

class SettingsInfoWrapper extends StatefulWidget {
  final Widget child;

  const SettingsInfoWrapper({
    Key? key,
    required this.child
  }): super(key: key);

  @override
  SettingsInfoWrapperState createState() => SettingsInfoWrapperState();

}

class SettingsInfoWrapperState extends State<SettingsInfoWrapper> {
  @override
  Widget build(BuildContext context) => BlocBuilder<SettingsBloc, SettingsState>(
    builder: (context, state) {
      if (state is SettingsLoaded) {
        return SettingsInfo(
          data: state.data,
          child: widget.child,
        );
      } else {
        return SettingsInfo(
          data: SettingsData(
            terminalId: PrefsKeys.terminalId.defaultValue!,
            pan: PrefsKeys.pan.defaultValue!,
            typePan: PrefsKeys.typePan.defaultValue!,
            resourcesUrl: PrefsKeys.resourcesUrl.defaultValue!,
            servletName: PrefsKeys.servletName.defaultValue!,
            connectionTimeout: PrefsKeys.connectionTimeout.defaultValue!,
            receiveTimeout: PrefsKeys.receiveTimeout.defaultValue!,
            modalActivityTimeout: PrefsKeys.modalActivityTimeout.defaultValue!,
            waitingTimeout: PrefsKeys.waitingTimeout.defaultValue!,
            monitoringTimeout: PrefsKeys.monitoringTimeout.defaultValue!
          ),
          child: widget.child,
        );
      }
    },
  );

}