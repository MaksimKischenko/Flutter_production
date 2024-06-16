import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/routing/routes.gr.dart';
import 'package:isc_web_app/screens/register_payment_claim/widgets/widgets.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/date_helper.dart';
import 'package:isc_web_app/utils/utils.dart';
import 'package:isc_web_app/widgets/date_picker_widget.dart';
import 'package:responsive_ui/responsive_ui.dart';



@RoutePage()
// ignore: must_be_immutable
class RegisterPaymentClaimScreen extends StatelessWidget {
  static const pageRoute = '/register_payment_claim';

  final int? claimId;
  final ScrollController _controller;
  final GlobalKey<FormState> _formKey;

  RegisterPaymentClaimScreen({
    @PathParam('id') this.claimId,
    Key? key,
  })  : _controller = ScrollController(),
        _formKey = GlobalKey<FormState>(),
        super(key: key);

  RegisterPaymentOfClaimRequest registerPaymentOfClaimRequestData =
      RegisterPaymentOfClaimRequest.empty();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Регистрация факта оплаты требования ',
                  style: AppStyles.headerTextStyle),
            ],
          ),
        ),
        body: BlocListener<RegisterPaymentClaimBloc, RegisterPaymentClaimState>(
          listener: (context, state) {
            if(state is RegisterPaymentClaimErrorKomplat) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage
              );              
            } else if (state is RegisterPaymentClaimSuccess) {
              Future.delayed(const Duration(seconds: 1), ()=> AutoRouter.of(context).push(const ClaimsRoute()));
              Multiplatform.showMessage(
                context: context,
                title: 'УСПЕШНО',
                message: 'Оплата требования зарегистрирована',
                type: DialogType.success,
              );              
            }
          },
          child: Column(
            children: [
              Expanded(
                  child: Scrollbar(
                      thumbVisibility: true,
                      interactive: true,
                      controller: _controller,
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 600,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Responsive(
                                  runSpacing: 16,
                                  children: [
                                    Div(
                                        divison: const Division(
                                          colL: 12,
                                          colM: 12,
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child:
                                                PaySumField(onSaved: (value) {
                                              registerPaymentOfClaimRequestData =
                                                  registerPaymentOfClaimRequestData
                                                      .copyWith(
                                                          paySum: double.parse(
                                                              value));
                                            }))),
                                    Div(
                                        divison: const Division(
                                          colL: 6,
                                          colM: 12,
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: MemNumberField(
                                              onSaved: (value) {
                                                registerPaymentOfClaimRequestData =
                                                    registerPaymentOfClaimRequestData
                                                        .copyWith(
                                                            memNumber: value);
                                              },
                                            ))),
                                    Div(
                                        divison: const Division(
                                          colL: 6,
                                          colM: 12,
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: WebDatePicker(
                                              labelText:
                                                  'Дата платежного документа*',
                                              onChange: (value) {
                                                registerPaymentOfClaimRequestData =
                                                    registerPaymentOfClaimRequestData
                                                        .copyWith(
                                                            memDate: value
                                                                ?.toStringFormatted());
                                              },
                                            ))),
                                    Div(
                                        divison: const Division(
                                          colL: 12,
                                          colM: 12,
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: AccountNumberField(
                                              onSaved: (value) {
                                                registerPaymentOfClaimRequestData =
                                                    registerPaymentOfClaimRequestData
                                                        .copyWith(
                                                            account: value);
                                              },
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )))
            ],
          ),
        ),
        persistentFooterButtons: [
          Center(
            child: SizedBox(
              width: 200,
              child: CreateButton(
                text: 'Добавить',
                onTap: () => _onApplyTap(context),
              ),
            ),
          )
        ],
      );

  void _onApplyTap(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<RegisterPaymentClaimBloc>().add(RegisterPaymentClaimRun(
            claimId: claimId ?? 0,
            paySum: registerPaymentOfClaimRequestData.paySum ?? 0,
            memDate: (registerPaymentOfClaimRequestData.memDate ?? '')
                .toDateFormatted(),
            memNumber: registerPaymentOfClaimRequestData.memNumber ?? '',
            account: registerPaymentOfClaimRequestData.account ?? '',
          ));
    }
  }
}
