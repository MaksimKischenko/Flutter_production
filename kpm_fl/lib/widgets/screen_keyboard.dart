import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpm_fl/styles.dart';

import 'keyboard_wrapper.dart';

enum ScreenKeyboardType {
  numeric, text
}

extension ScreenKeyboardTypeExtension on ScreenKeyboardType {
  static const Map<KeyboardLayout, ScreenKeyboardType> _layoutToType = {
    KeyboardLayout.text: ScreenKeyboardType.text,
    KeyboardLayout.numeric: ScreenKeyboardType.numeric,
    KeyboardLayout.decimal: ScreenKeyboardType.numeric
  };
  static ScreenKeyboardType fromKeyboardLayout(KeyboardLayout layout) => _layoutToType[layout] ?? ScreenKeyboardType.text;
}

enum ScreenKeyboardLanguage {
  ru, en
}

class ScreenKeyboard extends StatefulWidget {
  final TextEditingController controller;
  final ScreenKeyboardType type;
  final bool numericDecimal;
  final VoidCallback onHideKeyboardTap;
  const ScreenKeyboard({
    Key? key,
    required this.controller,
    required this.type,
    this.numericDecimal = false,
    required this.onHideKeyboardTap
  }) : super(key: key);

  @override
  State<ScreenKeyboard> createState() => _ScreenKeyboardState();
}

class _ScreenKeyboardState extends State<ScreenKeyboard> {
  bool capsLockUppercase = false;
  late ScreenKeyboardType currentType;
  ScreenKeyboardLanguage currentLanguage = ScreenKeyboardLanguage.ru;

  // general config
  double get spacing => 5;
  double get hspacing => 5;

  // text config
  double get textKeyboarItemSize => 52;
  Color get punctuationButtonColor => CupertinoColors.activeGreen;
  double get spaceWidth => currentLanguage == ScreenKeyboardLanguage.en
      ? textKeyboarItemSize * 6 + spacing * 5
      : textKeyboarItemSize * 5 + spacing * 4;

  // numeric config
  double get numericKeyboarItemSize => 92;

  List<String> get englishLayout => 'qwertyuiopasdfghjklzxcvbnm'.split('');
  List<String> get russianLayout => 'йцукенгшщзхъфывапролджэёячсмитьбю'.split('');

