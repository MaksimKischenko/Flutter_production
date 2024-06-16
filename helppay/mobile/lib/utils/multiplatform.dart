// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/injection_component.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Multiplatform {
  static bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

  static const TextTheme iosTextTheme = Typography.blackCupertino;

  static Future<void> showMessage({
    Function()? onPressed,
    bool showReceipt = false,
    required BuildContext context,
    required String title,
    required String message,
    DialogType type = DialogType.error,
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
                        color: AppStyles.mainColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.4,
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
                        color: AppStyles.mainColorDark.withOpacity(0.5),
                        fontSize: 16,
                        // fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                if (showReceipt)
                  ApplyButtonSecondary(
                    text: 'Показать чек',
                    onPressed: onPressed ?? () {},
                  ),
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

    return showDialog<void>(
      context: context,
      //barrierColor: const Color(0xff2E3044).withOpacity(0.5),
      builder: (BuildContext context) {
        final effectivePadding = MediaQuery.of(context).viewInsets +
            (const EdgeInsets.symmetric(horizontal: 40, vertical: 24));
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: AnimatedPadding(
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
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
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
          ),
        );
      },
    );
  }

  static Future<void> showLoaderDialog(BuildContext context) =>
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          final effectivePadding = MediaQuery.of(context).viewInsets +
              (const EdgeInsets.symmetric(horizontal: 40, vertical: 24));
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
                          child: const SizedBox(
                            width: 50,
                            height: 50,
                            child: Material(
                              color: Colors.white,
                              elevation: 24,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              type: MaterialType.card,
                              clipBehavior: Clip.none,
                              child: LoadingIndicator(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  static Future<DateTime?> showdatePicker(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime firstDate,
      required DateTime lastDate}) {
    if (isIOS) {
      final normalHeight = MediaQuery.of(context).copyWith().size.height / 4;
      const maxHeight = 180.0;
      return showModalBottomSheet<DateTime>(
          backgroundColor: const Color(0xffd1d1d1), //.withOpacity(0.9),
          context: context,
          builder: (context) {
            var selected = initialDate;
            return Theme(
              data: Theme.of(context).copyWith(textTheme: iosTextTheme),
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
                                  fontWeight: FontWeight.w400),
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
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    // height: 180,
                    height: normalHeight > maxHeight ? maxHeight : normalHeight,
                    child: CupertinoDatePicker(
                        onDateTimeChanged: (selectedDate) {
                          selected = selectedDate;
                        },
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: initialDate,
                        minimumDate: firstDate,
                        maximumDate: lastDate),
                  )
                ],
              )),
            );
          });
    } else {
      return showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate);
    }
  }

  static void showDecisionMessage(
      {required BuildContext context,
      required String? message,
      required Function() action,
      DecisionType dangetType = DecisionType.danger,
      required String dialogTitle,
      required String buttonTitle,
      required String cancelButtonTitle,
      Function()? cancelAction,
      bool barrierDismissible = true}) {
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
                        color: AppStyles.mainColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.4),
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
                      color: AppStyles.mainColorDark.withOpacity(0.5),
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
                      style: TextStyle(color: cancelColor),
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
                          fontWeight: dangetType == DecisionType.neutral
                              ? FontWeight.bold
                              : FontWeight.normal),
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
          final effectivePadding = MediaQuery.of(context).viewInsets +
              (const EdgeInsets.symmetric(horizontal: 40, vertical: 24));
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: AnimatedPadding(
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
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
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
            ),
          );
        });
  }

  static void showQrPayDecisionMessage({
    required BuildContext context,
    required QrEripData qrEripData,
    required Function() action,
    DecisionType dangetType = DecisionType.danger,
    required String dialogTitle,
    required String buttonTitle,
    required String cancelButtonTitle,
    Function()? cancelAction,
    bool barrierDismissible = true,
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
                        color: AppStyles.mainColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.4),
                  ),
                ),
              ),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(36, 0, 36, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (qrEripData.accNum != null)
                        Text(
                          '${t.mobileScreens.qrScan.modal.confirmation.accountNumber}: ${qrEripData.accNum}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppStyles.mainColorDark.withOpacity(0.5),
                            fontSize: 16,
                            // fontWeight: FontWeight.w600
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      const SizedBox(height: 4),
                      Text(
                        '${t.mobileScreens.qrScan.modal.confirmation.eripCode}: ${qrEripData.eripCode}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppStyles.mainColorDark.withOpacity(0.5),
                          fontSize: 16,
                          // fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (qrEripData.sum != null)
                        Text(
                          '${t.mobileScreens.qrScan.modal.confirmation.summ}: ${qrEripData.sum ?? ''}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppStyles.mainColorDark.withOpacity(0.5),
                            fontSize: 16,
                            // fontWeight: FontWeight.w600
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      if (qrEripData.recieverName != null)
                        Text(
                          '${t.mobileScreens.qrScan.modal.confirmation.recieverName}: ${qrEripData.recieverName ?? ''}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppStyles.mainColorDark.withOpacity(0.5),
                            fontSize: 16,
                            // fontWeight: FontWeight.w600
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  )),
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
                      style: TextStyle(color: cancelColor),
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
                          fontWeight: dangetType == DecisionType.neutral
                              ? FontWeight.bold
                              : FontWeight.normal),
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
          final effectivePadding = MediaQuery.of(context).viewInsets +
              (const EdgeInsets.symmetric(horizontal: 40, vertical: 24));
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: AnimatedPadding(
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
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
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
            ),
          );
        });
  }

  static Future<void> showPinScreenDecisionMessage(
      {required BuildContext context,
      required String? message,
      required Function() action,
      DecisionType dangetType = DecisionType.danger,
      required String dialogTitle,
      required String buttonTitle,
      required String cancelButtonTitle,
      Function()? cancelAction,
      bool barrierDismissible = true}) {
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
                      dialogTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppStyles.mainColorDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(36, 0, 36, 16),
                    child: Text(
                      message ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppStyles.mainColorDark.withOpacity(0.5),
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
                          style: TextStyle(color: cancelColor),
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
                              fontWeight: dangetType == DecisionType.neutral
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
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

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          final effectivePadding = MediaQuery.of(context).viewInsets +
              (const EdgeInsets.symmetric(horizontal: 40, vertical: 24));
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
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
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
        });
  }

  static void showPinScreen({
    required BuildContext context,
    required String correctPin,
    required Function() onSuccess,
    bool canBiometric = false,
    required String title,
    String? footerTitle,
    bool canCancel = false,
    required String cancelButtonTitle,
    required String biometricReason,
    KomplatBiometricType? komplatBiometricType,
  }) {
    final _localAuth = LocalAuthentication();
    screenLock(
        context: context,
        title: Text(title,
            style:
                const TextStyle(color: AppStyles.mainColorDark, fontSize: 16)),
        footer: footerTitle != null
            ? TextButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppStyles.mainColorDark,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  side: BorderSide.none,
                ),
                onPressed: () {
                  Multiplatform.showPinScreenDecisionMessage(
                    context: context,
                    message: t.modal.pinVerify.decisionMessageTitle,
                    action: () {
                      Navigation.toAuth();
                    },
                    dialogTitle: t.modal.pinVerify.forgetPinButton,
                    buttonTitle: t.modal.pinVerify.continueButton,
                    cancelButtonTitle: t.modal.pinVerify.cancelButton,
                  );
                },
                child: Text(footerTitle,
                    style: const TextStyle(
                      color: AppStyles.mainColorDark,
                      fontSize: 18,
                    )))
            : null,
        config: ScreenLockConfig(
            backgroundColor: Colors.white,
            themeData: ThemeData(
              fontFamily: 'Roboto',
              scaffoldBackgroundColor: const Color(0x88545454),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppStyles.mainColorDark,
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(0),
                  side: BorderSide.none,
                ),
              ),
            )),
        correctString: correctPin,
        canCancel: canCancel,
        secretsConfig: const SecretsConfig(
            secretConfig: SecretConfig(
          borderColor: AppStyles.mainColorDark,
          enabledColor: AppStyles.mainColorDark,
        )),
        keyPadConfig: KeyPadConfig(
          actionButtonConfig: KeyPadButtonConfig(
            fontSize: 14,
            foregroundColor: AppStyles.mainColorDark,
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
            foregroundColor: AppStyles.mainColorDark,
            buttonStyle: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.transparent)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32))),
            ),
          ),
        ),
        cancelButton: Text(cancelButtonTitle),
        customizedButtonChild: canBiometric
            ? komplatBiometricType == KomplatBiometricType.faceid
                ? SvgPicture.asset('assets/icon/face_id.svg')
                : const Icon(Icons.fingerprint,
                    size: 36, color: AppStyles.mainColorDark)
            : null,
        customizedButtonTap: canBiometric
            ? () async {
                final didAuthenticate = await _localAuth.authenticate(
                  options: const AuthenticationOptions(
                    biometricOnly: true,
                  ),
                  // authMessages: [
                  //   IOSAuthMessages(),
                  //   AndroidAuthMessages()
                  // ],
                  localizedReason: biometricReason,
                  // androidAuthStrings: const AndroidAuthMessages(
                  //   signInTitle: 'Подтвердите свою личность',
                  //   biometricHint: ''
                  // ),
                  // useErrorDialogs: false,
                  // stickyAuth: true
                );
                if (didAuthenticate) {
                  // return true;
                  Navigator.pop(context);
                  onSuccess();
                }
              }
            : null,
        onOpened: canBiometric
            ? () async {
                final didAuthenticate = await _localAuth.authenticate(
                  options: const AuthenticationOptions(
                    biometricOnly: true,
                  ),
                  // biometricOnly: true,
                  // authMessages: [
                  //   IOSAuthMessages(),
                  //   AndroidAuthMessages()
                  // ],
                  localizedReason: biometricReason,
                  // androidAuthStrings: const AndroidAuthMessages(
                  //   signInTitle: 'Подтвердите свою личность',
                  //   biometricHint: ''
                  // ),
                  // useErrorDialogs: false,
                  // stickyAuth: true
                );
                if (didAuthenticate) {
                  // return true;
                  Navigator.pop(context);
                  onSuccess();
                }
              }
            : null,
        onUnlocked: () {
          Navigator.pop(context);
          onSuccess();
        });
  }

  static void showVerifyPinScreen({
    String? footerTitle,
    required BuildContext context,
    required String title,
    required String confirmTitle,
    required String cancelButtonTitle,
    required Function(String pin) onSuccess,
  }) {
    screenLockCreate(
      context: context,
      title: Text(title,
          style: const TextStyle(color: AppStyles.mainColorDark, fontSize: 16)),
      confirmTitle: Text(confirmTitle,
          style: const TextStyle(color: AppStyles.mainColorDark, fontSize: 16)),
      config: ScreenLockConfig(
        backgroundColor: Colors.white,
        themeData: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: const Color(0x88545454),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppStyles.mainColorDark,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              side: BorderSide.none,
            ),
          ),
        ),
      ),
      secretsConfig: const SecretsConfig(
          secretConfig: SecretConfig(
              borderColor: AppStyles.mainColorDark,
              enabledColor: AppStyles.mainColorDark)),
      keyPadConfig: KeyPadConfig(
        actionButtonConfig: KeyPadButtonConfig(
          fontSize: 14,
          foregroundColor: AppStyles.mainColorDark,
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
          foregroundColor: AppStyles.mainColorDark,
          buttonStyle: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
            side: MaterialStateProperty.all(
                const BorderSide(color: Colors.transparent)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
          ),
        ),
      ),
      cancelButton: Text(
        cancelButtonTitle,
      ),
      onConfirmed: (pin) {
        Navigator.of(context).pop();
        onSuccess(pin);
      },
    );
  }

  static void showBiometricUseDialog({
    required BuildContext context,
    required String buttonTitle,
    required String cancelButtonTitle,
    required KomplatBiometricType komplatBiometricType,
  }) {
    String biometricDescription;
    switch (komplatBiometricType) {
      case KomplatBiometricType.faceid:
        biometricDescription = 'Face ID';
        break;
      case KomplatBiometricType.touchid:
        biometricDescription = 'Touch ID';
        break;
      case KomplatBiometricType.biometric:
        biometricDescription = t.modal.biometricSetup.biometricDescription;
        break;
    }
    Multiplatform.showDecisionMessage(
        context: context,
        message: null,
        action: () {
          context
              .read<ProfileBloc>()
              .add(const ProfileChangeAuthWithBiometrics(value: true));
        },
        dialogTitle: t.modal.biometricSetup.title(
          biometricDescription: biometricDescription,
        ),
        buttonTitle: buttonTitle,
        cancelButtonTitle: cancelButtonTitle,
        dangetType: DecisionType.neutral);
  }

  static Future<T?> showScrollableDialog<T>(
      {required BuildContext context,
      required Widget Function(
              BuildContext context, ScrollController controller)
          builder,
      double topCornerRadius = 12.0}) {
    if (isIOS) {
      return showCupertinoModalBottomSheet<T>(
        topRadius: Radius.circular(topCornerRadius),
        context: context,
        builder: (context) {
          final scrollController = ModalScrollController.of(context)!;
          return Material(
            child: builder(context, scrollController),
          );
        },
        backgroundColor: const Color(0xffFCFCFC),
      );
    } else {
      final topOffset = MediaQuery.of(context).padding.top +
          MediaQuery.of(context).copyWith().size.height * 0.02;
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
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(topCornerRadius))),
        backgroundColor: const Color(0xffFCFCFC),
      );
    }
  }

  static void onExpiredTokenScreenLock(BuildContext context) async {
    final pincode = await SecureStorageManager.read(SecureStorageKeys.pincode);
    BlocProvider.of<AuthBloc>(context).add(AuthRefreshToken(
        token: InjectionComponent.getDependency<DataManager>().token));
    // Navigator.pop(context);
    await Future.delayed(
        const Duration(milliseconds: 500),
        () => Multiplatform.showPinScreen(
              context: context,
              correctPin: pincode!,
              onSuccess: () => Navigation.toMdomAccruals,
              title: t.modal.pinVerify.title,
              footerTitle: t.modal.pinVerify.forgetPinButton,
              cancelButtonTitle: t.modal.pinVerify.cancelButton,
              biometricReason: '',
            )
        //  Navigation.toAuth
        );
  }
}
