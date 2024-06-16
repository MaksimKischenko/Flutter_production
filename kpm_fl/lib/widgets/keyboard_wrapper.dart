// import 'package:built_in_keyboard/built_in_keyboard.dart';
// import 'package:built_in_keyboard/language.dart';
import 'package:flutter/material.dart';
import 'package:kpm_fl/widgets/widgets.dart';

enum KeyboardLayout {
  text, numeric, decimal
}

class KeyboardWrapper extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueNotifier<bool> keyboardVisibility;
  final ValueNotifier<KeyboardLayout> keyboardLayout;
  final VoidCallback onHideKeyboardTap;
  final Widget child;
  const KeyboardWrapper({
    Key? key,
    required this.textEditingController,
    required this.keyboardVisibility,
    required this.keyboardLayout,
    required this.onHideKeyboardTap,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned.fill(child: child),
      ValueListenableBuilder<bool>(
        valueListenable: keyboardVisibility,
        builder: (context, value, child) {
          if (value) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(16),
                // constraints: const BoxConstraints(
                //   maxHeight: 300
                // ),
                // height: 300,
                color: Colors.grey.shade400.withOpacity(.5),
                child: ValueListenableBuilder<KeyboardLayout>(
                  valueListenable: keyboardLayout,
                  builder: (context, value, child) => ScreenKeyboard(
                    key: Key('keyboard$value'),
                    controller: textEditingController,
                    type: ScreenKeyboardTypeExtension.fromKeyboardLayout(value),
                    onHideKeyboardTap: onHideKeyboardTap,
                    numericDecimal: value == KeyboardLayout.decimal,
                  ),
                )
                // child: BuiltInKeyboard(
                //   controller: textEditingController,
                //   language: Language.NUMERIC,
                //   layout: Layout.QWERTY,
                //   enableSpaceBar: true,
                //   enableBackSpace: true,
                //   enableCapsLock: true,
                //   color: Colors.grey,
                //   borderRadius: BorderRadius.circular(8),
                //   letterStyle: const TextStyle(
                //     fontSize: 25,
                //     color: Colors.white,
                //   )
                // ),
              ),
            );
          } else {
            return Container();
          }
        },
      )
    ],
  );
}