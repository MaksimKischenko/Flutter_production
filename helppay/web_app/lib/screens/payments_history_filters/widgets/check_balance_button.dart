import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';

class CheckBalanceButton extends StatelessWidget {
  final String cardId;
  const CheckBalanceButton({
    required this.cardId,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.read<ProductsBloc>().add(
              GetProductBalance(
                pan: Pan(
                  evalue: cardId,
                ),
                typePan: TypePan(evalue: 'MSCI'),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SizedBox(
            height: 25,
            width: 25,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                    size: 15,
                  )),
            ),
          ),
        ),
      );
}
