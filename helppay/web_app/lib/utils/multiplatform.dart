// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class Multiplatform {
  static const TextTheme iosTextTheme = Typography.blackCupertino;

  static Future<void> showMessage({
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
                          letterSpacing: -0.4),
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
                )
              ],
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         AutoRouter.of(context).pop();
            //       },
            //       icon: SvgPicture.asset('assets/icon/dialog_close.svg'),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );

    return showDialog<void>(
        context: context,
        routeSettings: const RouteSettings(name: '/multiplatform_dialog'),
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
                          SvgPicture.asset('assets/icon/$iconName.svg'),
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

  static Future<DateTime?> showdatePicker(
          {required BuildContext context,
          required DateTime initialDate,
          required DateTime firstDate,
          required DateTime lastDate}) =>
      showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate);

  static void showDecisionMessage(
      {required BuildContext context,
      required String? message,
      required Function() action,
      DecisionType dangetType = DecisionType.danger,
      required String dialogTitle,
      required String buttonTitle,
      required String cancelButtonTitle,
      Function()? cancelAction,
      String? routenName,
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
                      AutoRouter.of(context).pop();
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
                      AutoRouter.of(context).pop();
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
        routeSettings: RouteSettings(name: routenName),
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

  static Future<T?> showScrollableDialog<T>(
      {required BuildContext context,
      required Widget Function(
              BuildContext context, ScrollController controller)
          builder,
      double topCornerRadius = 12.0}) {
    final topOffset = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).copyWith().size.height * 0.3;
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: MediaQuery.of(context).copyWith().size.height - topOffset,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(topCornerRadius),
          child: Material(
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

  static Future<T?> showWebDialog<T>({
    required BuildContext context,
    EdgeInsetsGeometry? padding,
    required Widget Function(BuildContext context) builder,
  }) =>
      showDialog<T>(
        context: context,
        builder: (context) {
          final effectivePadding = EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3.3,
              vertical: MediaQuery.of(context).size.height / 3.3);
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: AnimatedPadding(
              padding: padding ??
                  effectivePadding, //padding ?? const EdgeInsets.all(100),
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Material(
                  child: builder(context),
                ),
              ),
            ),
          );
        },
        barrierDismissible: true,
      );
}
