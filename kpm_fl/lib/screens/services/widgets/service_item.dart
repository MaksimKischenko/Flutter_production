import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/widgets/widgets.dart';

class ServiceItem extends StatelessWidget {
  final PayRecordResponse item;
  final Function(int code) onNodeTap;
  final Function(int code) onServiceTap;

  const ServiceItem({
    required this.item,
    required this.onNodeTap,
    required this.onServiceTap
  });

  @override
  Widget build(BuildContext context) {
    final name = HtmlUnescape().convert(item.name ?? 'Код ${item.code}');
    return InkWrapper(
      onTap: () {
        if (item.getPayListType == 2) {
          onNodeTap(item.code!);
        } else if (item.getPayListType == 1) {
          onServiceTap(item.code!);
        }
      },
      borderRadius: 8,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppStyles.mainColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(8)
        ),
        child: item.picture?.url == null
            ? _serviceTitle(name)
            // TODO: add /imgs to resourcesUrl or remove it from GetUserProfile response
            : Image.network('${SettingsInfo.of(context).resourcesUrl}/imgs/${item.picture!.url!}',
              // fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _serviceTitle(name),
            ),
      ),
    );
  }

  Widget _serviceTitle(String name) {
    late Color textColor;
    late Color backgroundColor;

    if (item.getPayListType == 2) {
      // node
      textColor = Colors.white;
      backgroundColor = AppStyles.mainColor;
    } else {
    // } else if (item.getPayListType == 1) {
      // service
      textColor = AppStyles.mainTextColor;
      backgroundColor = Colors.transparent;
    }

    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              color: textColor,
              fontSize: 16
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

}