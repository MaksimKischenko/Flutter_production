import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class EnterButton extends StatefulWidget {
  final void Function() onAuthTap;

  const EnterButton({
    Key? key,
    required this.onAuthTap,
  }) : super(key: key);

  @override
  State<EnterButton> createState() => _EnterButtonState();
}

class _EnterButtonState extends State<EnterButton> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) {
          setState(() {
            isFocused = true;
          });
        },
        onExit: (_) {
          setState(() {
            isFocused = false;
          });
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if(state is AuthLoading) {
              return MaterialButton(
                disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
                color: AppStyles.mainColor,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                onPressed: null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: LoadingIndicator(
                    indicatorsSize: 24,
                    color: AppStyles.whiteColor
                  )
                ),
              );
            } else {
              return MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              color: isFocused ? AppStyles.colorGold2 : AppStyles.colorGold,
              focusColor: AppStyles.colorGold2,
              onPressed: widget.onAuthTap,
              child: const Text('Войти',
                  style: AppStyles.textStyleWhiteTextButton),
            );
            }
          },
        ),
      );
}
