import 'package:flutter/material.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/injection_component.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/styles.dart';

class ServiceItem extends StatefulWidget {
  final DynamicConfig config;
  final PayRecordResponse item;
  final Function(int code, int diType) onNodeTap;
  final Function(int code, int diType, String name) onServiceTap;

  ServiceItem(
      {required this.item, required this.onNodeTap, required this.onServiceTap})
      : config = InjectionComponent.getDependency<DynamicConfig>();

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  bool onHover = false;
  late final String finalUrl;


  @override
    void initState() {
      super.initState();
      if(widget.item.picture?.url?.contains('http') ?? false) {
        finalUrl = widget.item.picture?.url?.replaceAll('http:/', 'http://') ?? ''; 
      } else {
        finalUrl = '${widget.config.pictureUrl}/imgs/${widget.item.picture?.url}';
      }
    }
    

  @override
  Widget build(BuildContext context) {
    // final name = HtmlUnescape().convert(item.name ?? 'Код ${item.code}');
    return MouseRegion(
      onEnter: ((value) => setState(() {
            this.onHover = true;
          })),
      onExit: ((value) => setState(() {
            this.onHover = false;
          })),
      child: InkWell(
        // behavior: HitTestBehavior.translucent,
        onTap: () {
          if (widget.item.getPayListType == 2) {
            widget.onNodeTap(widget.item.code!, widget.item.diType!);
          } else if (widget.item.getPayListType == 1) {
            widget.onServiceTap(widget.item.code!, widget.item.diType!, widget.item.name!);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppStyles.mainColor.withOpacity(0.1),
            ),
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
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: widget.item.picture?.url?.isNotEmpty ?? false
              ? Image.network(
                  finalUrl,
                  // fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => _serviceTitle(),
                )
              : _serviceTitle(),
        ),
      ),
    );
  }

  Widget _serviceTitle() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            widget.item.name ?? 'Неизвестно',
            style: const TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 16,
            ),
            // textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      );
}

enum ServiceType { branch, service }
