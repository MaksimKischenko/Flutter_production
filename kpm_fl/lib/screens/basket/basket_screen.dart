import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/screens/basket/widgets/widgets.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/widgets/widgets.dart';

class BasketScreen extends StatefulWidget {
  static const pageRoute = '/basket';

  const BasketScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) => BlocListener<BasketBloc, BasketState>(
    listener: (context, state) {
      if (state is BasketClosed) {
        if (state.barcode != null && state.kioskReceipt != null) {
          Navigation.toCheck(
            kioskReceipt: state.kioskReceipt!,
            barcode: state.barcode!,
          );
        }
      }
    },
    child: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BannerImage(ScreenInfo.of(context).basket.logoUrl),
            const SizedBox(height: 16),
            PageTitle(ScreenInfo.of(context).basket.title),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  Widget? body;
                  if (state is BasketOpened) {
                    if (state.payments.isEmpty) {
                      body = const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: double.maxFinite),
                          Text('Платежей в корзине нет')
                        ],
                      );
                    } else {
                      body = ListView.separated(
                        itemBuilder: (context, index) => BasketItem(
                          item: state.payments[index],
                          onDelete: _onDeletePaymentTap,
                        ),
                        // separatorBuilder: (context, _) => const Divider(),
                        separatorBuilder: (context, _) => const SizedBox(height: 24),
                        itemCount: state.payments.length,
                      );
                    }
                  } else if (state is BasketClosed) {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        Text('Платежей в корзине нет')
                      ],
                    );
                  } else {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        LoadingIndicator()
                      ],
                    );
                  }

                  // return Text(state.toString());
                  return body;
                },
              ),
            ),
            const SizedBox(height: 16),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<BasketBloc, BasketState>(
                    builder: (context, state) {
                      if (state is BasketOpened) {
                        if (state.payments.isNotEmpty) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: GradientButton(
                                onTap: _onPayBasketTap,
                                gradientColors: const [
                                  CupertinoColors.systemGreen,
                                  CupertinoColors.systemGreen,
                                ],
                                child: Text(ScreenInfo.of(context).basket.payBasketButtonLabel),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();  
                        }
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GradientButton(
                      onTap: _onAddPaymentTap,
                      gradientColors: const [
                        AppStyles.mainColor,
                        AppStyles.mainColor
                      ],
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.add_circled,
                            color: CupertinoColors.systemGreen,
                            size: 32,
                          ),
                          const SizedBox(width: 4),
                          Expanded(child: Text(ScreenInfo.of(context).basket.addPaymentButtonLabel)),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<BasketBloc, BasketState>(
                    builder: (context, state) {
                      if (state is BasketOpened) {
                        if (state.payments.isNotEmpty) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: GradientButton(
                                onTap: _onClearBasketTap,
                                gradientColors: AppStyles.buttonGradientColorsOrange,
                                child: Text(ScreenInfo.of(context).basket.clearBasketButton),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();  
                        }
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      )
    ),
  );

  void _onPayBasketTap() {
    context.read<BasketBloc>().add(BasketClose());
  }

  void _onAddPaymentTap() {
    Navigation.toPopularServices();
  }

  void _onClearBasketTap() {
    context.read<BasketBloc>().add(BasketDeleteAllPayments());
  }

  void _onDeletePaymentTap(
    PayRecordResponse item
  ) {
    context.read<BasketBloc>().add(BasketDeletePayment(item));
  }
}