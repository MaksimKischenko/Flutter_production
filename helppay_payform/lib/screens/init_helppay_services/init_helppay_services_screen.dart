// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

import 'main_widgets/main_widgets.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'init_helppay_services_screen');

class InitHelppayServicesScreen extends StatefulWidget {
  final NodeScreenParams nodeScreenParams;

  const InitHelppayServicesScreen({
    Key? key,
    required this.nodeScreenParams,
  }) : super(key: key);

  static const pageName = 'Главная';
  static const pageRoute = '/init_helppay_home';

  @override
  State<InitHelppayServicesScreen> createState() =>
      _InitHelppayServicesScreenState();
}

class _InitHelppayServicesScreenState extends State<InitHelppayServicesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<InitHelppayServicesBloc>().add(
            InitHelppayServicesInit(
              node: widget.nodeScreenParams.node,
              nodeId: widget.nodeScreenParams.nodeId,
              nodeType: widget.nodeScreenParams.nodeType,
            ),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: ResponsiveBuilder(builder: (context, sizingInformation) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              toolbarHeight: 78,
              automaticallyImplyLeading: false,
              title: PayformTitle(sizingInformation: sizingInformation),
            ),
            body: InitHelppayServicesScreenMainBody(
              sizingInformation: sizingInformation,
            ),
            bottomNavigationBar:
                PayformBottomSheet(sizingInformation: sizingInformation),
          );
        }),
      );
}
