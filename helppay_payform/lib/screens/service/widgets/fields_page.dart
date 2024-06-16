import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tuple/tuple.dart';

import 'widgets.dart';

class FieldsPage extends StatefulWidget {
  final int payCode;
  final double remainingAmount;
  final PayRecordResponse service;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final List<ResponseClaimProperty> properties;
  final bool isDevice;

  const FieldsPage({
    required Key key,
    required this.payCode,
    required this.remainingAmount,
    required this.service,
    required this.finishedAttrs,
    required this.properties,
    required this.isDevice,
  }) : super(key: key);

  @override
  _FieldsPageState createState() => _FieldsPageState();
}

class _FieldsPageState extends State<FieldsPage> {
  late List<AttrRecordResponse> attrs;
  late List<AttrRecordResponse> _visibleAttrs;
  late List<AttrRecordResponse> _visibleInfoAttrs;
  late List<AttrRecordRequest> _attrsEdited;

  final _formKey = GlobalKey<FormState>();

  String currencyName(int code) => AppConfig.mapCurrencyToName[code] ?? '';
  double? _sum;
  var helperText = 'Доступная сумма к переводу -\n';

  @override
  void initState() {
    super.initState();
    attrs = widget.service.attrRecord ?? [];

    _attrsEdited = attrs
        .map((attr) => AttrRecordRequest(
            code: attr.code ?? -1,
            codeOut: attr.codeOut,
            value: attr.value ?? '',
            change: 0))
        .toList();

    _visibleAttrs = attrs.where(_filterVisible).toList();
    _visibleInfoAttrs = attrs.where(_filterVisibleInfo).toList();

    if (widget.service.min != null)
      helperText +=
          'минимум ${widget.service.min} ${currencyName(widget.service.currency ?? 0)}';

    // var max = widget.service.max != null
    //                     ? widget.service.max! > widget.remainingAmount
    //                       ? widget.remainingAmount
    //                       : widget.service.max
    //                     : widget.remainingAmount;

    var max = widget.service.max;

    if (max != null)
      helperText +=
          ', максимум $max ${currencyName(widget.service.currency ?? 0)}';
  }

  /// filter visible elements
  bool _filterVisible(AttrRecordResponse attr) {
    if ((attr.view ?? 0) == 0) return false;
    if (attr.code == 100) return false;
    // if ((attr.edit ?? 0) == 0) return false;
    return true;
  }

