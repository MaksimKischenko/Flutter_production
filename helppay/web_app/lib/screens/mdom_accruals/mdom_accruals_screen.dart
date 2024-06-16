import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/navigation.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class MdomAccrualsScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/accruals');

  static const pageRoute = '/accruals';

  const MdomAccrualsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MdomAccrualsScreenState createState() => _MdomAccrualsScreenState();
}

class _MdomAccrualsScreenState extends State<MdomAccrualsScreen> {
  List<CompaniesResponseCompany> _companiesList = [];
  bool get isListEmpty => _companiesList.isEmpty;

  // @override
  // void initState() {
  //   super.initState();
  //   final currentAuthState = context.read<AuthBloc>().state;
  //     if (currentAuthState is AuthAuthorized) {
  //     _onLoadAccruals();
  //   } else {
  //     context.read<AuthBloc>().stream.listen((authState) {
  //       if (authState is AuthAuthorized) {
  //         _onLoadAccruals();
  //       }
  //     });
  //   }
  //   WidgetsBinding.instance.addPostFrameCallback(
  //       (_) => context.read<MdomAccrualsBloc>().add(MdomAccrualsCheckLoaded()));
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CabinetMenu(selectedIndex: 0),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: BlocListener<MdomAccrualsBloc, MdomAccrualsState>(
          listener: (context, state) {
            if (state is MdomAccrualsError) {
              RequestUtil.catchNetworkError(context: context, obj: state.error);
            } else if (state is MdomAccrualsErrorKomplat) {
              if ((state.errorCode != 201) && (state.errorCode != 403)) {
                RequestUtil.catchKomplatError(
                  context: context,
                  errorCode: state.errorCode,
                  errorText: state.errorMessage,
                );
              } else if (state.errorCode == 403) {
                Future.delayed(
                    const Duration(seconds: 2),
                    () => AutoRouter.of(context).pushAndPopUntil(AuthRoute(),
                        predicate: (route) => false));
              } else {
                setState(() {
                  _companiesList = [];
                });

                // _catchErrorToRefreshController();

                Multiplatform.showMessage(
                  context: context,
                  title: t.exceptions.emtyOrganizationsList,
                  message: state.errorMessage,
                  type: DialogType.info,
                );
              }
            } else if (state is MdomAccrualsLoaded) {
              _successLoad(state.companies);
            } else if (state is MdomAccrualsToggleRefresh) {
              context.read<MdomAccrualsBloc>().add(MdomAccrualsInit());
            }
          },
          child: SafeArea(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PageTitle(
                                text:
                                    context.t.mobileScreens.mdomAccruals.title),
                            NoSplashButton(
                              onTap: _onAddAccountTap,
                              text: context.t.mobileScreens.productAdd
                                  .accountForm.addButton,
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        AccountsList(
                          companies: _companiesList,
                          onTap: _onAccountTap,
                          onPollTap: _onPollTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onAddAccountTap() {
    Navigation.toMdomAccountAdd(context: context);
  }

  void _onAccountTap(
      int supplierId, PropertyAccount account, String supplierTitle) {
    AutoRouter.of(context).push(MdomAccountInfoRoute(
        supplierId: supplierId,
        account: account,
        supplierTitle: supplierTitle));
  }

  void _onPollTap(int supplierId, int accountsCount, String supplierTitle) {
    AutoRouter.of(context).push(
      MdomPollsListRoute(
        supplierId: supplierId,
        accountsCount: accountsCount,
        supplierTitle: supplierTitle,
      ),
    );
  }

  void _successLoad(List<CompaniesResponseCompany> companies) {
    setState(() {
      _companiesList = List.from(companies);
    });
  }
}
