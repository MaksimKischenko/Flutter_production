import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;

  const NextButton(
      {required this.text,
      required this.onPressed,
      this.color = AppStyles.mainColor});

  @override
  Widget build(BuildContext context) =>
      ResponsiveBuilder(builder: (context, sizingInformation) {
        return BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return SizedBox(
                height: 48,
                width: sizingInformation.isMobile || sizingInformation.isTablet
                    ? MediaQuery.of(context).size.width - 32
                    : 214,
                child: MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                  highlightElevation: 0,
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: LoadingIndicator(),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: 48,
                width: sizingInformation.isMobile || sizingInformation.isTablet
                    ? MediaQuery.of(context).size.width - 32
                    : 214,
                child: MaterialButton(
                  onPressed: onPressed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                  highlightElevation: 0,
                  color: color,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 13),
                      Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      });
}