  @override
  void initState() {
    super.initState();
    currentType = widget.type;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: currentType == ScreenKeyboardType.numeric
      ? 390
      : 230,
    child: Stack(
      children: [
        if (currentType == ScreenKeyboardType.text && currentLanguage == ScreenKeyboardLanguage.ru)
        Positioned.fill(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: russianLayout.sublist(0, 12).map(_textKeyboardItem).toList(),
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: russianLayout.sublist(12, 24).map(_textKeyboardItem).toList(),
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  ...russianLayout.sublist(24).map(_textKeyboardItem),
                  _textKeyboardItemBackSpace(),
                ]
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  _textKeyboardItemCaps(),
                  _textKeyboardChangeLanguageButton(),
                  _textKeyboardSpace(),
                  _textKeyboardChangeToNumericButton(),
                  _textKeyboardItem(',', color: punctuationButtonColor),
                  _textKeyboardItem('.', color: punctuationButtonColor),
                  _textKeyboardItem('-', color: punctuationButtonColor),
                  _textKeyboardHideKeyboardButton(),
                ]
              ),
            ],
          ),
        ),
        if (currentType == ScreenKeyboardType.text && currentLanguage == ScreenKeyboardLanguage.en)
        Positioned.fill(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: englishLayout.sublist(0, 10).map(_textKeyboardItem).toList(),
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  ...englishLayout.sublist(10, 19).map(_textKeyboardItem),
                  _textKeyboardItem('-', color: punctuationButtonColor),
                ]
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  ...englishLayout.sublist(19).map(_textKeyboardItem),
                  _textKeyboardItem(',', color: punctuationButtonColor),
                  _textKeyboardItem('.', color: punctuationButtonColor),
                  _textKeyboardItemBackSpace(),
                ]
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  _textKeyboardItemCaps(),
                  _textKeyboardChangeLanguageButton(),
                  _textKeyboardSpace(),
                  _textKeyboardChangeToNumericButton(),
                  _textKeyboardHideKeyboardButton(),
                ]
              ),
            ],
          ),
        ),
        if (currentType == ScreenKeyboardType.numeric)
        Positioned.fill(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  _numericKeyboardItem('1'),
                  _numericKeyboardItem('2'),
                  _numericKeyboardItem('3'),
                ],
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  _numericKeyboardItem('4'),
                  _numericKeyboardItem('5'),
                  _numericKeyboardItem('6'),
                ],
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  _numericKeyboardItem('7'),
                  _numericKeyboardItem('8'),
                  _numericKeyboardItem('9'),
                ],
              ),
              SizedBox(height: spacing),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: hspacing,
                runSpacing: 5,
                children: [
                  if (widget.numericDecimal) _numericKeyboardItem('.') else SizedBox(
                        width: numericKeyboarItemSize,
                        height: numericKeyboarItemSize,
                      ),
                  _numericKeyboardItem('0'),
                  _numericKeyboardItemBackSpace(),
                ],
              )
            ],
          ),
        ),
        if (currentType == ScreenKeyboardType.numeric)
        Align(
          alignment: Alignment.topRight,
          child: Column(
            children: [
              _numericKeyboardHideKeyboardButton(),
              if (widget.type == ScreenKeyboardType.text)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _numericKeyboardChangeToTextButton(),
              )
            ],
          ),
        )
      ],
    ),
  );

  Widget _textKeyboardItem(
    String letter,
    {Color color = const Color(0xFF9E9E9E)
  }) => _keyboardItem(
    capsLockUppercase
        ? letter.toUpperCase()
        : letter,
    size: textKeyboarItemSize,
    color: color,
  );

  Widget _numericKeyboardItem(String letter) => _keyboardItem(
    letter,
    size: numericKeyboarItemSize
  );

  Widget _keyboardItem(
    String letter,
    {required double size,
    Color color = const Color(0xFF9E9E9E)
  }) => ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child: SizedBox(
      width: size,
      height: size,
      child: Material(
        type: MaterialType.button,
        color: color,
        child: InkWell(
          // highlightColor: widget.highlightColor,
          // splashColor: widget.splashColor,
          onTap: () {
            HapticFeedback.heavyImpact();
            widget.controller.text += letter;
            widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length));
          },
          child: Center(
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 25,
                // color: Colors.black,
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        ),
      ),
    ),
  );

  Widget _textKeyboardItemBackSpace() => _backSpace(
    size: textKeyboarItemSize,
    iconSize: 24
  );

  Widget _numericKeyboardItemBackSpace() => _backSpace(
    size: numericKeyboarItemSize,
    iconSize: 32
  );

  Widget _textKeyboardItemCaps() => _actionButton(
    width: textKeyboarItemSize,
    height: textKeyboarItemSize,
    color: AppStyles.mainColor,
    onTap: () {
      HapticFeedback.heavyImpact();
      setState(() {
        capsLockUppercase = !capsLockUppercase;
      });
    },
    // child: Text(
    //   'CAPS',
    //   style: const TextStyle(
    //     fontSize: 25,
    //     // color: Colors.black,
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold
    //   ),
    // )
    child: const Icon(
      Icons.keyboard_capslock,
      color: Colors.white,
      size: 24,
    )
  );

  Widget _backSpace({
    required double size,
    required double iconSize,
  }) => _actionButton(
    width: size,
    height: size,
    color: CupertinoColors.systemRed,
    onTap: () {
      HapticFeedback.heavyImpact();
      if (widget.controller.text.isNotEmpty) {
        widget.controller.text = widget.controller.text
            .substring(0, widget.controller.text.length - 1);
        widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length));
      }
    },
    child: Icon(
      Icons.backspace_outlined,
      color: Colors.white,
      size: iconSize,
    )
  );

  Widget _textKeyboardHideKeyboardButton() => _hideKeyboardButton(
    size: textKeyboarItemSize,
    iconSize: 24,
  );

  Widget _numericKeyboardHideKeyboardButton() => _hideKeyboardButton(
    size: 48,
    iconSize: 24,
  );

  Widget _hideKeyboardButton({
    required double size,
    required double iconSize
  }) => _actionButton(
    width: size,
    height: size,
    color: AppStyles.mainColor,
    onTap: widget.onHideKeyboardTap,
    child: Icon(
      Icons.keyboard_hide,
      color: Colors.white,
      size: iconSize,
    )
  );

  Widget _textKeyboardChangeToNumericButton() => _actionButton(
    width: textKeyboarItemSize,
    height: textKeyboarItemSize,
    color: AppStyles.mainColor,
    onTap: () {
      setState(() {
        currentType = ScreenKeyboardType.numeric;
      });
    },
    child: const Text(
      '123',
      style: TextStyle(
        color: Colors.white,
      ),
    )
  );

  Widget _textKeyboardChangeLanguageButton() => _actionButton(
    width: textKeyboarItemSize,
    height: textKeyboarItemSize,
    color: AppStyles.mainColor,
    onTap: () {
      setState(() {
        currentLanguage = currentLanguage == ScreenKeyboardLanguage.ru
            ? ScreenKeyboardLanguage.en
            : ScreenKeyboardLanguage.ru;
      });
    },
    child: Text(
      currentLanguage == ScreenKeyboardLanguage.ru
          ? 'EN'
          : 'RU',
      style: const TextStyle(
        color: Colors.white,
      ),
    )
  );

  Widget _textKeyboardSpace() => _actionButton(
    width: spaceWidth,
    height: textKeyboarItemSize,
    color: AppStyles.mainColor,
    onTap: () {
      HapticFeedback.heavyImpact();
      widget.controller.text += ' ';
      widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length));
    },
    child: const SizedBox()
  );

  Widget _numericKeyboardChangeToTextButton() => _actionButton(
    width: 48,
    height: 48,
    color: CupertinoColors.destructiveRed,
    onTap: () {
      setState(() {
        currentType = ScreenKeyboardType.text;
      });
    },
    child: const Icon(
      Icons.text_fields_rounded,
      color: Colors.white,
      size: 24,
    )
  );

  Widget _actionButton({
    required double width,
    required double height,
    required Color color,
    required VoidCallback onTap,
    required Widget child
  }) => ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child: SizedBox(
      width: width,
      height: height,
      child: Material(
        type: MaterialType.button,
        color: color,
        child: InkWell(
          // highlightColor: widget.highlightColor,
          // splashColor: widget.splashColor,
          onTap: onTap,
          child: Center(
            child: child,
          ),
        ),
      ),
    ),
  );
}