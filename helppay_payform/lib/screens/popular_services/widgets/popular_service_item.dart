import 'dart:html';

import 'package:flutter/material.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/injection_component.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'dart:ui' as ui;

void _log(dynamic message) => Logger.helpPayLog(message, name: 'conmfirm_bloc');

class PopularServiceItem extends StatefulWidget {
  final DynamicConfig config;
  final ListPopularResponsePayRecord item;
  final Function(int code, int diType) onNodeTap;
  final Function(int code, int diType, String name) onServiceTap;

  PopularServiceItem(
      {required this.item, required this.onNodeTap, required this.onServiceTap})
      : config = InjectionComponent.getDependency<DynamicConfig>(),
        super(key: Key('popular service ${item.code}'));

  @override
  State<PopularServiceItem> createState() => _PopularServiceItemState();
}

class _PopularServiceItemState extends State<PopularServiceItem> {
  bool onHover = false;
  late final String finalUrl;

  @override
  void initState() {
    super.initState();
    if (widget.item.picture?.url?.contains('http') ?? false) {
      finalUrl =
          widget.item.picture?.url?.replaceAll('http:/', 'http://') ?? '';
    } else {
      finalUrl = '${widget.config.pictureUrl}/imgs/${widget.item.picture?.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // final name =
    //     HtmlUnescape().convert(widget.item.name ?? 'Код ${widget.item.code}');
    return MouseRegion(
      onEnter: ((value) => setState(() {
            this.onHover = true;
          })),
      onExit: ((value) => setState(() {
            this.onHover = false;
          })),
      child: InkWell(
        key: ValueKey('popular_cervice_item'),
        // behavior: HitTestBehavior.translucent,
        onTap: () => widget.item.recordType == 1
            ? widget.onNodeTap(widget.item.code!, widget.item.diType!)
            : widget.onServiceTap(
                widget.item.code!, widget.item.diType!, widget.item.name!),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          // alignment: Alignment.centerLeft,
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
          child: widget.item.picture?.url?.isNotEmpty ?? false
              ? htmlImage(finalUrl)

              // Image.network(
              //     finalUrl,
              //     fit: BoxFit.contain,
              //     errorBuilder: (_, __, ___) => _serviceTitle(),
              //   )
              : _serviceTitle(),
        ),
      ),
    );
  }

  Widget _serviceTitle() => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(
          widget.item.name ?? 'Неизвестно',
          style: const TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 16,
              overflow: TextOverflow.visible),
          // textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      );

  htmlImage(String finalUrl) {
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      finalUrl,
      (int _) => ImageElement()..src = finalUrl,
    );
    return HtmlElementView(
      viewType: finalUrl,
    );
  }
}

enum ServiceType { branch, service }
