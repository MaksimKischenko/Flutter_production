import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// ignore: avoid_classes_with_only_static_members
/// Help to show platform-fliendly UI
class Multiplatform {

  static bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

  static const TextTheme iosTextTheme = Typography.blackCupertino;

  static void showMessage({
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

    final dialogChild = IntrinsicWidth(
      stepWidth: 56,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 40, 36, 8),
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
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
              children: <Widget>[
                IconButton(
                  splashRadius: 1,
                  onPressed: () => Navigation.navigatorKey.currentState?.pop(),
                  icon: const SvgAssets('icon/dialog_close.svg'),
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
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                    children: <Widget>[
                      SvgAssets('icon/$iconName.svg')
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

  static void showDecisionMessage({
    required BuildContext context,
    required String message,
    required Function action,
    DecisionType dangetType = DecisionType.danger,
    String dialogTitle = 'Внимание',
    String buttonTitle = 'OК',
    String cancelButtonTitle = 'Отмена'}
  ) {
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
          children: <Widget>[
            if (dialogTitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(36, 40, 36, 8),
                child: Center(
                  child: Text(
                    dialogTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      color: AppStyles.mainTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4
                    ),
                  ),
                ),
              ),
            if (message.isNotEmpty)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(36, 0, 36, 16),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      color: AppStyles.mainTextColor.withOpacity(0.5),
                      fontSize: 16,
                      // fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      cancelButtonTitle,
                      style: GoogleFonts.openSans(
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
                      style: GoogleFonts.openSans(
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
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgAssets('icon/dialog_ask.svg'),
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

  static Future<DateTime?> showdatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate
  }) => showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    initialEntryMode: DatePickerEntryMode.input,
    lastDate: lastDate
  );

  static Future<TimeOfDay?> showOnlyTimePicker({
    required BuildContext context,
    required DateTime initialDate,
   
  }) => showTimePicker(
    context: context,
    initialEntryMode: TimePickerEntryMode.input,
    initialTime: TimeOfDay.fromDateTime(initialDate)
  );

}