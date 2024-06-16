import 'package:flutter/material.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/screens/init_helppay_services/widgets/popular_services_list/popular_services_list_widget.dart';
import 'package:helppay_payform_app/screens/init_helppay_services/widgets/widgets.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'init_helppay_nodes_body_items_grid');

class InitHelppayNodesBodyItemsGrid extends StatefulWidget {
  final List<Service?> servicesList;
  final List<Service?> nodeRoutesMap;

  final SizingInformation sizingInformation;

  const InitHelppayNodesBodyItemsGrid({
    Key? key,
    required this.sizingInformation,
    required this.nodeRoutesMap,
    required this.servicesList,
  }) : super(key: key);

  @override
  State<InitHelppayNodesBodyItemsGrid> createState() =>
      _InitHelppayNodesBodyItemsGridState();
}

class _InitHelppayNodesBodyItemsGridState
    extends State<InitHelppayNodesBodyItemsGrid> {
  final _controller = ScrollController();

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
    double horizontalPaddingValue;
    double verticalPaddingValue;
    int adaptiveCrossAxisCount;
    double adaptiveCrossAxisSpacing;
    double adaptiveMainAxisSpacing;
    double adaptiveAspectRatio;

    switch (deviceSize) {
      case DeviceSize.small:
        horizontalPaddingValue = 16;
        verticalPaddingValue = 25;
        adaptiveCrossAxisCount = 1;
        adaptiveCrossAxisSpacing = 2;
        adaptiveMainAxisSpacing = 2;
        adaptiveAspectRatio = 7;

        break;
      case DeviceSize.medium:
        horizontalPaddingValue = 32;
        verticalPaddingValue = 40;
        adaptiveCrossAxisCount = 2;
        adaptiveCrossAxisSpacing = 2;
        adaptiveMainAxisSpacing = 2;
        adaptiveAspectRatio = 6;

        break;
      case DeviceSize.large:
        horizontalPaddingValue = 335;
        verticalPaddingValue = 40;
        adaptiveCrossAxisCount = 3;
        adaptiveCrossAxisSpacing = 2;
        adaptiveMainAxisSpacing = 2;
        adaptiveAspectRatio = 5;

        break;
    }

    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        interactive: true,
        controller: _controller,
        child: SingleChildScrollView(
          controller: _controller,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPaddingValue,
              vertical: verticalPaddingValue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PopularServicesListWidget(
                  sizingInformation: widget.sizingInformation,
                  horizontalPaddingValue: horizontalPaddingValue,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    color: AppStyles.mainColorLight,
                  ),
                ),
                Card(
                  elevation: 4,
                  color: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16,
                          child: ListView.separated(
                            itemCount: widget.nodeRoutesMap.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return NodeRouteContainer(
                                prevNode: widget.nodeRoutesMap[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: AppStyles.mainColorLight,
                              );
                            },
                          ),
                        ),
                        GridView.builder(
                          itemCount: widget.servicesList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: adaptiveCrossAxisCount,
                            crossAxisSpacing: adaptiveCrossAxisSpacing,
                            mainAxisSpacing: adaptiveMainAxisSpacing,
                            childAspectRatio: adaptiveAspectRatio,
                          ),
                          itemBuilder: (context, index) => InitHelppayNodeItem(
                            deviceSize: deviceSize,
                            name: widget.servicesList[index]?.name ?? '',
                            onNodeTap: () {
                              int diType = AppConfig.diTypeService;
                              if (widget.servicesList[index]?.nodeType == 2) {
                                Navigation.toInitHelppayServices(
                                  node: widget.servicesList[index],
                                  nodeId: widget.servicesList[index]?.id,
                                  nodeType:
                                      widget.servicesList[index]?.nodeType,
                                );
                              } else {
                                _log('Trying to navigate somewhere');
                                return Navigation.toServiceWithSuplierName(
                                  widget.servicesList[index]!.id,
                                  diType,
                                  widget.servicesList[index]!.name,
                                  widget.servicesList[index]!.supplierName ??
                                      '',
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
