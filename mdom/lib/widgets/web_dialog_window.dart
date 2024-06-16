import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WebDialogWindow extends StatelessWidget {
  final String title;

  final Widget? titleActionWidget;
  final bool createSecondButton;
  final String? secondButtonTitle;
  final bool? secondButtonActive;
  final VoidCallback? secondButtonCallback;
  final String buttonTitle;
  final bool buttonActive;
  final VoidCallback onPressed;
  final Widget body;

  const WebDialogWindow({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.body,
    required this.buttonActive,
    required this.buttonTitle,
    this.titleActionWidget,
    this.createSecondButton = false,
    this.secondButtonTitle,
    this.secondButtonCallback,
    this.secondButtonActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: WebDialogTitle(
          actionWidget: titleActionWidget,
          text: title,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                Expanded(child: body),
              ],
            ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: createSecondButton
            ? [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: DoneButton(
                        title: buttonTitle,
                        active: buttonActive,
                        onPressed: onPressed,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 200,
                      child: DoneButton(
                        title: secondButtonTitle ?? '',
                        active: secondButtonActive ?? false,
                        onPressed: secondButtonCallback ?? () {},
                      ),
                    ),
                  ],
                )
              ]
            : [
                Center(
                  child: SizedBox(
                    width: 200,
                    child: DoneButton(
                      title: buttonTitle,
                      active: buttonActive,
                      onPressed: onPressed,
                    ),
                  ),
                ),
              ],
      );
}
