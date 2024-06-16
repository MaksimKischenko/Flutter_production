import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/models/models.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/utils/utils.dart';
import 'package:kpm_fl/widgets/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  static const pageRoute = '/settings';

  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<bool> _isOpen = List.generate(1, (index) => index == 0);

  late String _terminalId;
  late String _pan;
  late String _typePan;
  late String _resourcesUrl;
  late String _servletName;
  late int _connectionTimeout;
  late int _receiveTimeout;
  late int _modalActivityTimeout;
  late int _waitingTimeout;
  late int _monitoringTimeout;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16, width: double.maxFinite),
          const PageTitle('Настройки'),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              return Text(
                'Версия ${snapshot.data!.version} build ${snapshot.data!.buildNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppStyles.mainTextColor.withOpacity(0.8),
                ),
              );
            }
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is SettingsSaved) {
                  Navigation.toSplash();
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно!',
                    message: 'Настройки сохранены',
                    type: DialogType.success
                  );
                }
              },
              builder: (context, state) {
                Widget body = const SizedBox();
                if (state is SettingsLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text('Загрузка'),
                      // SizedBox(height: 16),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is SettingsLoaded) {
                  body = SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: ExpansionPanelList(
                        elevation: 0,
                        expansionCallback: (panelIndex, isExpanded) => setState(() {
                          _isOpen[panelIndex] = !isExpanded;
                        }),
                        children: [
                          _category(
                            title: 'Общие',
                            index: 0,
                            children: [
                              SettingsField(
                                title: 'terminalId',
                                initialValue: state.data.terminalId,
                                onSaved: (value) => _terminalId = value,
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'pan',
                                initialValue: state.data.pan,
                                onSaved: (value) => _pan = value,
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'typePan',
                                initialValue: state.data.typePan,
                                onSaved: (value) => _typePan = value,
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'resourcesUrl',
                                initialValue: state.data.resourcesUrl,
                                onSaved: (value) => _resourcesUrl = value,
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'servletName',
                                initialValue: state.data.servletName,
                                onSaved: (value) => _servletName = value,
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'connectionTimeout (сек)',
                                initialValue: state.data.connectionTimeout.toString(),
                                type: ParamType.integ,
                                onSaved: (value) => _connectionTimeout = value.toInt(),
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'receiveTimeout (сек)',
                                initialValue: state.data.receiveTimeout.toString(),
                                type: ParamType.integ,
                                onSaved: (value) => _receiveTimeout = value.toInt(),
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'modalActivityTimeout (сек)',
                                initialValue: state.data.modalActivityTimeout.toString(),
                                type: ParamType.integ,
                                onSaved: (value) => _modalActivityTimeout = value.toInt(),
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'waitingTimeout (сек)',
                                initialValue: state.data.waitingTimeout.toString(),
                                type: ParamType.integ,
                                onSaved: (value) => _waitingTimeout = value.toInt(),
                              ),
                              const SizedBox(height: 16),
                              SettingsField(
                                title: 'monitoringTimeout (сек)',
                                initialValue: state.data.monitoringTimeout.toString(),
                                type: ParamType.integ,
                                onSaved: (value) => _monitoringTimeout = value.toInt(),
                              ),
                            ]
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return body;
              },
            ),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: GradientButton(
                    onTap: _onHomeTap,
                    child: const Text('Главное меню'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GradientButton(
                    onTap: _onSaveTap,
                    gradientColors: const [CupertinoColors.activeGreen, CupertinoColors.activeGreen],
                    child: const Text('Сохранить'),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  ExpansionPanel _category({
    required String title,
    required int index,
    required List<Widget> children
  }) => ExpansionPanel(
    canTapOnHeader: true,
    headerBuilder: (context, isExpanded) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18
            ),
          ),
        ],
      ),
    ),
    isExpanded: _isOpen[index],
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    )
  );

  void _onHomeTap() {
    Navigation.toSplash();
    // Navigation.toPopularServices();
  }

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<SettingsBloc>().add(SettingsSave(SettingsData(
        terminalId: _terminalId,
        pan: _pan,
        typePan: _typePan,
        resourcesUrl: _resourcesUrl,
        servletName: _servletName,
        connectionTimeout: _connectionTimeout,
        receiveTimeout: _receiveTimeout,
        modalActivityTimeout: _modalActivityTimeout,
        waitingTimeout: _waitingTimeout,
        monitoringTimeout: _monitoringTimeout
      )));
    }
  }
}