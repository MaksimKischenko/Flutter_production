import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/navigation.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/screens/claims/widgets/widgets.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/utils.dart';
import 'package:isc_web_app/widgets/widgets.dart';

@RoutePage()
class ClaimsScreen extends StatefulWidget {
  static const pageRoute = '/claims';

  const ClaimsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ClaimsScreenState createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  late ScrollController scrollController;

  ClaimsFilterData? loadFilters;

  List<Claim> _claimsList = [];
  bool get isListEmpty => _claimsList.isEmpty;
  bool isLoadMoreAvailable = true;

  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
      if (currentAuthState is AuthAuthorized) {
        WidgetsBinding.instance.addPostFrameCallback(
        (_) => _onLoad());   
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          WidgetsBinding.instance.addPostFrameCallback(
          (_) => _onLoad());   
        }
      });
    }
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ClaimsBloc, ClaimsState>(
        listener: (context, state) {
          if (state is ClaimsInitial) {
            loadFilters = state.filter;
          } else if (state is ClaimsError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is ClaimsErrorKomplat) {
            RequestUtil.catchKomplatError(
              context: context,
              errorCode: state.errorCode,
              errorText: state.errorMessage,
            );
            if (state.errorCode == 119) {
              Future.delayed(
                const Duration(seconds: 2),
                () => AutoRouter.of(context).push(AuthRoute()),
              );
            }
          } else if (state is ClaimsSuccessLoad) {
            _successLoad(state.list);
          } else if (state is ClaimsSuccessLoadMore) {
            isLoadMoreAvailable = state.isLoadMoreAvailable;               
            _successLoadMore(state.list); 
          }
        },
        child: Scaffold(
          backgroundColor: AppStyles.backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const CabinetMenu(selectedIndex: 1),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ClaimsWebTitleWidget(
                    openFilters: _openFilters,
                  ),
                ),
                Expanded(
                  child: ClaimsTable(
                    claims: _claimsList,
                  ),
                ),             
              ],
            ),
          ),
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            if(!isListEmpty && isLoadMoreAvailable)
            SizedBox(
              width: 180,
              child: LoadMoreButton(
                text: 'Загрузить еще',
                onTap: _onLoadMore
              ),
            ) else 
              const SizedBox(height: 40)
          ],          
        ),
      );


  Future<void> _openFilters(ClaimsFilterData currentFilters) async {
    final filters = await Navigation.toClaimsFilters(
      context: context,
      currentFilters: currentFilters,
    );
    if (filters != null && currentFilters != filters) {
      loadFilters = filters;
      _onLoad();
    }
  }

  void _onLoad() {
    context.read<ClaimsBloc>().add(ClaimsLoad(filter: loadFilters ?? ClaimsFilterData.empty()));
  }

  void _onLoadMore() {
    context.read<ClaimsBloc>().add(ClaimsLoadMore(lastClaimId: _claimsList.last.id));
  }


  void _successLoad(List<Claim> list) {
    setState(() {
      _claimsList = List.from(list);
    }); 
  }

  void _successLoadMore(List<Claim> addList) {
    setState(() {
      _claimsList.addAll(addList);
    });
      if(!isLoadMoreAvailable) {
      Multiplatform.showMessage(
        context: context,
        title: 'Успешно',
        message: 'Все требования загружены',
        type: DialogType.success,
      ); 
    }        
  }
}
