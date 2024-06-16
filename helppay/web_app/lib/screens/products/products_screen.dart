import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class ProductsScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/products');

  static const pageRoute = '/products';

  const ProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductsTab selectedTab = ProductsTab.accounts;

  @override
  Widget build(BuildContext context) => BlocListener<ProductsBloc,
          ProductsState>(
      listener: (context, state) {
        if (state is ProductsError) {
          RequestUtil.catchNetworkError(context: context, obj: state.error);
        } if (state is ProductsBalanceLoaded) {
            Multiplatform.showMessage(
              context: context,
              title: 'Баланс', 
              message:
                  'Баланс карты ${state.balance?.amount ?? 'отсутствует'}',
              type: DialogType.success,
            );
          }
        if (state is ProductsErrorKomplat) {
          RequestUtil.catchKomplatError(
              context: context,
              errorCode: state.errorCode,
              errorText: state.errorMessage);
          if (state.errorCode == 403) {
            Future.delayed(const Duration(seconds: 2),
                () async => await AutoRouter.of(context).replace(AuthRoute()));
          }
        }
      },
      child: Scaffold(
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
                      Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PageTitle(
                                  text: context.t.mobileScreens.products.title),
                              NoSplashButton(
                                onTap: () => AutoRouter.of(context)
                                    .push(const ProductAddRoute()),
                                text: context.t.mobileScreens.productAdd.title,
                              ),
                            ],
                          )),
                      const SizedBox(height: 40),
                      ProductsSegmentControl(
                        selectedTab: selectedTab,
                        onTabChanged: (tab) {
                          setState(() {
                            selectedTab = tab;
                          });
                        },
                      ),
                      if (selectedTab == ProductsTab.accounts)
                        AccountsList(
                          onTap: _onAccountTap,
                        )
                      else
                        CardsList(
                          onTap: _onCardTap,
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ));

  void _onCardTap(MdomLoginResponseProductsCurrent card) {
    AutoRouter.of(context).push(CardInfoRoute(card: card));
  }

  void _onAccountTap(MdomLoginResponseProductsCurrent account) {
    AutoRouter.of(context).push(AccountInfoRoute(account: account));
  }
}