  /// filter visible info (code=100) elements
  bool _filterVisibleInfo(AttrRecordResponse attr) {
    if (attr.code != 100) return false;
    if ((attr.view ?? 0) == 0) return false;
    if (attr.value?.trim().isEmpty ?? true) return false;
    // if ((attr.edit ?? 0) == 0) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        builder: (context, sizingInformation) {
          final isDevice =
              sizingInformation.isMobile || sizingInformation.isTablet;
          final double widgetWidth = MediaQuery.of(context).size.width - 32;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if (_visibleInfoAttrs.isNotEmpty)
                    //   ListView.builder(
                    //       shrinkWrap: true,
                    //       physics: const NeverScrollableScrollPhysics(),
                    //       padding: const EdgeInsets.only(top: 15),
                    //       itemCount: _visibleInfoAttrs.length,
                    //       itemBuilder: (context, index) =>
                    //           _buildInfoItem(_visibleInfoAttrs[index])),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: isDevice ? widgetWidth : 500,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: _visibleAttrs.length,
                          itemBuilder: (context, index) => _buildItem(index)),
                    ),
                    if (widget.service.view == 1)
                      SizedBox(
                        width: isDevice ? widgetWidth : 312,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Введите сумму платежа в ${currencyName(widget.service.currency ?? 0)}',
                                style: AppStyles.labelTextStyle),
                            const SizedBox(height: 6),
                            Text(
                              helperText,
                              style: widget.isDevice
                                  ? AppStyles.hintTextStyleDevice
                                  : AppStyles.hintTextStyleWeb,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SumField(
                                isDevice: widget.isDevice,
                                min: widget.service.min,
                                max: widget.service.max,
                                // max: widget.service.max != null
                                //   ? widget.service.max! > widget.remainingAmount
                                //     ? widget.remainingAmount
                                //     : widget.service.max
                                //   : widget.remainingAmount,
                                editable: widget.service.edit == 1,
                                currency: widget.service.currency ??
                                    AppConfig.defaultCurrency,
                                initialValue: widget.service.summa,
                                onSaved: (value) {
                                  _sum = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 36),
              widget.isDevice
                  ? Column(
                      children: [
                        widget.service.view != 1
                            ? NextButtonRedesign(
                                onTap: _onSaveTap, name: 'Продолжить')
                            : NextButton(
                                onPressed: _onSaveTap,
                                text: 'Отправить заявку'),
                        const SizedBox(height: 16),
                        ReturnButton(onTap: () => Navigator.pop(context)),
                      ],
                    )
                  : Row(
                      children: [
                        ReturnButton(onTap: () => Navigator.pop(context)),
                        const SizedBox(width: 24),
                        widget.service.view != 1
                            ? NextButtonRedesign(
                                onTap: _onSaveTap, name: 'Продолжить')
                            : NextButton(
                                onPressed: _onSaveTap,
                                text: 'Отправить заявку'),
                      ],
                    ),
            ],
          );
        },
      );

  // Widget _buildInfoItem(AttrRecordResponse attr) => Text(
  //       attr.value?.trim() ?? '',
  //       style: TextStyle(color: Colors.black.withOpacity(0.5)),
  //     );

  Widget _buildItem(int index) {
    final attr = _visibleAttrs[index];

    final mandatory = (attr.mandatory ?? 0) == 1 || (attr.minLength ?? 0) > 0;
    final minLength = attr.minLength ?? 0;
    final maxLength = attr.maxLength ?? 99;
    final type = ParamTypeHelpExtension.fromKomplatString(attr.type);
    final keyboardType = type.keyboardType;
    final inputFormatters = type.inputFormatters;
    final validator = type.validator;
    final editable = attr.edit == 1;

    Widget body = Container();
    if (type == ParamType.str ||
        type == ParamType.integ ||
        type == ParamType.doubl) {
      if (attr.lookup?.isNotEmpty ?? false) {
        List<LookupItem>? items;
        final lookupIndex = widget.service.lookups?.lookupList
                ?.indexWhere((e) => e.name == attr.lookup) ??
            -1;
        if (lookupIndex > -1) {
          items = widget.service.lookups!.lookupList![lookupIndex].items;
        }
        body = AttrDropdown(
          items: items?.map((e) => e.evalue).toList() ?? [],
          editable: editable,
          initialValue: attr.value,
          labelText: mandatory && editable ? '${attr.name}*' : attr.name ?? '',
          hintText: attr.hint,
          validator: (value) {
            if (mandatory && (value?.isEmpty ?? true)) {
              return 'Поле обязательно для заполнения';
            }
            if (!mandatory && (value?.isEmpty ?? true)) return null;
            if ((value?.length ?? 0) < minLength) {
              return 'Минимальная длина $minLength';
            }

            return validator.call(value);
          },
          onSaved: (value) {
            final _editedIndex = _attrsEdited.indexWhere(
                (e) => (e.code == attr.code) && (e.codeOut == attr.codeOut));
            _attrsEdited[_editedIndex].value = value;
          },
        );
      } else {
        body = SizedBox(
          width: widget.isDevice ? MediaQuery.of(context).size.width - 32 : 530,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(attr.name ?? '', style: AppStyles.labelTextStyle),
              const SizedBox(height: 6),
              Text(
                attr.hint == null
                    ? 'Укажите ${attr.name}'
                    : '${attr.hint} (минимальная длина - $minLength символов, максимальная длина - $maxLength символов)',
                style: widget.isDevice
                    ? AppStyles.hintTextStyleDevice
                    : AppStyles.hintTextStyleWeb,
              ),
              const SizedBox(height: 8),
              AttrField(
                maxLength: maxLength,
                isDevice: widget.isDevice,
                initialValue: attr.value,
                editable: editable,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                validator: (value) {
                  if (mandatory && (value?.isEmpty ?? true)) {
                    return 'Поле обязательно для заполнения';
                  }
                  if (!mandatory && (value?.isEmpty ?? true)) return null;
                  if ((value?.length ?? 0) < minLength) {
                    return 'Минимальная длина $minLength';
                  }

                  return validator.call(value);
                },
                onSaved: (value) {
                  if (value!.length <= maxLength) {
                    final _editedIndex = _attrsEdited.indexWhere((e) =>
                        (e.code == attr.code) && (e.codeOut == attr.codeOut));
                    _attrsEdited[_editedIndex].value = value;
                  }
                },
              ),
            ],
          ),
        );
      }
    } else if (type == ParamType.date) {
      body = AttrDate(
        labelText: attr.name ?? '',
        hintText: attr.hint,
        initialValue: attr.value ?? '',
        editable: attr.edit == 1,
        onSaved: (value) {
          final _editedIndex = _attrsEdited.indexWhere(
              (e) => (e.code == attr.code) && (e.codeOut == attr.codeOut));
          _attrsEdited[_editedIndex].value = value;
        },
      );
    } else if (type == ParamType.logic) {
      body = AttrLogic(
        text: attr.name ?? '',
        value: _stringToBool(_attrsEdited[index].value),
        editable: attr.edit == 1,
        onChanged: (value) {
          final _editedIndex = _attrsEdited.indexWhere(
              (e) => (e.code == attr.code) && (e.codeOut == attr.codeOut));
          setState(() {
            _attrsEdited[_editedIndex].value = _boolToString(value);
          });
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: body,
    );
  }

  bool _stringToBool(String? value) {
    if (value == 'Y') {
      return true;
    } else if (value == 'N') {
      return false;
    } else {
      return false;
    }
  }

  String _boolToString(bool value) => value ? 'Y' : 'N';

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      _attrsEdited.forEach((attr) {
        AttrRecordResponse? visibleAttr;
        final _index = _visibleAttrs.indexWhere((comparableAttr) =>
            (attr.code == comparableAttr.code) &&
            (attr.codeOut == comparableAttr.codeOut));
        if (_index > -1) visibleAttr = _visibleAttrs[_index];
        if (visibleAttr != null) attr.change = 1;
      });

      BlocProvider.of<PaymentBloc>(context).add(PaymentInputFieldsFinished(
          payCode: widget.payCode,
          service: widget.service,
          attrsEdited: _attrsEdited,
          sum: _sum,
          finishedAttrs: widget.finishedAttrs,
          properties: widget.properties));
      widget.service.view != 1
          ? null
          : context.read<PaymentBloc>().add(PaymentFinish());
    }
  }

  void _onPayTap() {
    context.read<PaymentBloc>().add(PaymentFinish());
  }
}
