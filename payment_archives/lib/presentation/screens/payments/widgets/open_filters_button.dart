import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class OpenFiltersButton extends StatelessWidget {
  final Function() onAddTap;

  const OpenFiltersButton({
    Key? key,
    required this.onAddTap,
    }): super(key: key);

  @override
  Widget build(BuildContext context) =>  BlocBuilder<SearchPaymentBloc, SearchPaymentState>(
    builder: (context, state) {
      Widget mainBody = const SizedBox();
        if(state is SearchPaymentActualInfo) {
          mainBody = MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),     
            shape: Border.all(
              color: AppStyles.colorGold
            ),
            onPressed: onAddTap,
            child: Row(
              children: [
                const Icon(Icons.search, size: 16, color: AppStyles.colorGold),
                const SizedBox(width: 4),
                Text(
                  'Поиск',
                  style: AppStyles.textStyleBlackTextButton.copyWith(
                    color: AppStyles.colorGold
                  )
                ),
              ],
            ),
          );
      } 
      return mainBody;
    },
  );
}
