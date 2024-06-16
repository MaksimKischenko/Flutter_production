import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

class PayButton extends StatelessWidget {
  final bool isActive;
  final Function(BuildContext context) onTap;

  const PayButton({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) => Container(
        color: const Color(0xffFCFCFC),
        child: SafeArea(
          child: BlocBuilder<ConfirmBloc, ConfirmState>(
            builder: (context, state) {
              if (state is ConfirmLoading) {
                return MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    highlightElevation: 0,
                    minWidth: double.maxFinite,
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(top: 15, bottom: 14),
                    child: const SizedBox(
                        width: 20, height: 20, child: LoadingIndicator()));
              } else {
                return MaterialButton(
                    onPressed: isActive ? onTap(context) : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    highlightElevation: 0,
                    minWidth: double.maxFinite,
                    color: AppStyles.mainColor,
                    disabledColor: AppStyles.mainTextColor.withOpacity(0.4),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: const Text(
                      'Оплатить все',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        // fontWeight: FontWeight.w600
                      ),
                    ));
              }
            },
          ),
        ),
      );
}
