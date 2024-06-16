import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class ProductAddScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/products_add');

  static const pageRoute = '/products/add';

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  ProductsTab selectedTab = ProductsTab.accounts;
  final GlobalKey<AccountFormState> _accountSaveState = GlobalKey();
  final GlobalKey<CardFormState> _cardSaveState = GlobalKey();

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsSuccessAdd) {
            _productSuccessAdd(state.tab);
          }
        },
        //buildWhen: (prev, next) => next is ProductsInitial,
        builder: (context, state) {
          if (state is ProductsInitial) {
            return Scaffold(
              appBar: AppBar(
                  title: const CabinetMenu(selectedIndex: 1),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
                  child: SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 720,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () => AutoRouter.of(context)
                                        .popAndPush(const ProductsRoute()),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 20,
                                      color: AppStyles.mainColor,
                                    )),
                                const SizedBox(width: 24),
                                Expanded(
                                    child: PageTitle(
                                        text: context.t.mobileScreens.products
                                            .addButton)),
                              ],
                            ),
                            const SizedBox(height: 40),
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
                                key: _accountSaveState,
                                selectedTab: selectedTab,
                                params: state.accountParams,
                              ),
                            if (selectedTab == ProductsTab.cards)
                              CardForm(
                                key: _cardSaveState,
                                selectedTab: selectedTab,
                                params: state.cardParams,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              persistentFooterAlignment: AlignmentDirectional.center,
              persistentFooterButtons: [
                if (selectedTab == ProductsTab.accounts)
                  SizedBox(
                    width: 200,
                    child: CreateButton(
                        text: context
                            .t.mobileScreens.productAdd.accountForm.addButton,
                        onTap: () {
                          _accountSaveState.currentState?.onSaveTap();
                        }),
                  ),
                if (selectedTab == ProductsTab.cards)
                  SizedBox(
                    width: 200,
                    child: CreateButton(
                        text: context
                            .t.mobileScreens.productAdd.cardForm.addButton,
                        onTap: () {
                          _cardSaveState.currentState?.onSaveTap();
                        }),
                  )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  void _productSuccessAdd(ProductsTab tab) {
    AutoRouter.of(context).navigatorKey.currentState?.pop();
    Multiplatform.showMessage(
        context: context,
        title: t.mobileScreens.productAdd.modal.success.title,
        message: tab == ProductsTab.accounts
            ? t.mobileScreens.productAdd.modal.success.message.account
            : t.mobileScreens.productAdd.modal.success.message.card,
        type: DialogType.success);
  }
}
