import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class ProductsList extends StatelessWidget {
  final List<MdomLoginResponseProductsCurrent> list;
  final MdomLoginResponseProductsCurrent? groupValue;
  final Function(MdomLoginResponseProductsCurrent product) onTap;

  const ProductsList({
    required this.list,
    required this.groupValue,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) => _itemBuilder(index),
    separatorBuilder: (context, _) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: AppStyles.mainColorDark.withOpacity(0.1),
        height: 1
      ),
    ),
    itemCount: list.length
  );

  Widget _itemBuilder(int index) {
    final product = list[index];
    final typePan = product.params.findByAlias(AliasList.typePan);
    Widget body;
    if (typePan?.evalue == AliasList.typePanAccount) {
      body = AccountItem(
        item: product,
        groupValue: groupValue,
        onTap: onTap,
      );
    } else if (typePan?.evalue == AliasList.typePanCard) {
      body = CardItem(
        item: product,
        groupValue: groupValue,
        onTap: onTap,
      );
    } else {
      body = Container();
    }
    return body;
  }
}