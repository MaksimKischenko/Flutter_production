import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:helppay/utils/multiplatform.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'account_form ');

class CardForm extends StatefulWidget {
  final ScrollController scrollController;
  final MdomResponseParams params;
  final Function(List<MdomResponseParam> params) onSaved;

  const CardForm(
      {Key? key,
      required this.scrollController,
      required this.params,
      required this.onSaved})
      : super(key: key);

  @override
  CardFormState createState() => CardFormState();
}

class CardFormState extends State<CardForm> {
  final _formKey = GlobalKey<FormState>();

  late MdomResponseParams _params;
  late List<MdomResponseParam> _paramsVisible;
  late List<MdomResponseParam> _paramsInputed;
  late List<MdomResponseParam> _paramsVisibleAfterMainPart;

  MdomResponseParam? cardNumberParam;
  MdomResponseParam? cardExpirationDateParam;
  MdomResponseParam? cardCVVParam;

  @override
  void initState() {
    super.initState();

    _params = widget.params;
    _paramsVisible = _params.params.where(_filter).toList();
    _paramsInputed = _paramsVisible.map((e) => e.copyWith()).toList();

    cardNumberParam = _paramsInputed.firstOrNullWhere(
        (param) => _params.findByAlias(AliasList.number)?.id == param.id);
    cardExpirationDateParam = _paramsInputed.firstOrNullWhere((param) =>
        _params.findByAlias(AliasList.expirationDate)?.id == param.id);
    cardCVVParam = _paramsInputed.firstOrNullWhere(
        (param) => _params.findByAlias(AliasList.cvv)?.id == param.id);

    _paramsVisibleAfterMainPart =
        _paramsVisible.where(_filterAfterMainPart).toList();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Multiplatform.showMessage(
        context: context,
        title: 'Предупреждение',
        message:
            'Функионал добавления карты будет добавлен в ближайшем обновлении',
        type: DialogType.info,
      ),
    );
  }

  /// filter visible elements
  bool _filter(MdomResponseParam param) {
    if ((param.view ?? 0) == 0) return false;
    return true;
  }

  /// filter elements from main part
  bool _filterAfterMainPart(MdomResponseParam param) {
    // Номер карты
    if (param.id == cardNumberParam?.id) return false;
    // Срок действия
    if (param.id == cardExpirationDateParam?.id) return false;
    // CVV
    if (cardCVVParam != null && param.id == cardCVVParam?.id) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(children: [
                      CardNumberField(
                        onSaved: (cardNumber) {
                          _log('card number - $cardNumber');
                          cardNumberParam?.evalue = cardNumber;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              flex: 2,
                              child: ExpiryField(
                                onSaved: (expiry) {
                                  cardExpirationDateParam?.evalue = expiry;
                                },
                              )),
                          if (cardCVVParam != null) const SizedBox(width: 80),
                          if (cardCVVParam != null)
                            Expanded(
                                flex: 1,
                                child: CvvField(
                                  onSaved: (cvv) {
                                    cardCVVParam?.evalue = cvv;
                                  },
                                )),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _buildItem(index),
                        itemCount: _paramsVisibleAfterMainPart.length,
                      )
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: SafeArea(
                child: CreateButton(
                  text: context.t.mobileScreens.productAdd.cardForm.addButton,
                  onTap: _onSaveTap,
                ),
              ),
            ),
          ],
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
                .t.mobileScreens.productAdd.cardForm.paramField.errors.empty;
          }
          if (!mandatory && value.isEmpty) return null;
          if (value.length < minLength) {
            return context.t.mobileScreens.productAdd.cardForm.paramField.errors
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

  void _onSaveTap() {
    // Multiplatform.showMessage(
    //   context: context,
    //   title: 'Предупреждение',
    //   message:
    //       'Функионал добавления карты будет добавлен в ближайшем обновлении',
    //   type: DialogType.info,
    // );
      if (_formKey.currentState?.validate() ?? false) { //TODO uncomment when needed this is main functionality
        _formKey.currentState?.save();

        final returnData = <MdomResponseParam>[..._paramsInputed];

        final defaultFlagTemp = _params.findByAlias(AliasList.defaultFlag);
        final defaultFlag = defaultFlagTemp!.copyWith(evalue: '0');
        returnData.add(defaultFlag);

        final typePanTemp = _params.findByAlias(AliasList.typePan);
        final typePan = typePanTemp!.copyWith();
        returnData.add(typePan);

        widget.onSaved(returnData);
      }
  }
}
