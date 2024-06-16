import 'package:flutter/material.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'widgets/widgets.dart';

class ServicesScreen extends StatefulWidget {
  static const pageName = 'Загрузка';
  static const pageRoute = '/services';

  final int code;

  const ServicesScreen({required this.code});

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        builder: (context, sizingInformation) {
          final isDevice =
              sizingInformation.isMobile || sizingInformation.isTablet;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 78,
              automaticallyImplyLeading: false,
              title: PayformTitle(sizingInformation: sizingInformation),
            ),
            body: ServiceScreenMainBody(
              code: widget.code,
              isDevice: isDevice,
            ),
            bottomNavigationBar: PayformBottomSheet(
              sizingInformation: sizingInformation,
            ),
          );
        },
      );
}
