import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/widgets/filter_info_card.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class PaymentsInfoCards extends StatelessWidget {

  const PaymentsInfoCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchPaymentBloc, SearchPaymentState>(
      builder: (context, state) {
        if (state is SearchPaymentActualInfo) {
          final filteredRequestData = state.requestData.filterProps; 
          return Wrap(
                children: filteredRequestData.mapIndexed((e, index) {
                if(e == null) {
                  return const SizedBox.shrink();
                } else {
                  return FilterInfoCard(
                    title: PaymentActionFieldNames.values[index].message,
                    subtitle: filteredRequestData[index].toString(),
                  );
                }
                }).toList()
          );
        } else {
          return const SizedBox.shrink();
        }        
      },
    );
}
