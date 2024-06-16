import 'dart:async';

import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/models/models.dart';
import 'package:fl_qr_module/screens/mdom_qr/service_qr_screen_body.dart';
import 'package:fl_qr_module/screens/mdom_qr/widgets/widgets.dart';
import 'package:fl_qr_module/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/web_constrained_box.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'service_qr_screen');

class ServiceQrScreenStatusListener extends StatefulWidget {
  // final QrRequestStatusState requestStatusState;
  const ServiceQrScreenStatusListener({
    super.key,
    // required this.requestStatusState,
  });

  @override
  State<ServiceQrScreenStatusListener> createState() =>
      _ServiceQrScreenStatusListenerState();
}

class _ServiceQrScreenStatusListenerState
    extends State<ServiceQrScreenStatusListener> {
  bool isQrScaned = false;

  Timer? timer;

  double get qrFrameSize => 180;

  @override
  Widget build(BuildContext context) => WebConstrainedBox(
        child: BlocListener<QrRequestStatusBloc, QrRequestStatusState>(
          listener: (context, state) {
            if (state is QrRequestStatusErrorKomplat) {
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
            } else if (state is QrRequestStatusContinueChecking) {
              // BlocProvider.of<QrRequestStatusBloc>(context).add( //This code commented because its triggered creation of Timer second object so its closing was problematic
              //   GetRequestStatusRequestRun(
              //     requestId: state.requestId!,
              //     continueStatusCheck: true,
              //   ),
              // );
            } else if (state is QrRequestStatusError) {
              Multiplatform.showMessage(
                context: context,
                title: context.t.mobileScreens.qrPayment.error,
                message: state.error.toString(),
                type: DialogType.error,
              );
            } else if (state is QrRequestStatusSuccess) {
              BlocProvider.of<QrRequestBloc>(context).add(
                ConfirmQrChangeUiAfterStatusSuccess(
                  requestId: state.requestId!,
                ),
              );
            } else if (state is QrRequestStatusPaymentRequestSuccess) {
              _log('current state $state');
              // _log('showPinFlag -  ${state.showPinWidget}');

              if (!state.showPinWidget) {
                BlocProvider.of<QrRequestBloc>(context).add(
                  const EmitInitialState(),
                );
              }
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Multiplatform.showMessage(
                  context: context,
                  title: context.t.mobileScreens.qrPayment.qrPaymentTitle,
                  message: state.infoMessage,
                  type: DialogType.success,
                  showReceipt: true,
                  onPressed: () =>
                      BlocProvider.of<QrRequestStatusBloc>(context).add(
                    GetCheckDuplicate(requestId: state.requestId),
                  ),
                ),
              );
            } else if (state is SuccessStatusCheckDuplicateLoading) {
            } else if (state is SuccessStatusCheckDuplicateAccuired) {
              _log('current state $state');

              Multiplatform.showScrollableDialog<Widget>(
                context: context,
                builder: (context, controller) =>
                    StatusSuccessTransactionReceipt(
                  state: state,
                ),
              );
            } else if (state is QrRequestStatusFail) {
              BlocProvider.of<QrRequestBloc>(context).add(
                const EmitInitialState(),
              );
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Multiplatform.showMessage(
                  context: context,
                  title: context.t.mobileScreens.qrPayment.qrPaymentTitle,
                  message: state.errorMessage,
                  type: state.errorMessage == 'Отменена регистрация платежа'
                      ? DialogType.info
                      : DialogType.error,
                ),
              );
            }
          },
          child: const ServiceQrScreenBody(),
        ),
      );
}
