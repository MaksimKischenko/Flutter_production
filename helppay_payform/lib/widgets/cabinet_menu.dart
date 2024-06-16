import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'widgets.dart';

List<CabinetMenuItem> _menuItems = [
  CabinetMenuItem(
    onTap: () {}, //Navigation.toPopularServices
    icon: CupertinoIcons.home,
    text: 'Главная',
    controlledItem: MenuAvailableItem.popular,
  ),
  // const MenuItem(
  //   onTap: Navigation.toPopularServices,
  //   icon: CupertinoIcons.star_fill,
  //   text: 'Популярные услуги',
  //   controlledItem: MenuAvailableItem.popular
  // ),
  // const MenuItem(
  //   onTap: Navigation.toAllServices,
  //   icon: CupertinoIcons.list_bullet_indent,
  //   text: 'Все услуги',
  //   controlledItem: MenuAvailableItem.all
  // ),
  // MenuItem(
  //   onTap: () => Navigation.navigatorKey.currentState?.pushNamed('/service?code=430000381861'),
  //   icon: CupertinoIcons.tickets,
  //   text: 'Тестовая услуга',
  //   controlledItem: MenuAvailableItem.test
  // ),
];

class CabinetMenu extends StatefulWidget {
  final MenuAvailableItem? selected;

  const CabinetMenu({this.selected});

  @override
  State<CabinetMenu> createState() => _CabinetMenuState();
}

class _CabinetMenuState extends State<CabinetMenu> {
  bool _smallMenuExpanded = false;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                // color: const Color(0xfff7f7f9),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset.zero,
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ]
                // border: Border(
                //   bottom: BorderSide(
                //     color: Colors.grey[300]!
                //   )
                // )
                ),
            child: Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  // onTap: Navigation.toPopularServices,
                  child: Image.asset(
                    'assets/img/logo.jpg',
                    height: 26,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: ResponsiveBuilder(
                    builder: (context, sizingInformation) {
                      if (sizingInformation.screenSize.width < 768) {
                        // small
                        return Row(
                          children: [
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _smallMenuExpanded = !_smallMenuExpanded;
                                });
                              },
                              icon: const Icon(
                                Icons.menu_rounded,
                                size: 32,
                                color: AppStyles.mainColor,
                              ),
                            ),
                          ],
                        );
                      } else {
                        // normal
                        return Row(
                          children: [
                            ..._menuItems.map(
                              (e) => CabinetMenuWidget(
                                selected: widget.selected == e.controlledItem,
                                onTap: e.onTap,
                                icon: e.icon,
                                text: e.text,
                              ),
                            ),
                            const Spacer(),
                            // remaining amount
                            _remainingAmountWidget(),
                            const SizedBox(width: 16),
                            // basket
                            InkWell(
                              onTap:
                                  widget.selected == MenuAvailableItem.payments
                                      ? null
                                      : Navigation.toPayments,
                              child: Tooltip(
                                message: 'Платежи',
                                child: SizedBox(
                                  width: 70,
                                  height: 70,
                                  child:
                                      BlocBuilder<PaymentsBloc, PaymentsState>(
                                    builder: (context, state) {
                                      if (state is PaymentsInitial) {
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const Icon(
                                              Icons.shopping_basket_outlined,
                                              size: 32,
                                              color: AppStyles.mainColor,
                                            ),
                                            if (state.payments.isNotEmpty)
                                              Positioned(
                                                top: 4,
                                                left: 42,
                                                // right: 6,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  // alignment: Alignment.topRight,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffF0351F),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)
                                                      // shape: BoxShape.circle
                                                      ),
                                                  child: Text(
                                                    // '12',
                                                    '${state.payments.length}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // letterSpacing: -0.2
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (widget.selected ==
                                                MenuAvailableItem.payments)
                                              Positioned.fill(
                                                top: 66,
                                                left: 16,
                                                right: 16,
                                                child: Container(
                                                  width: double.maxFinite,
                                                  decoration:
                                                      const BoxDecoration(
                                                    // color: Colors.black,
                                                    color: AppStyles.mainColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5),
                                                    ),
                                                  ),
                                                  // height: 4,
                                                ),
                                              ),
                                          ],
                                        );
                                      } else {
                                        return const UnconstrainedBox(
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: LoadingIndicator(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_smallMenuExpanded)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.symmetric(
                      horizontal: BorderSide(
                    color: AppStyles.mainColor.withOpacity(0.1),
                    width: 2,
                  ))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._menuItems.map(
                      (e) => CabinetMenuSmallWidget(
                        selected: widget.selected == e.controlledItem,
                        onTap: e.onTap,
                        icon: e.icon,
                        text: e.text,
                      ),
                    ),
                    // payments
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: InkWell(
                        onTap: widget.selected == MenuAvailableItem.payments
                            ? null
                            : Navigation.toPayments,
                        child: Tooltip(
                          message: 'Платежи',
                          child: BlocBuilder<PaymentsBloc, PaymentsState>(
                            builder: (context, state) {
                              if (state is PaymentsInitial) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.selected ==
                                                MenuAvailableItem.payments
                                            ? AppStyles.mainColor
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // const Icon(
                                    //   Icons.shopping_basket_outlined,
                                    //   size: 32,
                                    //   color: AppStyles.mainColor,
                                    // ),
                                    Text(
                                      'Платежи',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: widget.selected ==
                                                MenuAvailableItem.payments
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                        color: AppStyles.mainTextColor,
                                      ),
                                    ),
                                    if (state.payments.isNotEmpty)
                                      Container(
                                        margin: const EdgeInsets.only(left: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        // alignment: Alignment.topRight,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF0351F),
                                            borderRadius:
                                                BorderRadius.circular(4)
                                            // shape: BoxShape.circle
                                            ),
                                        child: Text(
                                          '${state.payments.length}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            // letterSpacing: -0.2
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              } else {
                                return const UnconstrainedBox(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: LoadingIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    // remaining amount
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: _remainingAmountWidget(),
                    ),
                  ]),
            )
        ],
      );

  Widget _remainingAmountWidget() =>
      BlocBuilder<PaymentsBloc, PaymentsState>(builder: (context, state) {
        if (state is PaymentsInitial) {
          return RichText(
            text: TextSpan(
                text: 'Баланс: ',
                style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.6),
                    fontSize: 16),
                children: [
                  TextSpan(
                      text:
                          '${state.remainingAmount} ${AppConfig.mapCurrencyToName[AppConfig.defaultCurrency]}',
                      style: const TextStyle(
                          color: AppStyles.mainTextColor,
                          fontWeight: FontWeight.bold))
                ]),
          );
        } else {
          return Container();
        }
      });
}
