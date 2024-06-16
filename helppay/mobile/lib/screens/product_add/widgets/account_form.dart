import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'account_form ');

class AccountForm extends StatefulWidget {
  final List<MdomLoginResponseProductsCurrent> accountsList;
  final ScrollController scrollController;
  final MdomResponseParams params;
  final Function(List<MdomResponseParam> params) onSaved;

  const AccountForm({
    Key? key,
    required this.accountsList,
    required this.scrollController,
    required this.params,
    required this.onSaved,
  }) : super(key: key);

  @override
  AccountFormState createState() => AccountFormState();
}

class AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();

  late MdomResponseParams _params;
  late List<MdomResponseParam> _paramsVisible;
  late List<MdomResponseParam> _paramsInputed;
  late List<MdomResponseParam> _paramsVisibleAfterMainPart;
  late TextEditingController controller;
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;

  MdomResponseParam? accountNumberParam;

  @override
  void initState() {
    _log('params -${widget.params}');
    super.initState();
    controller = TextEditingController();
    _params = widget.params;
    _paramsVisible = _params.params.where(_filter).toList();
    _paramsInputed = _paramsVisible.map((e) => e.copyWith()).toList();

    accountNumberParam = _paramsInputed.firstOrNullWhere(
        (param) => _params.findByAlias(AliasList.number)?.id == param.id);
    _paramsVisibleAfterMainPart =
        _paramsVisible.where(_filterAfterMainPart).toList();
  }

  /// filter visible elements
  bool _filter(MdomResponseParam param) {
    if ((param.view ?? 0) == 0) return false;
    return true;
  }

  /// filter elements from main part
  bool _filterAfterMainPart(MdomResponseParam param) {
    // Номер счета
    if (param.id == accountNumberParam?.id) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PaymentMethodBloc, PaymentMethodState>(
        listener: (context, state) {
          if (state is RegisterPaymetnMethodError) {
            Navigator.pop(context);
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is RegisterPaymentMethodLoading) {
            Multiplatform.showLoaderDialog(context);
          }
          if (state is RegisterPaymentMethodKomplat) {
            if (state.needPop ?? false) Navigator.pop(context);
            final isTokenError = state.errorCode == 403;
            if (!isTokenError) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
            } else {
              Multiplatform.onExpiredTokenScreenLock(context);
            }
          }

          if (state is RegisterPaymentMethodSuccess) {
            Navigator.pop(context);
            showModalBottomSheet<Widget>(
              context: context,
              isScrollControlled: true,
              builder: (context) => PaymentMethodConfirmationDialog(
                typePan: state.typePan!,
                requestId: state.requestId,
                paymentMethodData: state.paymentMethodData,
              ),
              // isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              backgroundColor: const Color(0xffFCFCFC),
            );
          }
          if (state is ConfirmPaymentMethodSuccess) {
            _log('paymentMethodData - ${state.paymentMethodData}');
            widget.onSaved(state.paymentMethodData);
          }
        },
        child: Form(
          key: _formKey,
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: widget.scrollController,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                        children: [
                          AccountNumberField(
                            textFieldController: controller,
                            onSaved: (accountNumber) {
                              _log(
                                  'account number - ${accountNumber.replaceAll(' ', '')}');
                              accountNumberParam?.evalue =
                                  accountNumber.replaceAll(' ', '');
                            },
                          ),
                          const SizedBox(height: 16),
                          if (_paramsVisibleAfterMainPart.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  _buildItem(index),
                              itemCount: _paramsVisibleAfterMainPart.length,
                            ),
                          // ParamField(
                          //   labelText: 'Кодовое слово*',
                          //   hintText: 'Ввеите кодовове слово',
                          //   initialValue: '',
                          //   maxLength: 9,
                          //   editable: true,
                          //   keyboardType: TextInputType.text,
                          //   // inputFormatters: inputFormatters,
                          //   validator: (value) {
                          //     // if (mandatory && value.isEmpty) {
                          //     //   return context
                          //     //       .t.mobileScreens.productAdd.accountForm.paramField.errors.empty;
                          //     // }
                          //     // if (!mandatory && value.isEmpty) return null;
                          //     // if (value.length < minLength) {
                          //     //   return context
                          //     //       .t.mobileScreens.productAdd.accountForm.paramField.errors
                          //     //       .minLength(minLength: minLength);
                          //     // }

                          //     // return validator.call(value);
                          //   },
                          //   onSaved: (value) {
                          //     // _paramsInputed
                          //     //     .firstOrNullWhere((e) => e.id == param.id)
                          //     //     ?.evalue = value;
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ...[
                //   CheckboxListTile(
                //     value: checkboxValue1,
                //     onChanged: (bool? value) {
                //       setState(() {
                //         checkboxValue1 = value!;
                //       });
                //     },
                //     subtitle:
                //         const Text('Согласен на обработку персональных данных'),
                //     contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                //   ),
                //   CheckboxListTile(
                //     value: checkboxValue2,
                //     onChanged: (bool? value) {
                //       setState(() {
                //         checkboxValue2 = value!;
                //       });
                //     },
                //     // title: const Text('Headline'),
                //     subtitle: const Text(
                //         'Согласие на получение уведомлений по указанному каналу коммуникации'),
                //     contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                //   ),
                // ],
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SafeArea(
                    child: CreateButton(
                      text: context
                          .t.mobileScreens.productAdd.accountForm.addButton,
                      onTap: () => _onSaveTap(
                        context,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildItem(int index) {
    final param = _paramsVisibleAfterMainPart[index];

    final mandatory = (param.mandatory ?? 0) == 1;
    final minLength = param.minLength ?? 0;
    final maxLength = param.maxLength ?? 99;
    final type = ParamType.values[param.type];
    final keyboardType = type.keyboardType;
    final inputFormatters = type.inputFormatters;
    final validator = type.validator;
    final editable = (param.edit ?? 0) == 1;

    Widget? widget;
    if (type == ParamType.str ||
        type == ParamType.integ ||
        type == ParamType.doubl ||
        type == ParamType.composite) {
      widget = ParamField(
        labelText: mandatory ? '${param.name}*' : param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        maxLength: maxLength,
        editable: editable,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (mandatory && value.isEmpty) {
            return context
                .t.mobileScreens.productAdd.accountForm.paramField.errors.empty;
          }
          if (!mandatory && value.isEmpty) return null;
          if (value.length < minLength) {
            return context
                .t.mobileScreens.productAdd.accountForm.paramField.errors
                .minLength(minLength: minLength);
          }

          return validator.call(value);
        },
        onSaved: (value) {
          _paramsInputed.firstOrNullWhere((e) => e.id == param.id)?.evalue =
              value;
        },
      );
    } else if (type == ParamType.date) {
      widget = ParamDate(
        labelText: param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        editable: editable,
        onSaved: (value) {
          _paramsInputed.firstOrNullWhere((e) => e.id == param.id)?.evalue =
              value;
        },
      );
    } else if (type == ParamType.logic) {
      widget = ParamLogic(
        text: param.name,
        value: _stringToBool(
            _paramsInputed.firstOrNullWhere((e) => e.id == param.id)?.evalue),
        editable: editable,
        onChanged: (value) {
          setState(() {
            _paramsInputed.firstOrNullWhere((e) => e.id == param.id)?.evalue =
                _boolToString(value);
          });
        },
      );
    }

    widget ??= const SizedBox();
    return Padding(
      padding: EdgeInsets.only(
          bottom: index != _paramsVisibleAfterMainPart.length - 1 ? 16 : 0),
      child: widget,
    );
  }

  bool? _stringToBool(String? value) {
    bool? ret;
    if (value == 'Y') ret = true;
    if (value == 'N') ret = false;
    return ret;
  }

  String? _boolToString(bool? value) {
    String? ret;
    if (value == true) ret = 'Y';
    if (value == false) ret = 'N';
    return ret;
  }

  void _onSaveTap(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final returnData = <MdomResponseParam>[..._paramsInputed];
      final defaultFlagTemp = _params.findByAlias(AliasList.defaultFlag);
      final defaultFlag = defaultFlagTemp!.copyWith(evalue: '0');
      returnData.add(defaultFlag);
      _log('return data updated - $returnData');
      final typePanTemp = _params.findByAlias(AliasList.typePan);
      final typePan = typePanTemp!.copyWith();
      _log(' typePan - $typePan');
      returnData.add(typePan);
      _log('return data updated once more- $returnData');

      context.read<PaymentMethodBloc>().add(
            RegisterPaymentMethod(
                paymentMethodData: returnData,
                accountsList: widget.accountsList,
                typePan: AliasList.typePanAccount),
          );
    }
  }
}
