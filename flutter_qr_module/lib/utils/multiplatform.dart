import 'dart:ui';

import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/models/models.dart';
import 'package:fl_qr_module/navigation.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/utils/qr_erip.dart';
import 'package:fl_qr_module/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

mixin Multiplatform {
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

  static Future<T?> showScrollableDialog<T>({
    required BuildContext context,
    required Widget Function(BuildContext context, ScrollController controller)
        builder,
    double topCornerRadius = 12.0,
    bool? enableDrag,
  }) {
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
        isDismissible: false,
        enableDrag: enableDrag ?? true,
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
}
