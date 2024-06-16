import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/screens/products/widgets/card_agreement_dialog_child.dart';
import 'package:helppay_core/helppay_core.dart';

// ignore: avoid_classes_with_only_static_members
class CardOrderAgreementDialogWidgetActivator {
  static Future<void> showMessage({
    required BuildContext context,
    DialogType type = DialogType.info,
  }) =>
      showDialog<void>(
        context: context,
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
                              constraints: BoxConstraints(
                                minWidth: 280,
                                maxHeight: MediaQuery.of(context).size.height / 3.5
                              ),
                              child: SizedBox(
                                width: 100,
                                child: Material(
                                  color: Colors.white,
                                  elevation: 24,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                  ),
                                  type: MaterialType.card,
                                  clipBehavior: Clip.none,
                                  child: CardAgreementDialogChild(),
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
                          SvgPicture.asset('assets/icon/dialog_info.svg'),
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
