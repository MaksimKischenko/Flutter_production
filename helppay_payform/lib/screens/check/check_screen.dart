import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'main_widget/main_widgets.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'multiplatform');

class CheckScreen extends StatefulWidget {
  static const pageName = 'Чек';
  static const pageRoute = '/check';

  final AttrRecordResponse suplierValueName;
  final AttrRecordResponse suplierName;
  final int allServiceCode;

  const CheckScreen({
    Key? key,
    required this.suplierName,
    required this.suplierValueName,
    required this.allServiceCode,
  }) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  bool firstLoad = true;
  @override
  void initState() {
    super.initState();
    context.read<CheckBloc>().add(CheckInit());
    context.read<ConfirmBloc>().add(ConfirmRun());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        builder: (context, sizingInformation) {
          final isDevice = sizingInformation.isMobile ||
              sizingInformation.isTablet ||
              sizingInformation.screenSize.width < 1240;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 78,
              titleSpacing: 0,
              title: PayformTitle(
                sizingInformation: sizingInformation,
                isHomeButtonActive: true,
              ),
            ),
            body: CheckScreenBody(
              isDevice: isDevice,
              suplierName: widget.suplierName,
              suplierValueName: widget.suplierValueName,
            ),
            bottomNavigationBar:
                PayformBottomSheet(sizingInformation: sizingInformation),
          );
        },
      );
}
