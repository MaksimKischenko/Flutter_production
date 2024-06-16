
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:tuple/tuple.dart';

import 'widgets.dart';

class FieldsPage extends StatefulWidget {
  final ScrollController scrollController;
  final int payCode;
  final PayRecordResponse service;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final double? qrSum;

  const FieldsPage(
      {
        //required Key? key,
      required this.scrollController,
      required this.payCode,
      required this.service,
      required this.finishedAttrs,
      required this.qrSum});
      //: super(key: key);

  @override
  _FieldsPageState createState() => _FieldsPageState();
}

class _FieldsPageState extends State<FieldsPage> {
  late List<AttrRecordResponse> attrs;
  late List<AttrRecordResponse> _visibleAttrs;
  late List<AttrRecordRequest> _attrsEdited;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? _sumKey;
  double? _sum;

  final _titleKey = GlobalKey();

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      (widget.scrollController.hasClients) &&
      widget.scrollController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();
    attrs = widget.service.attrRecord ?? [];

    _attrsEdited = attrs
        .map(
          (attr) => AttrRecordRequest(
            code: attr.code ?? 0,
            codeOut: attr.codeOut,
            value: attr.value.toString(),
            change: 0,
          ),
        )
        .toList();

    _visibleAttrs = attrs.where(_filter).toList();

    widget.scrollController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
      },
    );

    if (widget.service.getPayListType == 0) {
      _sumKey = GlobalKey<FormState>();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController.dispose(); 
  }

  /// filter visible elements
  bool _filter(AttrRecordResponse attr) {
    if ((attr.view ?? 0) == 0) return false;
    if ((attr.edit ?? 0) == 0) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset('assets/icon/close.svg',
              colorFilter: const ColorFilter.mode(AppStyles.mainColorDark, BlendMode.srcIn),
            ),
          ),
          title: _showTitle
              ? Text(
                  widget.service.name ?? '',
                  style: const TextStyle(color: AppStyles.mainColorDark),
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        child: PageTitle(
                            key: _titleKey, text: widget.service.name ?? ''),
                      ),
                      Form(
                          key: _formKey,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              itemCount: _visibleAttrs.length,
                              itemBuilder: (context, index) =>
                                  _buildItem(index))),
                      if (widget.service.getPayListType == 0)
                        SumField(
                          formKey: _sumKey!,
                          min: widget.service.min,
                          max: widget.service.max,
                          initialValue: (widget.service.summa ?? 0.0) == 0.0
                              ? widget.qrSum
                              : widget.service.summa,
                          onSaved: (value) {
                            _sum = value;
                          },
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: NextButton(
                    onPressed: _onSaveTap,
                    text:
                        context.t.mobileScreens.payment.fieldsPage.nextButton),
              )
            ],
          ),
        ),
      );

  Widget _buildItem(int index) {
    final attr = _visibleAttrs[index];

    final mandatory = (attr.mandatory ?? 0) == 1;
    final minLength = attr.minLength ?? 0;
    final maxLength = attr.maxLength ?? 99;
    final type = typeFromKomplatString(attr.type);
    final keyboardType = type.keyboardType;
    final inputFormatters = type.inputFormatters;
    final validator = type.validator;

    Widget? body;
    if (type == ParamType.str ||
        type == ParamType.integ ||
        type == ParamType.doubl) {
        body = AttrField(
          labelText: mandatory ? '${attr.name}*' : attr.name ?? '',
          hintText: attr.hint,
          initialValue: attr.value,
          maxLength: maxLength,
          editable: true,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: (value) {
            if (mandatory && value.isEmpty) {
              return context
                  .t.mobileScreens.payment.fieldsPage.paramField.errors.empty;
            }
            if (!mandatory && value.isEmpty) return null;
            if (value.length < minLength) {
              return context.t.mobileScreens.payment.fieldsPage.paramField.errors
                  .minLength(minLength: minLength);
            }

            return validator.call(value);
          },
          onSaved: (value) {
            _attrsEdited[index].value = value;
          },

        );
    } else if (type == ParamType.date) {
      body = AttrDate(
        labelText: attr.name ?? '',
        hintText: attr.hint,
        initialValue: attr.value,
        editable: true,
        onSaved: (value) {
          _attrsEdited[index].value = value;
        },
      );
    } else if (type == ParamType.logic) {
      body = AttrLogic(
        text: attr.name ?? '',
        value: _stringToBool(_attrsEdited[index].value),
        editable: true,
        onChanged: (value) {
          setState(() {
            _attrsEdited[index].value = _boolToString(value);
          });
        },
      );
    }
    return Padding(
      padding:
          EdgeInsets.only(bottom: index != _attrsEdited.length - 1 ? 16 : 0),
      child: body ?? const SizedBox(),
    );
  }

  ParamType typeFromKomplatString(String? value) {
    ParamType temp;
    switch (value) {
      case 'S':
        temp = ParamType.str;
        break;
      case 'R':
        temp = ParamType.doubl;
        break;
      case 'I':
        temp = ParamType.integ;
        break;
      case 'D':
        temp = ParamType.date;
        break;
      case 'L':
        temp = ParamType.logic;
        break;
      default:
        temp = ParamType.str;
    }
    return temp;
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
    final getPayListType = widget.service.getPayListType;

    if (_validateForm()) {
      _formKey.currentState?.save();

      for (final attr in _attrsEdited) {
        final visibleAttr = _visibleAttrs
            .firstOrNullWhere((visibleAttr) => attr.code == visibleAttr.code);
        if (visibleAttr != null) attr.change = 1;
      }

      if (getPayListType == 0) {
        // Form with sum
        // next request - RunOperation
        if (_validateSum()) {
          _sumKey?.currentState?.save();
          context.read<PaymentBloc>().add(PaymentInputFieldsFinished(
              payCode: widget.payCode,
              service: widget.service,
              attrsEdited: _attrsEdited,
              sum: _sum,
              finishedAttrs: widget.finishedAttrs));
        }
      } else {
        // Simple form w/o sum
        // next request - getPayList
        context.read<PaymentBloc>().add(PaymentInputFieldsFinished(
            payCode: widget.payCode,
            service: widget.service,
            attrsEdited: _attrsEdited,
            finishedAttrs: widget.finishedAttrs));
      }
    } else {
      if (getPayListType == 0) _validateSum();
    }
  }

  bool _validateForm() => _formKey.currentState?.validate() ?? false;

  bool _validateSum() => _sumKey?.currentState?.validate() ?? false;
}
