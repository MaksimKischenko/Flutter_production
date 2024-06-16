
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/styles.dart';

class PaymentsWebTitleWidget extends StatelessWidget {
  final Function(PaymentsFilterData) openFilters;

  const PaymentsWebTitleWidget({
    super.key,
    required this.openFilters,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Платежи',
            style: TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 24,
              fontWeight: FontWeight.w400,
              letterSpacing: -1.4,
            ),
          ),
          const Spacer(),
          BlocBuilder<PaymentsBloc, PaymentsState>(
            builder: (context, state) {
              if (state is PaymentsInitial) {
                return IconButton(
                  splashRadius: 24,
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Открыть фильтр',
                  onPressed: () => openFilters(state.filter)
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      );
}
