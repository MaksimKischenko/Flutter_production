import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'products_screen');

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ScrollController _hideBottomNavController;

  var _isVisible = true;

  ProductsTab selectedTab = ProductsTab.accounts;

  final _titleKey = GlobalKey();

  double get titleSize => 40;
  bool _isTitleVisible = false;

  bool get _showTitle =>
      _hideBottomNavController.hasClients &&
      _hideBottomNavController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();

    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
        if (_hideBottomNavController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible) {
            _isVisible = false;
            context.read<MenuBloc>().add(MenuHide());
          }
        }
        if (_hideBottomNavController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isVisible) {
            _isVisible = true;
            context.read<MenuBloc>().add(MenuShow());
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _hideBottomNavController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is ProductsErrorKomplat) {
              final isTokenError = state.errorCode == 403;
              if (!isTokenError) {
                RequestUtil.catchKomplatError(
                  context: context,
                  errorCode: state.errorCode,
                  errorText: state.errorMessage,
                );
              }
              if (isTokenError) {
                // Future<void>.delayed(const Duration(seconds: 1),
                //     () => Navigation.navigatorKey.currentState?.pop());
                Multiplatform.onExpiredTokenScreenLock(context);
              }
            }
            if (state is ProductsError) {
              RequestUtil.catchNetworkError(context: context, obj: state.error);
            }
            if (state is ProductsBalanceLoaded) {
              _log('balance amount - ${state.balance?.amount}');
              Multiplatform.showMessage(
                context: context,
                title: 'Баланс', //TODO
                message:
                    'Баланс карты ${state.balance?.amount ?? 'отсутствует'}',
                type: DialogType.success,
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: _showTitle
                  ? Text(
                      context.t.mobileScreens.products.title,
                      style: const TextStyle(
                        color: AppStyles.mainColorDark,
                      ),
                    )
                  : null,
              backgroundColor: Colors.transparent,
              actions: [
                AddButton(
                  onPressed: () => Navigation.toProductAdd(
                    context: context,
                  ),
                )
              ],
            ),
            body: FullScreen(
              bottomSafe: false,
              controller: _hideBottomNavController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                    child: PageTitle(
                      key: _titleKey,
                      text: context.t.mobileScreens.products.title,
                    ),
                  ),
                  MainProduct(
                    onAccountTap: _onAccountTap,
                    onCardTap: _onCardTap,
                  ),
                  ProductsSegmentControl(
                    selectedTab: selectedTab,
                    onTabChanged: (tab) {
                      if (!_isVisible) {
                        _isVisible = true;
                        context.read<MenuBloc>().add(MenuShow());
                      }
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
          ));

  void _onCardTap(MdomLoginResponseProductsCurrent card) {
    Navigation.toCardInfo(
      context: context,
      card: card,
    );
  }

  void _onAccountTap(MdomLoginResponseProductsCurrent account) {
    Navigation.toAccountInfo(
      context: context,
      account: account,
    );
  }
}
