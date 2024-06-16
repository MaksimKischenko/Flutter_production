import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';


class DialogWrapper extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final VoidCallback onApplyPressed;
  final Widget body;

  const DialogWrapper({
    Key? key,
    required this.onApplyPressed,
    required this.title,
    required this.buttonTitle,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: DialogTitle(
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
    persistentFooterButtons: [
      SubmitDialogButton(
        name: buttonTitle,
        onTap: onApplyPressed,
      )    
    ],
  );
}
