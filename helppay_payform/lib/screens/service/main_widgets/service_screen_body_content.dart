import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/main.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/screens/service/main_widgets/service_screen_paiment_input_fields.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

class ServiceScreenBodyContent extends StatefulWidget {
  final int code;
  final String name;
  final bool isDevice;
  final String suplierName;
  bool isHomeButtonActive;

  ServiceScreenBodyContent({
    Key? key,
    required this.code,
    required this.name,
    required this.isDevice,
    required this.isHomeButtonActive,
    required this.suplierName,
  }) : super(key: key);

  @override
  State<ServiceScreenBodyContent> createState() =>
      _ServiceScreenBodyContentState();
}

class _ServiceScreenBodyContentState extends State<ServiceScreenBodyContent> {
  bool firstLoad = true;
  ScrollController serviceScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          Widget mainBody = Container();
          if (state is AuthLoading) {
            mainBody = Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(width: double.maxFinite),
                  LoadingIndicator()
                ],
              ),
            );
          } else if (state is AuthAuthorized) {
            if (firstLoad) {
              context.read<PaymentBloc>().add(PaymentGetInfo(widget.code));
              firstLoad = false;
            }
            mainBody = BlocConsumer<PaymentBloc, PaymentState>(
              listener: (context, state) {
                if (state is PaymentErrorDialog) {
                  RequestUtil.catchNetworkError(
                      context: context, obj: state.error);
                } else if (state is PaymentErrorKomplatDialog) {
                  Multiplatform.showMessage(
                      context: context,
                      title: 'Произошла ошибка',
                      message: state.errorText ?? '',
                      type: DialogType.error);
                } else if (state is PaymentResult) {
                  _onPaymentFinishTap();
                } else if (state is PaymentSuccess) {
                  _onPaymentSuccess();
                  Navigation.toCheck(
                      suplierValueName: state.suplierValueName,
                      suplierName: state.suplierName,
                      paymentId: state.paymentId,
                      checkList: state.checkList,
                      code: widget.code,
                      name: widget.name);
                  // _onConfirmTap();
                  //context.read<ConfirmBloc>().add(ConfirmRun());
                } else if (state is PaymentRequestLoading) {
                  setState(() {
                    widget.isHomeButtonActive = false;
                  });
                } else if (state is PaymentInputFields ||
                    state is PaymentResult) {
                  setState(() {
                    widget.isHomeButtonActive = true;
                  });
                }
              },
              builder: (context, state) {
                Widget body = Container();
                if (state is PaymentLoading) {
                  body = Expanded(
                    flex: widget.isDevice ? 0 : 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [LoadingIndicator()],
                      ),
                    ),
                  );
                }
                if (state is PaymentRequestLoading) {
                  body = Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Идет обработка заявки',
                            style: GoogleFonts.openSans(
                              color: const Color(0xff333333),
                              fontSize: widget.isDevice ? 17 : 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: double.maxFinite,
                            height: widget.isDevice ? 30 : 50),
                        LoadingIndicator()
                      ],
                    ),
                  );
                } else if (state is PaymentInputFields) {
                  final exstraInfoValue = state.service.attrRecord
                      ?.firstWhere((element) => element.code == 100,
                          orElse: () => AttrRecordResponse())
                      .value;

                  final parent = state.service.groupRecord?.name ??
                      'Узел ${state.service.groupRecord?.code}';
                  final name =
                      state.service.name ?? 'Услуга ${state.service.code}';

                  final title =
                      state.service.view != 1 ? parent : exstraInfoValue;
                  HelpPayApp.setPageTitle(context, name);

                  body = widget.isDevice
                      ? ServiceScreenPaymentInputFields(
                          state: state,
                          title: title ?? '',
                          suplierName: widget.suplierName,
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            controller: serviceScrollController,
                            child: Column(
                              children: [
                                ServiceScreenPaymentInputFields(
                                  state: state,
                                  title: title ?? '',
                                  suplierName: widget.suplierName,
                                ),
                                const SizedBox(height: 120)
                              ],
                            ),
                          ),
                        );
                } else if (state is PaymentError) {
                  body = Expanded(
                    child: PageError(
                      message: RequestUtil.kNetworkError,
                      onRepeatTap: () => context
                          .read<PaymentBloc>()
                          .add(PaymentGetInfo(widget.code)),
                    ),
                  );
                } else if (state is PaymentErrorKomplat) {
                  body = Expanded(
                    child: PageError(
                      message: state.errorText ?? 'Неизвестная ошибка',
                      onRepeatTap: () => context
                          .read<PaymentBloc>()
                          .add(PaymentGetInfo(widget.code)),
                    ),
                  );
                }
                return body;
              },
            );
          }
          return mainBody;
        })
      ],
    );
  }

  // void _onConfirmTap() {
  //   context.read<ConfirmBloc>().add(ConfirmRun());
  // }

  void _onPaymentFinishTap() {
    context.read<PaymentBloc>().add(PaymentFinish());
  }

  void _onPaymentSuccess() {
    context.read<PaymentsBloc>().add(PaymentsUpdate());
  }
}
