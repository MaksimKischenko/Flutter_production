import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/config.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

import 'widgets.dart';

class FieldsPage extends StatefulWidget {
  final int payCode;
  final PayRecordResponse service;
  final List<Tuple2<String, dynamic>> finishedAttrs;
  final List<ResponseClaimProperty> properties;

  const FieldsPage({
    required Key key,
    required this.payCode,
    required this.service,
    required this.finishedAttrs,
    required this.properties
  }) : super(key: key);

  @override
  _FieldsPageState createState() => _FieldsPageState();
}

class _FieldsPageState extends State<FieldsPage> {
  final _controller = TextEditingController();
  final _keyboardVisibility = ValueNotifier<bool>(false);
  final _keyboardLayout = ValueNotifier<KeyboardLayout>(KeyboardLayout.text);
  late List<AttrRecordResponse> attrs;
  late List<AttrRecordResponse> _visibleAttrs;
  int _visibleAttrsFinishedCount = 0;
  late List<AttrRecordResponse> _visibleInfoAttrs;
  late List<AttrRecordRequest> _attrsEdited;

  final _formKey = GlobalKey<FormState>();
  double? _sum;
  bool sumAttrDisplay = false;

  @override
  void initState() {
    super.initState();
    attrs = widget.service.attrRecord ?? [];

    _attrsEdited = attrs.map((attr) => AttrRecordRequest(
      code: attr.code ?? -1,
      codeOut: attr.codeOut,
      value: attr.value ?? '',
      change: 0
    )).toList();
  
    _visibleAttrs = attrs.where(_filterVisible).toList();
    _visibleInfoAttrs = attrs.where(_filterVisibleInfo).toList();

    if (_visibleAttrs.isEmpty && (widget.service.view ?? 0) == 1) {
      _keyboardLayout.value = KeyboardLayout.decimal;
      if ((widget.service.edit ?? 0) == 1) {
        _keyboardVisibility.value = true;
      }
      sumAttrDisplay = true;
    }    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: KeyboardWrapper(
          textEditingController: _controller,
          keyboardVisibility: _keyboardVisibility,
          keyboardLayout: _keyboardLayout,
          onHideKeyboardTap: () {
            _keyboardVisibility.value = false;
          },
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!sumAttrDisplay)
                      _buildItem(_visibleAttrsFinishedCount),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   padding: EdgeInsets.zero,
                      //   itemCount: _visibleAttrs.length,
                      //   itemBuilder: (context, index) => _buildItem(index)
                      // ),
                      if (sumAttrDisplay)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SumField(
                          controller: _controller,
                          min: widget.service.min,
                          max: widget.service.max,
                          editable: widget.service.edit == 1,
                          currency: widget.service.currency ?? AppConfig.defaultCurrency,
                          initialValue: widget.service.summa,
                          onSaved: (value) {
                            _sum = value;
                          },
                          onTap: () {
                            _keyboardVisibility.value = true;
                          },
                        ),
                      ),
                      if (_visibleInfoAttrs.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 16),
                        itemCount: _visibleInfoAttrs.length,
                        itemBuilder: (context, index) => _buildInfoItem(_visibleInfoAttrs[index])
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      // menu
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: GradientButton(
                onTap: _onHomeTap,
                gradientColors: const [
                  AppStyles.mainColor,
                  AppStyles.mainColor,
                ],
                child: Text(ScreenInfo.of(context).service.attrsStep.homeButtonLabel),
              )
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GradientButton(
                onTap: _onSaveTap,
                gradientColors: const [
                  CupertinoColors.systemGreen,
                  CupertinoColors.systemGreen,
                ],
                child: Text(ScreenInfo.of(context).service.attrsStep.nextButtonLabel),
                // child: Text(),
              )
            ),
            const SizedBox(width: 16),
            // _button('Оферта'),
            // const SizedBox(width: 16),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // NextButton(
      //   onPressed: _onSaveTap,
      //   text: 'Далее'
      // ),
    ],
  );

  Widget _buildInfoItem(AttrRecordResponse attr) => Text(
    attr.value?.trim() ?? '',
    style: TextStyle(
      color: Colors.black.withOpacity(0.5)
    ),
  );

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
    if (type == ParamType.str
        || type == ParamType.integ
        || type == ParamType.doubl) {
      if (attr.lookup?.isNotEmpty ?? false) {
        _keyboardVisibility.value = false;

        List<LookupItem>? items;
        final lookupIndex = widget.service.lookups?.lookupList?.indexWhere((e) => e.name == attr.lookup) ?? -1;
        if (lookupIndex > -1) {
          items = widget.service.lookups!.lookupList![lookupIndex].items;
        }
        body = AttrDropdown(
          key: Key(attr.name ?? 'key${DateTime.now()}'),
          items: items?.map((e) => e.evalue).toList() ?? [],
          editable: editable,
          initialValue: attr.value,
          labelText: mandatory && editable
              ? '${attr.name}*'
              : attr.name ?? '',
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
            final _editedIndex = _attrsEdited.indexWhere((e) => (e.code == attr.code) && (e.codeOut == attr.codeOut));
            _attrsEdited[_editedIndex].value = value;
          },
        );
      } else {
        _keyboardLayout.value = type.keyboardLayout;
        // displayKeyabord = true;
        body = AttrField(
          controller: _controller,
          key: Key(attr.name ?? 'key${DateTime.now()}'),
          labelText: mandatory && editable
              ? '${attr.name}*'
              : attr.name ?? '',
          hintText: attr.hint,
          initialValue: attr.value,
          maxLength: maxLength,
          editable: editable,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onTap: () {
            _keyboardVisibility.value = true;
          },
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
            final _editedIndex = _attrsEdited.indexWhere((e) => (e.code == attr.code) && (e.codeOut == attr.codeOut));
            if (value?.isEmpty ?? true) {
              // empty field
              _attrsEdited[_editedIndex].value = null;
            } else {
              _attrsEdited[_editedIndex].value = value;
            }
          },
          keyboardVisibility: _keyboardVisibility,
          onKeyboardDisplayTap: (value) {
            _keyboardVisibility.value = value;
          },
        ); 
      }
    } else if (type == ParamType.date) {
      _keyboardVisibility.value = false;

      body = AttrDate(
        key: Key(attr.name ?? 'key${DateTime.now()}'),
        labelText: attr.name ?? '',
        hintText: attr.hint,
        initialValue: attr.value ?? '',
        editable: attr.edit == 1,
        dateFormat: attr.format,
        onSaved: (value) {
          final _editedIndex = _attrsEdited.indexWhere((e) => (e.code == attr.code) && (e.codeOut == attr.codeOut));
          _attrsEdited[_editedIndex].value = value;
        },
      );
    } else if (type == ParamType.logic) {
      _keyboardVisibility.value = false;

      body = AttrLogic(
        key: Key(attr.name ?? 'key${DateTime.now()}'),
        text: attr.name ?? '',
        value: _stringToBool(_attrsEdited[index].value),
        editable: attr.edit == 1,
        onChanged: (value) {
          final _editedIndex = _attrsEdited.indexWhere((e) => (e.code == attr.code) && (e.codeOut == attr.codeOut));
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

  void _onHomeTap() {
    Navigation.toPopularServices();
    // Navigation.toSplash();
  }

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (!sumAttrDisplay) _visibleAttrsFinishedCount++;

      if (_visibleAttrsFinishedCount == _visibleAttrs.length) {
        // check showing sum attr
        if (widget.service.view == 1 && !sumAttrDisplay) {
          // show sum attr
          setState(() {
            sumAttrDisplay = true;
          });
          _keyboardLayout.value = KeyboardLayout.decimal;
        } else {
          // send all attrs

          for (final attr in _attrsEdited) {
            AttrRecordResponse? visibleAttr;
            final _index = _visibleAttrs.indexWhere((comparableAttr) => (attr.code == comparableAttr.code) && (attr.codeOut == comparableAttr.codeOut));
            if (_index > -1) visibleAttr = _visibleAttrs[_index];
            if (visibleAttr != null && (visibleAttr.edit ?? 0) == 1) attr.change = 1;
          }
          // clean attrs with null value
          _attrsEdited = _attrsEdited.where((e) => e.value != null).toList();
          
          BlocProvider.of<PaymentBloc>(context).add(
            PaymentInputFieldsFinished(
              payCode: widget.payCode,
              service: widget.service,
              attrsEdited: _attrsEdited,
              sum: _sum,
              finishedAttrs: widget.finishedAttrs,
              properties: widget.properties
            )
          );
        }
      } else {
        // show next attr
        setState(() {
          
        });
      }
    }
  }
}