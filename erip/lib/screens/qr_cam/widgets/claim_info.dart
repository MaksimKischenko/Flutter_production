import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaimInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: BlocBuilder<ClaimQrBloc, ClaimQrState>(
      builder: (context, state) {
        if (state is ClaimQrSuccessChecked) {
          final claim = state.claim;
          final fio = '${claim.fio.surname ?? ""} ${claim.fio.firstName ?? ""} ${claim.fio.patronic ?? ""}';
          return Container(
            padding: const EdgeInsets.all(16),
            width: 280,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (fio.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    fio,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Номер заказа',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      claim.accNum,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Сумма',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${claim.sum}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Сумма оплаты',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${claim.paymentSum}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                if (claim.productCharacter != null && claim.productCharacter!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    claim.productCharacter!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32)
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    )
  );
}