import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class ProductSelector extends StatelessWidget {
  final ProductsTab selectedTab;
  final Function(ProductsTab activeTab) onTabChanged;

  const ProductSelector({
    required this.selectedTab,
    required this.onTabChanged
  });
    
  @override
  Widget build(BuildContext context) => CupertinoSegmentedControl<ProductsTab>(
    borderColor: const Color(0xffF0F2F7),
    unselectedColor: const Color(0xffF0F2F7),
    selectedColor: Colors.white,
    onValueChanged: onTabChanged,
    groupValue: selectedTab,
    children: <ProductsTab, Widget>{
      ProductsTab.accounts: _tabItem(
        name: context.t.mobileScreens.productAdd.productSelector.account,
        controlledTab: ProductsTab.accounts
      ),
      ProductsTab.cards: _tabItem(
        name: context.t.mobileScreens.productAdd.productSelector.card,
        controlledTab: ProductsTab.cards
      )
    },
  );

  Widget _tabItem({
    required String name,
    required ProductsTab controlledTab
  }) => Padding(
    padding: const EdgeInsets.fromLTRB(40, 6, 40, 6),
    child: Text(
      name,
      style: TextStyle(
        color: selectedTab == controlledTab
          ? AppStyles.mainColorDark
          : AppStyles.mainColorDark.withOpacity(0.5),
        fontSize: 16,
        letterSpacing: -0.1
      ),
    )
  );
}