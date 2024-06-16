
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  final ScrollController scrollController;
  final QrEripData data;

  PaymentScreen({
    required this.data,
    required this.scrollController
  }) {
    // data.eripCode = "2220000682931";
  }

  PaymentState? lastVisible;

  @override
  Widget build(BuildContext context) => BlocConsumer<PaymentBloc, PaymentState>(
    listener: (context, state) {
      if (state is PaymentErrorDialog) {
        RequestUtil.catchNetworkError(
          context: context,
          obj: state.error
        );
      }
      if (state is PaymentErrorKomplatDialog) {
        RequestUtil.catchKomplatError(
          context: context,
          errorCode: state.errorCode,
          errorText: state.errorMessage
        );
      }
    },
    buildWhen: (prev, curr) {
      if (lastVisible is PaymentInputFields && curr is PaymentLoading) return false;
      if (curr is PaymentErrorDialog ||
            curr is PaymentErrorKomplatDialog) return false;
      return true;
    },
    // buildWhen: (prev, curr) {
    //   bool ret = true;
    //   if (prev is PaymentInputFields && curr is PaymentLoading) ret = false;
    //   print("prev: $prev, curr: $curr, build? $ret");
    //   return ret;
    // },
    builder: (context, state) {
      lastVisible = state;
      Widget body = Container();
      
      if (state is PaymentLoading) {
        body = LoadingWidget();
      }
      if (state is PaymentError) {
        body = Error(
          context,
          message: state.error.toString(),
          onRepeatTap: () => context.read<PaymentBloc>().add(PaymentGetInfo(data))
        );
      }
      if (state is PaymentErrorKomplat) {
        body = Error(
          context,
          message: state.errorMessage ?? context.t.mobileScreens.payment.errorMessage,
          onRepeatTap: () => context.read<PaymentBloc>().add(PaymentGetInfo(data))
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

      return SafeArea(child: body);
    },
  );
}