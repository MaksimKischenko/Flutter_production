import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/models/device_size.dart';
import 'package:helppay_payform_app/styles.dart';

class InitHelppayNodeItem extends StatefulWidget {
  final String name;
  final DeviceSize deviceSize;
  final Function() onNodeTap;

  const InitHelppayNodeItem({
    Key? key,
    required this.onNodeTap,
    required this.name,
    required this.deviceSize,
  }) : super(key: key);

  @override
  State<InitHelppayNodeItem> createState() => _InitHelppayNodeItemState();
}

class _InitHelppayNodeItemState extends State<InitHelppayNodeItem> {
  bool onHover = false;
  double lineWidth = 300;
  @override
  Widget build(BuildContext context) {
    switch (widget.deviceSize) {
      case DeviceSize.small:
        lineWidth = 250;
        break;
      case DeviceSize.medium:
        lineWidth = MediaQuery.of(context).size.width - 800 / 2;
        break;
      case DeviceSize.large:
        lineWidth = lineWidth = MediaQuery.of(context).size.width - 800 / 3;
        break;
    }

    return Row(
      children: [
        Icon(
          Icons.folder_open,
          color: AppStyles.mainColorLight,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (value) => setState(
              () {
                onHover = true;
              },
            ),
            onExit: (value) => setState(
              () {
                onHover = false;
              },
            ),
            child: GestureDetector(
              onTap: widget.onNodeTap,
              child: SizedBox(
                width: lineWidth,
                height: 18,
                child: Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.openSans(
                    color: onHover
                        ? AppStyles.mainColorLight
                        : AppStyles.mainTextColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
