import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/models/models.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/utils/utils.dart';
import 'package:kpm_fl/widgets/widgets.dart';

import 'widgets/widgets.dart';

class ServiceScreen extends StatefulWidget {
  static const pageRoute = '/service';

  final int code;

  const ServiceScreen({
    required this.code
  });

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentBloc>().add(PaymentGetInfo(widget.code));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          BlocBuilder<PaymentBloc, PaymentState>(
            buildWhen: (prev, next) {
              if (next is PaymentErrorDialog) return false;
              if (next is PaymentErrorKomplatDialog) return false;
              if (next is PaymentLoading) return false;
              if (next is PaymentError) return false;
              if (next is PaymentErrorKomplat) return false;
              return true;
            },
            builder: (context, state) {
              Widget? body;
              if (state is PaymentInputFields) {
                body = BannerImage(ScreenInfo.of(context).service.attrsStep.logoUrl);
              } else if (state is PaymentResult) {
                body = BannerImage(ScreenInfo.of(context).service.resultStep.logoUrl);
              }
              return body ?? const SizedBox();
            }
          ),
          Expanded(
            child: BlocConsumer<PaymentBloc, PaymentState>(
              listener: (context, state) {
                if (state is PaymentErrorDialog) {
                  RequestUtil.catchNetworkError(
                    context: context,
                    obj: state.error
                  );
                } else if (state is PaymentErrorKomplatDialog) {
                  RequestUtil.catchBackendError(
                    context: context,
                    request: state.request,
                    errorCode: state.errorCode,
                    errorText: state.errorText,
                    onError: (errorCode) => _onError(errorCode: errorCode),
                  );
                } else if (state is PaymentSuccess) {
                  context.read<BasketBloc>().add(BasketAddPayment(BasketItemWrapper(
                    payment: state.payment,
                    serviceName: state.serviceName,
                    accNumName: state.accNumName
                  )));
                  Navigation.toBasket();
                }
              },
              builder: (context, state) {
                Widget body = Container();

                if (state is PaymentLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: double.maxFinite),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is PaymentInputFields) {
                  final parent = state.service.groupRecord?.name ?? 'Узел ${state.service.groupRecord?.code}';
                  final name = state.service.name ?? 'Услуга ${state.service.code}';
                  final title = '$parent -> $name';
                  body = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: double.maxFinite),
                      const SizedBox(height: 32), 
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PageTitle(title),
                      ),
                      const SizedBox(height: 32),
                      Expanded(
                        child: FieldsPage(
                          key: Key(state.service.sessionId ?? '-1'),
                          payCode: state.payCode,
                          service: state.service,
                          finishedAttrs: state.finishedAttrs,
                          properties: state.properties,
                        ),
                      ),
                    ],
                  );
                } else if (state is PaymentResult) {
                  body = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: double.maxFinite),
                      const SizedBox(height: 32), 
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PageTitle(ScreenInfo.of(context).service.resultStep.title),
                      ),
                      const SizedBox(height: 32),
                      Expanded(
                        child: ServiceResultPage(
                          service: state.service,
                          lastAttrs: state.lastAttrs,
                          finishedAttrs: state.finishedAttrs,
                        ),
                      ),
                    ],
                  );
                } else if (state is PaymentError) {
                  body = PageError(
                    message: state.error.toString(),
                    onRepeatTap: () => context.read<PaymentBloc>().add(PaymentGetInfo(widget.code)),
                  );
                } else if (state is PaymentErrorKomplat) {
                  body = PageError(
                    message: state.errorText ?? 'Неизвестная ошибка',
                    onRepeatTap: () => context.read<PaymentBloc>().add(PaymentGetInfo(widget.code)),
                  );
                }
                return body;
              },
            ),
          ),
        ],
      ),
    )
  );

  void _onError({required int? errorCode}) {
    if(errorCode == ErrorCodeType.incorrectTel.codeNumber) {
      Navigation.toPopularServices();
    }
  }
}