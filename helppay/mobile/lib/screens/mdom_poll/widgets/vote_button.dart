import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class VoteButton extends StatelessWidget {
  final bool editMode;
  final bool active;
  final Function(BuildContext context) onTap;

  const VoteButton(
      {required this.editMode, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: active ? () => onTap(context) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        highlightElevation: 0,
        minWidth: double.maxFinite,
        disabledColor: const Color(0xff8498BC),
        color: AppStyles.mainColor,
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          editMode
              ? context.t.mobileScreens.mdomPoll.voteButton.edit
              : context.t.mobileScreens.mdomPoll.voteButton.vote,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
}
