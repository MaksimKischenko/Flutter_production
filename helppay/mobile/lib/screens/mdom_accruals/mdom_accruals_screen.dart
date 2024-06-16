import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/widgets.dart';

class MdomAccrualsScreen extends StatefulWidget {
  static const pageRoute = '/accruals';

  const MdomAccrualsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MdomAccrualsScreenState createState() => _MdomAccrualsScreenState();
}

class _MdomAccrualsScreenState extends State<MdomAccrualsScreen> {
  late ScrollController _scrollController;

  var _isVisible = true;

  RefreshController refreshController = RefreshController(
    initialRefresh: CoreConfig.appFlavour == AppFlavour.mdom,
  );

  List<CompaniesResponseCompany> _companiesList = [];
  bool get isListEmpty => _companiesList.isEmpty;

  final GlobalKey _titleKey = GlobalKey();

  double get titleSize => 40;
  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    if (CoreConfig.appFlavour == AppFlavour.full) {
      _scrollController.addListener(() {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible) {
            _isVisible = false;
            context.read<MenuBloc>().add(MenuHide());
          }
        }
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isVisible) {
            _isVisible = true;
            context.read<MenuBloc>().add(MenuShow());
          }
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<MdomAccrualsBloc>().add(MdomAccrualsCheckLoaded()));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leadingWidth: 130,
          leading: Row(
            children: [
              if (CoreConfig.appFlavour == AppFlavour.mdom)
                IconButton(
                    onPressed: _onProfileTap,
                    icon: SvgPicture.asset(
                        'assets/icon/mdom_accruals_profile_icon.svg')),
            ],
          ),
          title: _showTitle
              ? Text(
                  context.t.mobileScreens.mdomAccruals.title,
                  style: const TextStyle(
                    color: AppStyles.mainColorDark,
                  ),
                )
              : null,
          backgroundColor: Colors.transparent,
          actions: [
            AddButton(
              onPressed: _onAddAccountTap,
            )
          ],
        ),
        body: BlocListener<MdomAccrualsBloc, MdomAccrualsState>(
          listener: (context, state) {
            if (state is MdomAccrualsError) {
              _catchErrorToRefreshController();
            } else if (state is MdomAccrualsErrorKomplat) {
              final isTokenError = state.errorCode == 403;
              _catchErrorToRefreshController();
              if ((state.errorCode != 201) && (state.errorCode != 403)) {
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
              } else {
                setState(() {
                  _companiesList = [];
                });

                _catchErrorToRefreshController();

                // Multiplatform.showMessage(
                //   context: context,
                //   title: t.exceptions.emtyOrganizationsList,
                //   message: state.errorMessage,
                //   type: DialogType.info,
                // );
              }
            } else if (state is MdomAccrualsLoaded) {
              _successLoad(state.companies);
            } else if (state is MdomAccrualsToggleRefresh) {
              refreshController.requestRefresh();
            }
          },
          child: SmartRefresher(
            // bottomSafe: false,
            scrollController: _scrollController,
            primary: false,
            controller: refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            enablePullUp: false,
            header: const RefreshHeader(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (CoreConfig.appFlavour == AppFlavour.full)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                      child: PageTitle(
                        key: _titleKey,
                        // text: t.screens.accruals.title,
                        text: context.t.mobileScreens.mdomAccruals.title,
                      ),
                    ),
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
      );

  void _onProfileTap() {
    Navigation.toProfile(
      context: context,
      // modal: true
    );
  }

  void _onAddAccountTap() {
    Navigation.toMdomAccountAdd(
      context: context,
    );
  }

  void _onAccountTap(int supplierId, PropertyAccount account) {
    Navigation.toMdomAccountInfo(
      context: context,
      supplierId: supplierId,
      account: account,
    );
  }

  void _onPollTap(int supplierId, int accountsCount, String supplierTitle) {
    Navigation.toMdomPollsList(
      supplierId: supplierId,
      accountsCount: accountsCount,
      supplierTitle: supplierTitle,
    );
  }

  void _onRefresh() {
    context.read<MdomAccrualsBloc>().add(MdomAccrualsInit());
  }

  void _catchErrorToRefreshController() {
    refreshController.refreshFailed();
  }

  void _successLoad(List<CompaniesResponseCompany> companies) {
    refreshController.resetNoData();

    setState(() {
      _companiesList = List.from(companies);
    });

    if (isListEmpty) {
      refreshController.refreshToIdle();
    } else {
      refreshController.refreshCompleted();
    }
  }
}
