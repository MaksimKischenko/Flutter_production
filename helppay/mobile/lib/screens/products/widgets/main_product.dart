import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'main_product');

class MainProduct extends StatelessWidget {
  final Function(MdomLoginResponseProductsCurrent card) onCardTap;
  final Function(MdomLoginResponseProductsCurrent account) onAccountTap;

  const MainProduct({
    required this.onCardTap,
    required this.onAccountTap,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          Widget body;
          if (state is ProductsInitial) {
            if (state.mainProduct == null) {
              body = Container();
            } else {
              _log('main product equal ${state.mainProduct}');
              body = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainProductTitle(mainProductType: state.mainProductType!),
                  if (state.mainProductType == MainProductType.account)
                    AccountItem(
                      account: state.mainProduct!,
                      onTap: onAccountTap,
                      isMain: true,
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    )
                  else
                    CardItem(
                        card: state.mainProduct!,
                        onTap: onCardTap,
                        isMain: true,
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 24)),
                ],
              );
            }
          } else {
            body = Container();
          }
          return body;
        },
      );
}
