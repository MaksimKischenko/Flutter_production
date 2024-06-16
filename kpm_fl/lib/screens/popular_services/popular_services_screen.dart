import 'dart:async';

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/config.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/utils/utils.dart';
import 'package:kpm_fl/widgets/widgets.dart';

import 'widgets/widgets.dart';

class PopularServicesScreen extends StatefulWidget {
  static const pageRoute = '/popular';

  const PopularServicesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularServicesScreen> createState() => _PopularServicesScreenState();
}

class _PopularServicesScreenState extends State<PopularServicesScreen> {
  @override
  void initState() {
    final basket = context.read<BasketBloc>();

    late StreamSubscription<BasketState> basketListener;

    basketListener = basket.stream.listen((state) {
      if (state is BasketOpened) {
        basketListener.cancel();
      }
    });
    //basket.add(BasketInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocListener<BasketBloc, BasketState>(
        listener: (context, state) {
          if (state is BasketError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is BasketErrorKomplat) {
            RequestUtil.catchBackendError(
                context: context,
                request: state.request,
                errorCode: state.errorCode,
                errorText: state.errorText);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                BannerImage(ScreenInfo.of(context).popularServices.logoUrl),
                BannerImage(ScreenInfo.of(context).popularServices.bannerUrl),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<PopularServicesBloc, PopularServicesState>(
                    builder: (context, state) {
                      Widget body = const SizedBox();
                      if (state is PopularServicesLoading) {
                        body = const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text('Загрузка'),
                            // SizedBox(height: 16),
                            LoadingIndicator()
                          ],
                        );
                      } else if (state is PopularServicesLoaded) {
                        body = GridView.builder(
                          itemCount: state.payRecords.length,
                          itemBuilder: (context, index) => PopularServiceItem(
                            item: state.payRecords[index],
                            onNodeTap: Navigation.toServices,
                            onServiceTap: Navigation.toService,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 6 / 3,
                          ),
                        );
                      } else if (state is PopularServicesError) {
                        body = PageError(
                            message: RequestUtil.kNetworkError,
                            showBottomBar: false,
                            onRepeatTap: () => context
                                .read<PopularServicesBloc>()
                                .add(PopularServicesInit()));
                      } else if (state is PopularServicesErrorKomplat) {
                        body = PageError(
                            message: state.errorText ?? 'Неизвестная ошибка',
                            showBottomBar: false,
                            onRepeatTap: () => context
                                .read<PopularServicesBloc>()
                                .add(PopularServicesInit()));
                      }
                      return body;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // menu
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: BlocBuilder<BasketBloc, BasketState>(
                          builder: (context, state) {
                            final child = GradientButton(
                              onTap: _onBasketTap,
                              gradientColors: AppStyles.buttonGradientColorsRed,
                              child: Text(ScreenInfo.of(context)
                                  .popularServices
                                  .basketButtonLabel),
                            );
                            if (state is BasketOpened) {
                              if (state.payments.isEmpty) return child;
                              return badge.Badge(
                                toAnimate: false,
                                badgeContent: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    '${state.payments.length}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 28),
                                  ),
                                ),
                                position:
                                    badge.BadgePosition.topEnd(top: -24, end: -12),
                                stackFit: StackFit.expand,
                                child: child,
                              );
                            } else {
                              return child;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: GradientButton(
                        onTap: _onAllServicesTap,
                        gradientColors: AppStyles.buttonGradientColorsOrange,
                        child: Text(ScreenInfo.of(context)
                            .popularServices
                            .allServicesButtonLabel),
                        // child: Text(),
                      )),
                      const SizedBox(width: 16),
                      Expanded(
                          child: GradientButton(
                        onTap: _onInfoTap,
                        child: Text(ScreenInfo.of(context)
                            .popularServices
                            .infoButtonLabel),
                      )),
                      const SizedBox(width: 16),
                      // _button('Оферта'),
                      // const SizedBox(width: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );

  void _onBasketTap() {
    Navigation.toBasket();
    // context.read<CheckConnectionBloc>().add(CheckConnectionInit());
  }

  void _onAllServicesTap() {
    Navigation.toServices(AppConfig.allServicesCode);
  }

  void _onInfoTap() {
    Navigation.toInfo();
  }
}
