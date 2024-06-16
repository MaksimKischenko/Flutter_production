import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

// ignore: avoid_classes_with_only_static_members
class AppStyles {

  ///
  /// Colors
  ///

  static const Color mainColor = Color(0xff1e50a8);

  static const Color mainColorDark = Color(0xff383a51);

  static const Color secondaryColor = Color(0xff56c5af);
  
  static const Color scaffoldColor = Colors.white;

  ///
  /// Text
  ///

  static const Color mainTextColor = Color(0xff172030);

  ///
  /// Inputs
  ///

  static InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: mainColor.withOpacity(0.2)
    )
  );

  static InputBorder inputBorderUnderline = UnderlineInputBorder(
    borderSide: BorderSide(
      color: mainColor.withOpacity(0.1)
    )
  );

  static TextStyle inputLabelStyle = TextStyle(
    color: mainTextColor.withOpacity(0.5)
  );

  static TextStyle inputLabelUnderlineStyle = TextStyle(
    fontSize: 18,
    color: mainTextColor.withOpacity(0.6),
  );

  static const double inputIconSize = 24;

  static const Color inputIconColor = Color(0xff9D9D9F);

  ///
  /// Buttons
  ///

  ///
  /// Keyboard
  ///
  
  static KeyboardActionsConfig keyboardConfig({
    List<KeyboardActionsItem>? actions,
  }) => KeyboardActionsConfig(
    keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
    keyboardBarColor: Colors.grey[200],
    nextFocus: false,
    actions: actions
  );

  /// russian done button
  static Widget doneButton(FocusNode node) => GestureDetector(
    onTap: () => node.unfocus(),
    child: Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: const Text(
        'Готово',
        style: TextStyle(
          // color: CupertinoColors.systemBlue,
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400
        ),
      ),
    ),
  );
}