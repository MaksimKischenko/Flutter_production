import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'main_widgets/main_widgets.dart';

// ignore: must_be_immutable
class PopularServicesScreen extends StatefulWidget {
  static const pageName = 'Главная';
  static const pageRoute = '/home';

  @override
  State<PopularServicesScreen> createState() => _PopularServicesScreenState();
}

class _PopularServicesScreenState extends State<PopularServicesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<PopularServicesBloc>().add(PopularServicesInit()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      ResponsiveBuilder(builder: (context, sizingInformation) {
        final isDevice = sizingInformation.isMobile ||
            sizingInformation.isTablet ||
            sizingInformation.screenSize.width < 1240;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            toolbarHeight: 78,
            automaticallyImplyLeading: false,
            title: PayformTitle(sizingInformation: sizingInformation),
          ),
          body: PopularServicesScreenMainBody(
            isDevice: isDevice,
          ),
          bottomNavigationBar:
              PayformBottomSheet(sizingInformation: sizingInformation),
        );
      });
}
