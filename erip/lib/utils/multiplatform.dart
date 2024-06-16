
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


mixin Multiplatform {

  static bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

  static const TextTheme iosTextTheme = Typography.blackCupertino;
  
  static Future<DateTime?> showdatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate
  }) {
    if (isIOS) {
      final normalHeight = MediaQuery.of(context).copyWith().size.height / 4;
      const maxHeight = 180.0;
      return showModalBottomSheet<DateTime>(
        backgroundColor: const Color(0xffd1d1d1),//.withOpacity(0.9),
        context: context,
        builder: (context) {
          var selected = initialDate;
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: iosTextTheme
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: const Color(0xffffffff).withOpacity(0.5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Закрыть',
                            style: TextStyle(
                              color: CupertinoColors.systemRed,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, selected),
                          child: const Text(
                            'Готово',
                            style: TextStyle(
                              color: CupertinoColors.systemBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  SizedBox(
                    // height: 180,
                    height: normalHeight > maxHeight
                        ? maxHeight
                        : normalHeight,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (selectedDate) { selected = selectedDate; },
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: initialDate,
                      minimumDate: firstDate,
                      maximumDate: lastDate
                    ),
                  )
                ],
              )
            ),
          );
        }
      );
    } else {
      return showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate
      );
    }
  }

  static Future<DateTime?> showTimePicker({
    required BuildContext context,
    required DateTime initialTime,
  }) async {
    if (isIOS) {
      final normalHeight = MediaQuery.of(context).copyWith().size.height / 4;
      const maxHeight = 180.0;
      return material.showModalBottomSheet<DateTime>(
        backgroundColor: const Color(0xffd1d1d1),//.withOpacity(0.9),
        context: context,
        builder: (context) {
          var selected = initialTime;
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: iosTextTheme
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: const Color(0xffffffff).withOpacity(0.5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        material.TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Закрыть',
                            style: TextStyle(
                              color: CupertinoColors.systemRed,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        material.TextButton(
                          onPressed: () => Navigator.pop(context, selected),
                          child: const Text(
                            'Готово',
                            style: TextStyle(
                              color: CupertinoColors.systemBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  SizedBox(
                    // height: 180,
                    height: normalHeight > maxHeight
                        ? maxHeight
                        : normalHeight,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (selectedDate) { selected = selectedDate; },
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: initialTime,
                      minimumDate: initialTime.subtract(const Duration(days: 1)),
                      maximumDate: initialTime.add(const Duration(days: 1)),
                      use24hFormat: MediaQuery.of(context).alwaysUse24HourFormat,
                    ),
                  )
                ],
              )
            ),
          );
        }
      );
    } else {
      final time = await material.showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialTime),
      );
      if (time == null) {
        return null;
      } else {
        return DateTime(initialTime.year, initialTime.month, initialTime.day, time.hour, time.minute, 59);
      }
    }
  }

  static Future<T?> showMessage<T>({
    required BuildContext context,
    required String title,
    required String message,
    DialogType type = DialogType.error
  }) {
    String iconName;
    switch (type) {
      case DialogType.error:
        iconName = 'dialog_error';
        break;
      case DialogType.success:
        iconName = 'dialog_success';
        break;
      case DialogType.info:
        iconName = 'dialog_info';
        break;
    }

    final Widget dialogChild = IntrinsicWidth(
      stepWidth: 56,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 40, 36, 8),
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppStyles.mainTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.4
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(36, 0, 36, 16),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppStyles.mainTextColor.withOpacity(0.5),
                        fontSize: 16,
                        // fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigation.navigatorKey.currentState?.pop(),
                  icon: SvgPicture.asset('assets/icon/dialog_close.svg'),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        final effectivePadding = MediaQuery.of(context).viewInsets + (const EdgeInsets.symmetric(horizontal: 40, vertical: 24));
        return AnimatedPadding(
          padding: effectivePadding,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Center(
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 33),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 280),
                          child: SizedBox(
                            width: 100,
                            child: Material(
                              color: Colors.white,
                              elevation: 24,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              type: MaterialType.card,
                              clipBehavior: Clip.none,
                              child: dialogChild,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icon/$iconName.svg'),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  static void showMessageWithContent({
    required BuildContext context,
    required String? title,
    required String? message,
    required Widget content,
    DialogType type = DialogType.error
  }) {
    String iconName;
    switch (type) {
      case DialogType.error:
        iconName = 'dialog_error';
        break;
      case DialogType.success:
        iconName = 'dialog_success';
        break;
      case DialogType.info:
        iconName = 'dialog_info';
        break;
    }

    final dialogChild = IntrinsicWidth(
      stepWidth: 56,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 40, 36, 8),
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppStyles.mainTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.4
                        ),
                      ),
                    ),
                  ),
                if (message != null && message.isNotEmpty)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(36, 0, 36, 16),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppStyles.mainTextColor.withOpacity(0.5),
                          fontSize: 16,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                Center(child: content)
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigation.navigatorKey.currentState?.pop(),
                  icon: SvgPicture.asset('assets/icon/dialog_close.svg'),
                ),
              ],
            )
          ],
        ),
      ),
    );

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final effectivePadding = MediaQuery.of(context).viewInsets + (const EdgeInsets.symmetric(horizontal: 40, vertical: 24));
        return AnimatedPadding(
          padding: effectivePadding,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Center(
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 33),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 280),
                          child: SizedBox(
                            width: 100,
                            child: Material(
                              color: Colors.white,
                              elevation: 24,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              type: MaterialType.card,
                              clipBehavior: Clip.none,
                              child: dialogChild,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icon/$iconName.svg'),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  static Future<T?> showDropDown<T>({
    required BuildContext context,
    required List<T> list,
    required List<String> visibleList,
    T? selected,
    String? title
  }) {
    if (isIOS) {
      final selectedIndex = selected == null ? 0 : list.indexOf(selected);
      return material.showModalBottomSheet<T>(
        backgroundColor: const Color(0xffd1d1d1),//.withOpacity(0.9),
        context: context,
        builder: (context) {
          T? selectedItem = selected ?? list[0];
          return Theme(
            data: Theme.of(context).copyWith(
              textTheme: iosTextTheme
            ),
            child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        color: const Color(0xffffffff).withOpacity(0.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            material.TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Закрыть',
                                style: TextStyle(
                                    color: CupertinoColors.systemRed,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            material.TextButton(
                              onPressed: () => Navigator.pop(context, selectedItem),
                              child: const Text(
                                'Готово',
                                style: TextStyle(
                                    color: CupertinoColors.systemBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).copyWith().size.height / 4,
                      child: CupertinoPicker(
                        scrollController: material.FixedExtentScrollController(initialItem: selectedIndex),
                        itemExtent: 36,
                        onSelectedItemChanged: (int index) {
                          selectedItem = list[index];
                        },
                        children: visibleList.map((item) => Center(
                          child: Text(
                            item,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: material.TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24
                            ),
                          )
                        )).toList(),
                      ),
                    )
                  ],
                )
            ),
          );
        }
      );
    } else {
      return material.showDialog<T>(
        context: context,
        builder: (context) => material.SimpleDialog(
          title: title != null && title.isNotEmpty
          ? Text(
            title,
            style: const TextStyle(
              fontSize: 18
            ),
          )
          : null,
          children: visibleList
            .asMap()
            .map((i, item) => MapEntry(i,
              material.SimpleDialogOption(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    item,
                    style: const TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                onPressed: () => material.Navigator.pop(context, list[i]),
              )
            ))
            .values
            .toList(),
        )
      );
    }
  }

  static void showDecisionMessage({
    required BuildContext context,
    required String? message,
    required Function() action,
    DecisionType dangetType = DecisionType.danger,
    String dialogTitle = 'Внимание',
    String buttonTitle = 'OК',
    String cancelButtonTitle = 'Отмена',
    Function()? cancelAction,
    bool barrierDismissible = true
  }) {
    Color? cancelColor;
    Color? buttonColor;
    switch (dangetType) {
      case DecisionType.danger:
        cancelColor = AppStyles.mainColor;
        buttonColor = const Color(0xffFF3B30);
        break;
      case DecisionType.neutral:
        cancelColor = AppStyles.mainColor;
        buttonColor = AppStyles.mainColor;
        break;
      case DecisionType.notDanger:
        cancelColor = const Color(0xffFF3B30);
        buttonColor = AppStyles.mainColor;
        break;
      default:
    }
    final dialogChild = IntrinsicWidth(
      stepWidth: 56,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (dialogTitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(36, 40, 36, 8),
                child: Center(
                  child: Text(
                    dialogTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppStyles.mainTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4
                    ),
                  ),
                ),
              ),
            if (message?.isNotEmpty ?? false)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(36, 0, 36, 16),
                  child: Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppStyles.mainTextColor.withOpacity(0.5),
                      fontSize: 16,
                      // fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                      cancelAction?.call();
                    },
                    child: Text(
                      cancelButtonTitle,
                      style: TextStyle(
                        color: cancelColor
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                      action();
                    },
                    child: Text(
                      buttonTitle,
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: dangetType == DecisionType.neutral ? FontWeight.bold : FontWeight.normal
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );

    showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        final effectivePadding = MediaQuery.of(context).viewInsets + (const EdgeInsets.symmetric(horizontal: 40, vertical: 24));
        return AnimatedPadding(
          padding: effectivePadding,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Center(
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 33),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 280),
                          child: SizedBox(
                            width: 100,
                            child: Material(
                              color: Colors.white,
                              elevation: 24,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              type: MaterialType.card,
                              clipBehavior: Clip.none,
                              child: dialogChild,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icon/dialog_ask.svg'),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  static void showPinScreen({
    required BuildContext context,
    required String correctPin,
    required Function onSuccess,
    bool canBiometric = false,
    String title = 'Введите PIN',
    bool canCancel = false,
    KomplatBiometricType? komplatBiometricType
  }) {
    final _localAuth = LocalAuthentication();
    screenLock(
      context: context,
      title: Text(title),
      config: ScreenLockConfig(
        backgroundColor: Colors.white,
        themeData: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: const Color(0x88545454),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppStyles.mainTextColor,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              side: BorderSide.none,
            ),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 20,
            ),
            bodyMedium: TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 18,
            ),
          ),
        )
      ),
      correctString: correctPin,
      canCancel: canCancel,
      secretsConfig: const SecretsConfig(
        secretConfig: SecretConfig(
          borderColor: AppStyles.mainTextColor,
          enabledColor: AppStyles.mainTextColor, 
        )
      ),

        keyPadConfig: KeyPadConfig(
          actionButtonConfig: KeyPadButtonConfig(
            fontSize: 14,
            foregroundColor: const Color(0x88545454),
            buttonStyle: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.transparent)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32))),
            ),
          ),
          buttonConfig: KeyPadButtonConfig(
            fontSize: 24,
            
            foregroundColor: const Color(0x88545454),
            buttonStyle: ButtonStyle(
              textStyle: MaterialStateProperty.all(const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 36,
          color: AppStyles.mainTextColor
        )),
              padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.transparent)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32))),
            ),
          ),
        ),
      cancelButton: const Text('Отмена'),
      customizedButtonChild: canBiometric ? komplatBiometricType == KomplatBiometricType.faceid
          ? SvgPicture.asset('assets/icon/face_id.svg')
          : const Icon(
              Icons.fingerprint,
              size: 36,
              color: AppStyles.mainTextColor
          )
        : null,
      customizedButtonTap: canBiometric ? () async {
        final didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'Авторизация в приложении',
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
          authMessages: [
            const AndroidAuthMessages(
              signInTitle: 'Подтвердите свою личность',
              biometricHint: ''
            ),            
          ] 
          // useErrorDialogs: false,
          // stickyAuth: true
        );
        if (didAuthenticate) {
          // return true;
          Navigator.pop(context);
          onSuccess();
        }
      } : null,
      onOpened: canBiometric ? () async {
        final didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'Авторизация в приложении',
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
          authMessages: [
            const AndroidAuthMessages(
              signInTitle: 'Подтвердите свою личность',
              biometricHint: ''
            ),            
          ]           
        );
        if (didAuthenticate) {
          // return true;
          Navigator.pop(context);
          onSuccess();
        }
      } : null,
      onUnlocked: () {
        Navigator.pop(context);
        onSuccess();
      }
    );
  }

  static void showVerifyPinScreen({
    required BuildContext context,
    required String title,
    required Function(String pin) onSuccess
  }) {
    screenLockCreate(
      context: context,
      title: Text(title),
      confirmTitle: const Text('Повторите новый PIN'),
      config: ScreenLockConfig(
        backgroundColor: Colors.white,
        themeData: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: const Color(0x88545454),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppStyles.mainTextColor,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              side: BorderSide.none,
            ),
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 20,
            ),
            bodyMedium: TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 18,
            ),
          ),
        )
      ),
      secretsConfig: const SecretsConfig(
        secretConfig: SecretConfig(
          borderColor: AppStyles.mainTextColor,
          enabledColor: AppStyles.mainTextColor
        )
      ),
        keyPadConfig: KeyPadConfig(
          actionButtonConfig: KeyPadButtonConfig(
            fontSize: 14,
            foregroundColor: const Color(0x88545454),
            buttonStyle: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.transparent)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32))),
            ),
          ),
          buttonConfig: KeyPadButtonConfig(
            fontSize: 24,
            
            foregroundColor: const Color(0x88545454),
            buttonStyle: ButtonStyle(
              textStyle: MaterialStateProperty.all(const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 36,
          color: AppStyles.mainTextColor
        )),
              padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.transparent)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32))),
            ),
          ),
        ),
      cancelButton: const Text('Отмена'),
      onConfirmed: (pin) {
        Navigator.of(context).pop();
        onSuccess(pin);
      },
    );
  }

  static Future<T?> showScrollableDialog<T>({
    required BuildContext context,
    required Widget Function(BuildContext context, ScrollController? controller) builder,
    double topCornerRadius = 12.0
  }) {
    if (isIOS) {
      return showCupertinoModalBottomSheet<T>(
        topRadius: Radius.circular(topCornerRadius),
        context: context,
        builder: (context) {
          final scrollController = ModalScrollController.of(context);
          return Material(
            child: builder(context, scrollController),
          );
        },
        backgroundColor: AppStyles.scaffoldColor,
      );
    } else {
      final topOffset = MediaQuery.of(context).padding.top +  MediaQuery.of(context).copyWith().size.height * 0.02;
      return showModalBottomSheet<T>(
        context: context,
        builder: (context) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          // padding: MediaQuery.of(context).viewInsets,
          height: MediaQuery.of(context).copyWith().size.height - topOffset,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(topCornerRadius),
            child: Material(
              // child: builder(context, null),
              child: builder(context, ScrollController()),
            ),
          ),
        ),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(topCornerRadius)
          )
        ),
        backgroundColor: AppStyles.scaffoldColor,
      );
    }
  }

  static Future<T?> showActionSheet<T>({
    required BuildContext context,
    required List<ModalActionItem> actions, 
    String? title
  }) {
    if (isIOS) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: title != null
              ? Text(title)
              : null,
          actions: actions.map((e) => CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(e.value),
            isDestructiveAction: e.isDestructive,
            child: Text(e.text),
          )).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
        )
      );
    } else {
      return material.showDialog<T>(
        context: context,
        builder: (context) => material.SimpleDialog(
          title: title != null && title.isNotEmpty
          ? Text(
            title,
            style: const TextStyle(
              fontSize: 18
            ),
          )
          : null,
          children: actions.map((e) => material.SimpleDialogOption(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                e.text,
                style: const TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.w400
                ),
              ),
            ),
            onPressed: () => material.Navigator.pop(context, e.value),
          )).toList(),
        )
      );
    }
  }

}