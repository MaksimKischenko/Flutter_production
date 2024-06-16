import 'package:flutter/material.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/screens/init_helppay_services/widgets/popular_services_list/widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PopularServicesListBody extends StatefulWidget {
  final SizingInformation sizingInformation;
  final double horizontalPaddingValue;

  final PopularServicesLoaded state;

  const PopularServicesListBody({
    Key? key,
    required this.sizingInformation,
    required this.state,
    required this.horizontalPaddingValue,
  }) : super(key: key);

  @override
  State<PopularServicesListBody> createState() =>
      _PopularServicesListBodyState();
}

class _PopularServicesListBodyState extends State<PopularServicesListBody> {
  DeviceSize getDeviceSize(SizingInformation sizingInformation) {
    if (sizingInformation.isMobile ||
        sizingInformation.screenSize.width < 1000) {
      return DeviceSize.small;
    } else if (sizingInformation.isTablet ||
        sizingInformation.screenSize.width < 1400) {
      return DeviceSize.medium;
    } else {
      return DeviceSize.large;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = getDeviceSize(widget.sizingInformation);
    // double horizontalPaddingValue;

    int adaptiveCrossAxisCount;
    double adaptiveCrossAxisSpacing;
    double adaptiveMainAxisSpacing;
    double adaptiveAspectRatio;
    switch (deviceSize) {
      case DeviceSize.small:
        // horizontalPaddingValue = 16;
        adaptiveCrossAxisCount = 1;
        adaptiveCrossAxisSpacing = 2;
        adaptiveMainAxisSpacing = 2;
        adaptiveAspectRatio = 7;

        break;
      case DeviceSize.medium:
        // horizontalPaddingValue = 32;
        adaptiveCrossAxisCount = 5;
        adaptiveCrossAxisSpacing = 2;
        adaptiveMainAxisSpacing = 2;
        adaptiveAspectRatio = 3;

        break;
      case DeviceSize.large:
        // horizontalPaddingValue = 335;
        adaptiveCrossAxisCount = 10;
        adaptiveCrossAxisSpacing = 5;
        adaptiveMainAxisSpacing = 5;
        adaptiveAspectRatio = 1;

        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: isDevice ? 30 : 54),
        // Text(
        //   'Выберите банк, на который вы хотите оформить заявку на перевод денежных средств',
        //   style: GoogleFonts.openSans(
        //     color: const Color(0xff070707),
        //     fontSize: isDevice ? 16 : 20,
        //     letterSpacing: 0.01,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        GridView.builder(
          itemCount: widget.state.payRecords.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 6),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: adaptiveCrossAxisCount,
            crossAxisSpacing: adaptiveCrossAxisSpacing,
            mainAxisSpacing: adaptiveMainAxisSpacing,
            childAspectRatio: adaptiveAspectRatio,
          ),
          itemBuilder: (context, index) => PopularServicesListItem(
            item: widget.state.payRecords[index],
            onNodeTap: Navigation.toServices,
            onServiceTap: Navigation.toServiceWithSuplierName,
          ),
        )
      ],
    );
  }
}
