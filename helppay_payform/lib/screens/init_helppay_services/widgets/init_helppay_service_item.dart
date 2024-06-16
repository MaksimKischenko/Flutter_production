import 'package:flutter/material.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/injection_component.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/styles.dart';

class InitHelppayServiceItem extends StatefulWidget {
  final DynamicConfig config;
  final Service item;
  final Function(int code, int diType, String name, String suplierName)
      onServiceTap;

  InitHelppayServiceItem({required this.item, required this.onServiceTap})
      : config = InjectionComponent.getDependency<DynamicConfig>(),
        super(key: Key('service ${item.id}'));

  @override
  State<InitHelppayServiceItem> createState() => _InitHelppayServiceItemState();
}

class _InitHelppayServiceItemState extends State<InitHelppayServiceItem> {
  bool onHover = false;
  int diType = 9191;
  late String finalUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.item.pictureURL?.contains('http') ?? false) {
      finalUrl = widget.item.pictureURL?.replaceAll('http:/', 'http://') ?? '';
    } else {
      finalUrl = '${widget.config.pictureUrl}/imgs/${widget.item.pictureURL}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: ((value) => setState(() {
            this.onHover = true;
          })),
      onExit: ((value) => setState(() {
            this.onHover = false;
          })),
      child: InkWell(
        onTap: () => widget.onServiceTap(widget.item.id, diType,
            widget.item.name, widget.item.supplierName ?? ''),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: onHover
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ]
                : [],
            border: Border.all(
              color: AppStyles.mainColor.withOpacity(0.1),
            ),
          ),
          child: (widget.item.pictureURL?.isNotEmpty ?? false)
              ? Image.network(finalUrl, fit: BoxFit.contain,
                  errorBuilder: (_, __, s) {
                  return _serviceTitle();
                })
              : _serviceTitle(),
        ),
      ),
    );
  }

  Widget _serviceTitle({String? errorMessage}) => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          errorMessage == null ? widget.item.name : errorMessage,
          style: const TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 14,
              overflow: TextOverflow.visible),
          // textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      );
}

enum ServiceType { branch, service }
