import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

class CreateButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const CreateButton({
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductsBloc, ProductsState>(
    builder: (context, state) {
      if (state is ProductsLoading) {
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
          child: const LoadingIndicator()
        );
      } else {
        return MaterialButton(
          onPressed: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          highlightElevation: 0,
          minWidth: double.maxFinite,
          color: AppStyles.mainColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300
            ),
          )
        );
      }
    },
  );
}