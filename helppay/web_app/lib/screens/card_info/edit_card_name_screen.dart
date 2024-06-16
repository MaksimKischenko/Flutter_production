import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';

import 'widgets/widgets.dart';

@RoutePage()
class EditCardNameScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/editCardName');

  static const pageRoute = '/editCardName';

  final String? pan;
  final MdomResponseParam? nameParam;

  const EditCardNameScreen({this.pan, this.nameParam});

  @override
  _EditCardNameScreenState createState() => _EditCardNameScreenState();
}

class _EditCardNameScreenState extends State<EditCardNameScreen> {
  final _paramsFormKey = GlobalKey<FormState>();

  bool get mandatory => (widget.nameParam?.mandatory ?? 0) == 1;
  int get minLength => widget.nameParam?.minLength ?? 0;
  int get maxLength => widget.nameParam?.maxLength ?? 99;
  ParamType get type => ParamType.values[widget.nameParam?.type ?? 0];
  TextInputType get keyboardType => type.keyboardType;
  List<TextInputFormatter> get inputFormatters => type.inputFormatters;
  String? Function(String)? get validator => type.validator;

  late MdomRequestParam nameParamEdited;

  @override
  void initState() {
    super.initState();
    if (widget.nameParam != null) {
      nameParamEdited = MdomRequestParam(
          evalue: widget.nameParam?.evalue,
          name: widget.nameParam?.name ?? '',
          id: widget.nameParam?.id ?? 0,
          idParent: widget.nameParam?.idParent,
          alias: widget.nameParam?.alias);
    } else {
      AutoRouter.of(context).replace(const ProductsRoute());
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsSuccessRename) {
            _onBackPressed();
          }
        },
        child: WebDialogWindow(
          title: context.t.mobileScreens.cardInfo.title,
          onPressed: _onSaveTap,
          buttonTitle: context.t.mobileScreens.cardInfo.buttonTitle,
          buttonActive: true,
          useSpacer: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _paramsFormKey,
              child: ParamField(
                labelText: mandatory
                    ? '${widget.nameParam?.name}*'
                    : widget.nameParam?.name,
                hintText: widget.nameParam?.hint,
                initialValue: widget.nameParam?.evalue,
                maxLength: maxLength,
                editable: true,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                validator: (value) {
                  if (mandatory && value.isEmpty) {
                    return context.t.mobileScreens.cardInfo.editName.paramField
                        .errors.empty;
                  }
                  if (!mandatory && value.isEmpty) return null;
                  if (value.length < minLength) {
                    return context
                        .t.mobileScreens.cardInfo.editName.paramField.errors
                        .minLength(minLength: minLength);
                  }
                  return validator?.call(value);
                },
                onSaved: (value) {
                  nameParamEdited.evalue = value;
                },
              ),
            ),
          ),
        ),
      );

  void _onSaveTap() {
    if (_paramsFormKey.currentState?.validate() ?? false) {
      _paramsFormKey.currentState?.save();

      if (widget.nameParam?.evalue == nameParamEdited.evalue) {
        _onBackPressed();
      } else {
        context.read<ProductsBloc>().add(ProductRename(
              pan: widget.pan ?? '',
              nameParam: widget.nameParam!.copyWith(evalue: nameParamEdited.evalue),
            ));
      }
    }
  }

  void _onBackPressed() {
    AutoRouter.of(context).pop();
  }
}
