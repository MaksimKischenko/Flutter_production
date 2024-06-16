import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/web_constrained_box.dart';
import 'widgets/widgets.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'service_qr_screen_body');

class ServiceQrScreenBody extends StatefulWidget {
  const ServiceQrScreenBody({super.key});

  @override
  State<ServiceQrScreenBody> createState() => _ServiceQrScreenBodyState();
}

class _ServiceQrScreenBodyState extends State<ServiceQrScreenBody> {

  double get _qrFrameSize => 230;

  @override
  Widget build(BuildContext context) =>
      // String appSignatureID = '';
      WebConstrainedBox(
        child: BlocConsumer<QrRequestBloc, QrRequestState>(
          listener: (context, state) {
            if (state is QrRequestErrorKomplat) {
              final isTokenError = state.errorCode == 403;

              if (!isTokenError) {
                if (state.errorCode == 403) {
                  context.read<QrRequestBloc>().add(GetSecretKeyRequestRun());
                } else {
                  RequestUtil.catchKomplatError(
                    context: context,
                    errorCode: state.errorCode,
                    errorText: state.errorMessage,
                  );
                }
              }
              if (isTokenError) {
                // Future<void>.delayed(const Duration(seconds: 1),
                //     () => Navigation.navigatorKey.currentState?.pop());
                Multiplatform.onExpiredTokenScreenLock(context);
              }
            } else if (state is QrRequestError) {
              Multiplatform.showMessage(
                context: context,
                title: context.t.mobileScreens.qrPayment.error,
                message: state.error
                    .toString()
                    .substring(11, state.error.toString().length),
                type: DialogType.error,
              );
            } else if (state is QrRequestTriggerStatus) {
              BlocProvider.of<QrRequestStatusBloc>(context).add(
                GetRequestStatusRequestRun(
                  bankSumLimit: state.bankSumLimit,
                  requestId: state.requestId,
                  continueStatusCheck: true,
                ),
              );
            }
          },
          builder: (BuildContext context, QrRequestState state) {
            Widget body = Container();
            if (state is QrRequestLoading) {
              body = const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingIndicator(),
                ],
              );
            }
            if (state is GetQrRequestLoaded) {
              body = LoadedQrBodyWidget(
                qrFrameSize: _qrFrameSize,
                state: state,
              );
            }
            if (state is QrRequestConfirmQrChangeUiAfterStatusSuccess) {
              body = Column(
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/qr_pay.svg',
                        width: 220,
                        height: 220,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  PinFieldWidget(
                    state: state,
                    qrFrameSize: _qrFrameSize,
                  ),
                  const SizedBox(height: 6),
                ],
              );
            }

            if (state is QrRequestInitial) {
              body = Column(
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: Center(
                      child: Image.asset(
                        'assets/images/qr_pay.png',
                        fit: BoxFit.fill,
                        width: 220,
                        height: 220,
                      )
                    ),
                  ),
                ],
              );
            }
            if (state is QrRequestCancelSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Multiplatform.showMessage(
                  context: context,
                  title: context.t.mobileScreens.qrPayment.qrPaymentTitle,
                  message:
                      context.t.mobileScreens.qrPayment.paymentCanceledDialog,
                  type: DialogType.success,
                ),
              );
            }
            return SafeArea(
              child: Stack(
                children: [
                  const Positioned(
                    top: 10,
                    right: 1,
                    child: QrHistoryNavigationButton(),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        body,
                        if (state.isPinFieldVisible) ...[
                          // const Spacer(),
                          // PinFieldWidget(
                          //   state: state,
                          //   qrFrameSize: _qrFrameSize,
                          // ),
                          // const SizedBox(height: 6),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 48,
                            child: ActionButton(
                              fontSize: 14,
                              title: context
                                  .t.mobileScreens.qrPayment.cancelButtonTitle,
                              onTap: () async {
                                if (state is GetQrRequestLoaded ||
                                    state
                                        is QrRequestConfirmQrChangeUiAfterStatusSuccess) {
                                  // _log('code formed in $_currentCode');
                                  BlocProvider.of<QrRequestStatusBloc>(context)
                                      .closeTimer();

                                  BlocProvider.of<QrRequestBloc>(context).add(
                                    CancelQrPaymentRequestRun(
                                      requestId: state.requestId,
                                      code: '',
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                        if (state is QrRequestInitial) ...[
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 56,
                            child: ActionButton(
                              title: context
                                  .t.mobileScreens.qrPayment.p2PPaymentButton,
                              //  context.t.mobileScreens.qrPayment.generateQrButton,
                              onTap: () async {
                                await showDialog<void>(
                                  context: context,
                                  builder: (context) =>
                                      const P2PTransferDialogWidget(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 56,
                            child: ActionButton(
                              title: context
                                  .t.mobileScreens.qrPayment.generateQrButton,
                              onTap: () async {
                                await Future(() {
                                  BlocProvider.of<QrRequestBloc>(context)
                                      .add(const GetQrRequestRun());
                                });
                              },
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
}
