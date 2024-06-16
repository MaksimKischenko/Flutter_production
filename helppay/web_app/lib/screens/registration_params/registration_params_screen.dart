import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'web_registration_params_screen');

@RoutePage()
class RegistrationParamsScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/registration_params');

  static const pageRoute = '/registration/params';

  final List<MdomResponseParam>? params;
  final List<MdomLookupItem>? lookups;
  final String? phoneNumber;

  const RegistrationParamsScreen({this.params, this.lookups, this.phoneNumber});

  @override
  _RegistrationParamsScreenState createState() =>
      _RegistrationParamsScreenState();
}

class _RegistrationParamsScreenState extends State<RegistrationParamsScreen> {
  late List<MdomResponseParam> paramsCopy;

  final _paramsFormKey = GlobalKey<FormState>();
  final _contactSourceFormKey = GlobalKey<FormState>();
  final _contactSourcePickerKey = GlobalKey<FormState>();

  bool checkboxValue1 = false;
  bool checkboxValue2 = false;

  String? _selectedContactOption;

  @override
  void initState() {
    super.initState();
    if (widget.params == null) {
      AutoRouter.of(context).push(const RegistrationRoute());
    } else {
      paramsCopy = widget.params ?? [];
      _selectedContactOption = widget.lookups
          ?.firstWhere((element) => element.evalue == 'PHONE')
          .evalue;
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is RegistrationErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
          }
          if (state is RegistrationSuccessEdit) {
            _registrationSuccessEdit(codeType: state.codeType);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 360, maxHeight: 900),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      SvgPicture.asset('assets/images/logo.svg'),
                      const SizedBox(height: 64),
                      Text(
                        context.t.mobileScreens.registrationParams.title,
                        style: AppStyles.headerTextStyle,
                      ),
                      const SizedBox(height: 36),
                      Form(
                        key: _paramsFormKey,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // padding: const EdgeInsets.symmetric(vertical: 24),
                          itemCount: paramsCopy.length,
                          itemBuilder: (context, index) => ParamsItemWidget(
                            index: index,
                            paramsCopy: paramsCopy,
                            onChanged: (value) {
                              setState(() {
                                paramsCopy[index].evalue = _boolToString(value);
                              });
                            },
                            onSaved: (value) {
                              paramsCopy[index].evalue = value;
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: _contactSourceFormKey,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: paramsCopy.length,
                          itemBuilder: (context, index) =>
                              ContactSourceItemWidget(
                            index: index,
                            onSaved: (value) {
                              paramsCopy[index].evalue = value;
                            },
                            paramsCopy: paramsCopy,
                            initialPhoneNumber: widget.phoneNumber,
                            selectedContactOption: _selectedContactOption,
                          ),
                        ),
                      ),
                      ContactSourcePickerWidget(
                        param: paramsCopy.singleWhere((element) =>
                            element.alias == 'SOURCECOMMUNICATION'),
                        lookUps: widget.lookups,
                        selectedContactOption: _selectedContactOption,
                        onChanged: (String? value) {
                          paramsCopy
                              .singleWhere((element) =>
                                  element.alias == 'SOURCECOMMUNICATION')
                              .evalue = value;

                          setState(() {
                            _selectedContactOption = value;
                            if (value == 'EMAIL') {
                              checkboxValue1 = false;
                              checkboxValue2 = false;
                            }
                          });
                        },
                      ),
                      if (_selectedContactOption == 'PHONE') ...[
                        CheckboxListTile(
                          value: checkboxValue1,
                          onChanged: (bool? value) {
                            setState(() {
                              checkboxValue1 = value!;
                            });
                          },
                          subtitle: const Text(
                              'Согласен на обработку персональных данных'),
                          contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        ),
                        CheckboxListTile(
                          value: checkboxValue2,
                          onChanged: (bool? value) {
                            setState(() {
                              checkboxValue2 = value!;
                            });
                          },
                          // title: const Text('Headline'),
                          subtitle: const Text(
                              'Согласие на получение уведомлений по указанному каналу коммуникации'),
                          contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        ),
                      ],
                      const SizedBox(height: 16),
                      RegistrationApplyButton(
                        selectedContactOption: _selectedContactOption,
                        checkboxValue1: checkboxValue1,
                        checkboxValue2: checkboxValue2,
                        text: context
                            .t.mobileScreens.registrationParams.applyButton,
                        onPressed: _onProceedTap,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  // ignore: prefer_expression_function_bodies
  Widget _buildContactSourcePickerItem(MdomResponseParam param) {
    // final param = paramsCopy[index];
    // final type = ParamType.values[param.type];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${param.name}:',
          ),
        ),
        Form(
          key: _contactSourcePickerKey,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            itemCount: widget.lookups?.length ?? 0,
            itemBuilder: (context, index) => ListTile(
              title: Text(widget.lookups?[index].name ?? ''),
              leading: Radio<String?>(
                value: widget.lookups?[index].evalue,
                groupValue: _selectedContactOption,
                onChanged: (String? value) {
                  paramsCopy
                      .singleWhere(
                          (element) => element.alias == 'SOURCECOMMUNICATION')
                      .evalue = value;

                  setState(() {
                    _selectedContactOption = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );

    // returnedWidget ??= const SizedBox.shrink();
    // return returnedWidget;
  }

  String? _boolToString(bool? value) {
    String? ret;
    if (value == true) ret = 'Y';
    if (value == false) ret = 'N';
    return ret;
  }

  void _onProceedTap() {
    final sourceOfCommunicationParam = paramsCopy
        .singleWhere((element) => element.alias == 'SOURCECOMMUNICATION');

    if (sourceOfCommunicationParam.evalue != null &&
        sourceOfCommunicationParam.evalue!.isEmpty) {
      sourceOfCommunicationParam.evalue = _selectedContactOption;
    }

    if ((_paramsFormKey.currentState?.validate() ?? false) &&
        (_contactSourceFormKey.currentState?.validate() ?? false)) {
      _paramsFormKey.currentState?.save();
      _contactSourceFormKey.currentState?.save();
      context
          .read<RegistrationBloc>()
          .add(RegistrationParamsEntryCompleted(params: paramsCopy));
    }
  }

  void _registrationSuccessEdit({required ConfirmCodeType codeType}) {
    AutoRouter.of(context).pushAndPopUntil(
        RegistrationCodeRoute(codeType: codeType),
        predicate: (route) => false);
  }
}
