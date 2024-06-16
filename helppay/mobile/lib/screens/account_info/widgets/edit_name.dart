import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class EditName extends StatefulWidget {
  final String pan;
  final MdomResponseParam nameParam;

  const EditName({
    required this.pan,
    required this.nameParam,
  });

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final _paramsFormKey = GlobalKey<FormState>();

  bool get mandatory => (widget.nameParam.mandatory ?? 0) == 1;
  int get minLength => widget.nameParam.minLength ?? 0;
  int get maxLength => widget.nameParam.maxLength ?? 99;
  ParamType get type => ParamType.values[widget.nameParam.type];
  TextInputType get keyboardType => type.keyboardType;
  List<TextInputFormatter> get inputFormatters => type.inputFormatters;
  String? Function(String)? get validator => type.validator;

  late MdomRequestParam nameParamEdited;

  @override
  void initState() {
    super.initState();

    nameParamEdited = MdomRequestParam(
        evalue: widget.nameParam.evalue,
        name: widget.nameParam.name,
        id: widget.nameParam.id,
        idParent: widget.nameParam.idParent,
        alias: widget.nameParam.alias);
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is ProductsSuccessRename) {
              _onBackPressed();
            }
          },
          child: CupertinoPageScaffold(
            navigationBar: DialogTitleAction(
                action: TextButton(
              onPressed: _onSaveTap,
              child:
                  Text(context.t.mobileScreens.accountInfo.editName.doneButton),
            )),
            child: Form(
              key: _paramsFormKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ParamField(
                      labelText: mandatory
                          ? '${widget.nameParam.name}*'
                          : widget.nameParam.name,
                      hintText: widget.nameParam.hint,
                      initialValue: widget.nameParam.evalue,
                      maxLength: maxLength,
                      editable: true,
                      keyboardType: keyboardType,
                      inputFormatters: inputFormatters,
                      validator: (value) {
                        if (mandatory && value.isEmpty) {
                          return context.t.mobileScreens.accountInfo.editName
                              .paramField.errors.empty;
                        }
                        if (!mandatory && value.isEmpty) return null;
                        if (value.length < minLength) {
                          return context.t.mobileScreens.accountInfo.editName
                              .paramField.errors
                              .minLength(minLength: minLength);
                        }
                        return validator?.call(value);
                      },
                      onSaved: (value) {
                        nameParamEdited.evalue = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));

  void _onSaveTap() {
    if (_paramsFormKey.currentState?.validate() ?? false) {
      _paramsFormKey.currentState?.save();

      if (widget.nameParam.evalue == nameParamEdited.evalue) {
        _onBackPressed();
      } else {
        context.read<ProductsBloc>().add(ProductRename(
              pan: widget.pan,
              nameParam:
                  widget.nameParam.copyWith(evalue: nameParamEdited.evalue),
            ));
      }
    }
  }

  void _onBackPressed() {
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
    Navigator.of(context).pop();
  }
}
