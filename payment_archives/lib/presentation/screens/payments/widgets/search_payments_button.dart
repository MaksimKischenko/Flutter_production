import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class SearchPaymentsButton extends StatelessWidget {
  final double widthSize;
  final Function() onTap;
  final String? name;

  const SearchPaymentsButton({
    required this.onTap,
    this.widthSize = 100,
    this.name = 'Поиск',
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchPaymentBloc, SearchPaymentState>(
      builder: (context, state) {
        Widget body = const SizedBox();
        if(state is SearchPaymentLoading) {
        body = SizedBox(
          width: widthSize,
          child: MaterialButton(
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
          ),
        );
        } else if(state is SearchPaymentActualInfo) {
            body = SizedBox(
            width: widthSize,
            child: MaterialButton(
              disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
              color: AppStyles.mainColor,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              onPressed: state.requestData != SearchPaymentData.empty() ? onTap : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppStyles.whiteColor, size: 20),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text('$name', style: AppStyles.appBarTitleStyle),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return body;
      },
    );
}


