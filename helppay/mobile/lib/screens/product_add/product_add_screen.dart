import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class ProductAddScreen extends StatefulWidget {
  final ScrollController scrollController;

  const ProductAddScreen({required this.scrollController});

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  ProductsTab selectedTab = ProductsTab.accounts;

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsSuccessAdd) {
            _productSuccessAdd(state.tab);
          }
        },
        buildWhen: (prev, next) => next is ProductsInitial,
        builder: (context, state) {
          if (state is ProductsInitial) {
            return CupertinoPageScaffold(
              navigationBar: DialogTitle(
                text: context.t.mobileScreens.productAdd.title,
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    ProductSelector(
                      selectedTab: selectedTab,
                      onTabChanged: (tab) {
                        setState(() {
                          selectedTab = tab;
                        });
                      },
                    ),
                    if (selectedTab == ProductsTab.accounts)
                      AccountForm(
                        accountsList: state.accountsList,
                        scrollController: widget.scrollController,
                        params: state.accountParams,
                        onSaved: _onFormSaved,
                      ),
                    if (selectedTab == ProductsTab.cards)
                      CardForm(
                        scrollController: widget.scrollController,
                        params: state.cardParams,
                        onSaved: _onFormSaved,
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  void _onFormSaved(List<MdomResponseParam> params) {
    context
        .read<ProductsBloc>()
        .add(ProductsAdd(tab: selectedTab, params: params));
  }

  void _productSuccessAdd(ProductsTab tab) {
    Navigation.navigatorKey.currentState?.pop();
    Multiplatform.showMessage(
        context: context,
        title: t.mobileScreens.productAdd.modal.success.title,
        message: tab == ProductsTab.accounts
            ? t.mobileScreens.productAdd.modal.success.message.account
            : t.mobileScreens.productAdd.modal.success.message.card,
        type: DialogType.success);
  }
}
