import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

// ignore: must_be_immutable
class ProductsCarousel extends StatelessWidget {
  final DataManager dataManager;

  final Function(MdomLoginResponseProductsCurrent product) onProductSelected;

  List<MdomLoginResponseProductsCurrent> productsList = <MdomLoginResponseProductsCurrent>[];

  ProductsCarousel({
    required this.dataManager,
    required this.onProductSelected
  }) {
    productsList = dataManager.userProducts?.current ?? [];
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductsBloc, ProductsState>(
    builder: (context, state) {
      Widget body = Container();
      if (state is ProductsInitial) {
        final mainProductIndex = productsList.indexOf(state.mainProduct!);
        body = Carousel(
          height: 135,
          initialPage: mainProductIndex == -1 ? mainProductIndex : 0,
          itemCount: productsList.length,
          onItemSelected: (index) => onProductSelected(productsList[index]),
          itemBuilder: (context, index) => _itemBuilder(index),
        );
      }
      return body;
    },
  );

  Widget _itemBuilder(int index) {
    final product = productsList[index];
    final typePan = product.params.findByAlias(AliasList.typePan);
    Widget body;
    if (typePan?.evalue == AliasList.typePanAccount) {
      body = AccountItem(product);
    } else if (typePan?.evalue == AliasList.typePanCard) {
      body = CardItem(product);
    } else {
      body = Container();
    }
    return body;
  }
}