
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/routing/routes.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


mixin DialogPlatform {

  static Future<void> showSnackBar({
    required BuildContext context, 
    required String message, 
    DialogType type = DialogType.error,
    int duration = 3
  }) async{
    Color? color;
    switch (type) {
      case DialogType.error:
        color = AppStyles.errorColor;
        break;
      case DialogType.success:
        color = AppStyles.successColor;
        break;
      case DialogType.info:
        color = AppStyles.infoColor;
        break;
    }    
    final snackBar =  SnackBar(
      content: Center(
        child: Text(message, textAlign: TextAlign.center)
      ),
      elevation: 10,
      duration: Duration(seconds: duration),
      backgroundColor: color,
      dismissDirection: DismissDirection.up
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> showMessage(
      {required BuildContext context,
      required String title,
      required String message,
      DialogType type = DialogType.error}) {
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
                      style:  GoogleFonts.openSans(
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
                      style: GoogleFonts.openSans(
                        color: AppStyles.colorGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
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
                  onPressed: () => getIt<Routes>().pop(),
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
        },
      );
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
                        color: AppStyles.colorGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    )
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
                      fontWeight: FontWeight.w600
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
        barrierDismissible: barrierDismissible,
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
        },
        useRootNavigator: false
      );
  }

  static Future<T?> showScreenDialog<T>({
    String? routeName,
    EdgeInsetsGeometry? padding,
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
  }) =>
    showDialog<T>(
      context: context,
      builder: (context) {
      
        final _defaultPadding = EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 6, vertical: MediaQuery.of(context).size.height / 6);

        return AnimatedPadding(
          padding: padding ?? _defaultPadding,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: ClipRRect(
            child: Material(
              child: builder(context),
            ),
          ),
        );
      }, 
      barrierDismissible: false,
   );
 }
