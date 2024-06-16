import 'package:flutter/material.dart';
import 'package:helppay_payform_app/screens/service/main_widgets/service_screen_body_content.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ServiceScreenBody extends StatefulWidget {
  final int code;
  final String name;
  final String suplierName;

  const ServiceScreenBody({
    Key? key,
    required this.code,
    required this.name,
    required this.suplierName,
  }) : super(key: key);

  @override
  State<ServiceScreenBody> createState() => _ServiceScreenBodyState();
}

class _ServiceScreenBodyState extends State<ServiceScreenBody> {
  bool isHomeButtonActive = true;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDevice =
            sizingInformation.isMobile || sizingInformation.isTablet;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 78,
            titleSpacing: 0,
            title: PayformTitle(
              sizingInformation: sizingInformation,
              isHomeButtonActive: isHomeButtonActive,
            ),
          ),
          body: isDevice
              ? Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: SafeArea(
                        child: Column(
                          children: [
                            ServiceScreenBodyContent(
                              code: widget.code,
                              name: widget.name,
                              isDevice: isDevice,
                              isHomeButtonActive: isHomeButtonActive,
                              suplierName: widget.suplierName,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: ServiceScreenBodyContent(
                          code: widget.code,
                          name: widget.name,
                          isDevice: isDevice,
                          isHomeButtonActive: isHomeButtonActive,
                          suplierName: widget.suplierName,
                        ),
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar:
              PayformBottomSheet(sizingInformation: sizingInformation),
        );
      },
    );
  }
}
