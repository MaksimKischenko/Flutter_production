import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class ProductsSegmentControl extends StatelessWidget {
  final ProductsTab selectedTab;
  final Function(ProductsTab activeTab) onTabChanged;

  const ProductsSegmentControl({
    required this.selectedTab,
    required this.onTabChanged
  });
    
  @override
  Widget build(BuildContext context) => Center(
    child: CupertinoSegmentedControl<ProductsTab>(
      borderColor: const Color(0xffF0F2F7),
      unselectedColor: const Color(0xffF0F2F7),
      selectedColor: Colors.white,
      onValueChanged: onTabChanged,
      groupValue: selectedTab,
      children: <ProductsTab, Widget>{
        ProductsTab.accounts: _tabItem(
          name: context.t.mobileScreens.products.productsSegmentControlTitle.account,
          controlledTab: ProductsTab.accounts
        ),
        ProductsTab.cards: _tabItem(
          name: context.t.mobileScreens.products.productsSegmentControlTitle.card,
          controlledTab: ProductsTab.cards
        )
      },
    ),
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