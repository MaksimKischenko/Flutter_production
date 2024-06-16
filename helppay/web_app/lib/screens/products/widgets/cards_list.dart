import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class CardsList extends StatelessWidget {
  final Function(MdomLoginResponseProductsCurrent account) onTap;

  const CardsList({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductsBloc, ProductsState>(
    builder: (context, state) {
      Widget body;
      if (state is ProductsInitial) {
        body = Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 64),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: state.cardsList.length,
            itemBuilder: (context, index) => CardItem(
              card: state.cardsList[index],
              onTap: onTap,
            )
          ),
        );
      } else {
        body = Container();
      }
      return body;
    },
  );
}