import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/widgets/web_dialog_title.dart';
import 'package:isc_web_app/widgets/widgets.dart';

class WebDialogWindow extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final Widget? titleActionWidget;

  final VoidCallback onPressed;
  final Widget body;
  final bool buttonActive;
  final bool useSpacer;

  const WebDialogWindow({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.body,
    required this.buttonActive,
    required this.useSpacer,
    required this.buttonTitle,
    this.titleActionWidget,
  }) : super(key: key);

  @override
  State<WebDialogWindow> createState() => _WebDialogWindowState();
}

class _WebDialogWindowState extends State<WebDialogWindow> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: WebDialogTitle(
          actionWidget: widget.titleActionWidget,
          text: widget.title,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
              Expanded(child: widget.body),
            ],
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          Center(
            child: SizedBox(
              width: 200,
              child: DoneButton(
                title: widget.buttonTitle,
                active: widget.buttonActive,
                onPressed: widget.onPressed,
              ),
            ),
          ),
        ],
      );
}
