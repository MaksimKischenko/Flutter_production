import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/multiplatform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    icon: const Icon(Icons.filter_list),
                    tooltip: 'Открыть фильтр',
                    onPressed: () => checkAvailability(
                          onAvailable: () => openFilters(state.filter),
                          context: context,
                        ));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      );

  void checkAvailability({
    required VoidCallback onAvailable,
    required BuildContext context,
  }) {
    if (context.read<FeaturesBloc>().state.availableFeatures) {
      onAvailable();
    } else {
      Multiplatform.showMessage<void>(
          context: context,
          title: 'Инфо',
          message: 'Данная функция Вам недоступна',
          type: DialogType.info);
    }
  }
}
