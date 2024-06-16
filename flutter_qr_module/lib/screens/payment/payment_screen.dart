import 'package:fl_qr_module/blocs/payment/payment_bloc.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/utils/utils.dart';
import 'package:fl_qr_module/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  final ScrollController scrollController;
  final QrEripData data;

  PaymentScreen({required this.data, required this.scrollController});

  PaymentState? lastVisible;

  @override
  Widget build(BuildContext context) => BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentErrorDialog) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is PaymentErrorKomplatDialog) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
          }
        },
        buildWhen: (prev, curr) {
          if (lastVisible is PaymentInputFields && curr is PaymentLoading) {
            return false;
          }
          if (curr is PaymentErrorDialog || curr is PaymentErrorKomplatDialog) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          lastVisible = state;
          Widget body = Container();

          if (state is PaymentLoading) {
            body = LoadingWidget();
          }
          if (state is PaymentError) {
            body = Error(context,
                message: state.error.toString(),
                onRepeatTap: () =>
                    context.read<PaymentBloc>().add(PaymentGetInfo(data)));
          }
          if (state is PaymentErrorKomplat) {
            body = Error(context,
                message: state.errorMessage ??
                    context.t.mobileScreens.payment.errorMessage,
                onRepeatTap: () =>
                    context.read<PaymentBloc>().add(PaymentGetInfo(data)));
          }
          if (state is PaymentAdditionInfo) {
            body = AdditionInfoPage(
              scrollController: scrollController,
              data: data,
            );
          }
          if (state is PaymentInputFields) {
            body = FieldsPage(
              scrollController: scrollController,
              payCode: state.payCode,
              service: state.service,
              finishedAttrs: state.finishedAttrs,
              qrSum: data.sum,
            );
          }
          if (state is PaymentResult) {
            body = ServiceResultPage(
              scrollController: scrollController,
              service: state.service,
              lastAttrs: state.lastAttrs,
              finishedAttrs: state.finishedAttrs,
            );
          }
          if (state is PaymentCheckInitial) {
            body = PaymentreceiptView(
              service: state.service!,
              checkBody: state.checkBody,
            );
          }
          if (state is PaymentSkipInputAndConfirmation) {
            context.read<PaymentBloc>().add(PaymentRunOperation(
                service: state.service, attrs: state.attrs));
          }
          return SafeArea(child: body);
        },
      );
}
