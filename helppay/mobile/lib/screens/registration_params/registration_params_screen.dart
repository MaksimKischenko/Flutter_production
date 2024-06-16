import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'registration_params_screen');

class RegistrationParamsScreen extends StatefulWidget {
  static const pageRoute = '/registration/params';

  final List<MdomResponseParam> params;
  final List<MdomLookupItem>? lookUps;
  final String? phoneNumber;

  const RegistrationParamsScreen({
    required this.params,
    this.lookUps,
    this.phoneNumber,
  });

  @override
  _RegistrationParamsScreenState createState() =>
      _RegistrationParamsScreenState();
}

class _RegistrationParamsScreenState extends State<RegistrationParamsScreen> {
  late List<MdomResponseParam> paramsCopy;

  final paramsFormKey = GlobalKey<FormState>();
  final contactSourceFormKey = GlobalKey<FormState>();
  final contactSourcePickerFormKey = GlobalKey<FormState>();
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;

  String? _selectedContactOption;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedContactOption = widget.lookUps
          ?.firstWhere((element) => element.evalue == 'PHONE')
          .evalue;
    });
    paramsCopy = widget.params;
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
            child: Column(
              children: [
                Expanded(
                  child: FullScreen(
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
                        // MyForm(),

                        Form(
                          key: paramsFormKey,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 2),
                            itemCount: paramsCopy.length,
                            itemBuilder: (context, index) => ParamsItemWidget(
                              index: index,
                              paramsCopy: paramsCopy,
                              onChanged: (value) {
                                setState(() {
                                  paramsCopy[index].evalue =
                                      _boolToString(value);
                                });
                              },
                              onSaved: (value) {
                                paramsCopy[index].evalue = value;
                              },
                            ),
                          ),
                        ),
                        Form(
                          key: contactSourceFormKey,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
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
                          lookUps: widget.lookUps,
                          selectedContactOption: _selectedContactOption,
                          onChanged: (String? value) {
                            // _log(
                            //     'data in picker before -${paramsCopy.where((element) => element.alias == 'SOURCECOMMUNICATION').single.evalue}');
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                          ),
                        ]
                        //   Form(
                        //     key: _contactSourcePickerFormKey,
                        //     child: ListView.builder(
                        //         shrinkWrap: true,
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        //         itemCount: paramsCopy.length,
                        //         itemBuilder: (context, index) =>
                        //             _buildContactSourcePickerItem(index)),
                        //   ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: RegistrationApplyButton(
                    selectedContactOption: _selectedContactOption,
                    checkboxValue1: checkboxValue1,
                    checkboxValue2: checkboxValue2,
                    text:
                        context.t.mobileScreens.registrationParams.applyButton,
                    onPressed: _onProceedTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

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

    if ((paramsFormKey.currentState?.validate() ?? false) &&
        (contactSourceFormKey.currentState?.validate() ?? false)) {
      paramsFormKey.currentState?.save();
      contactSourceFormKey.currentState?.save();

      context.read<RegistrationBloc>().add(
            RegistrationParamsEntryCompleted(
              params: paramsCopy,
              sourceOfCommunication: _selectedContactOption,
            ),
          );
    }
  }

  void _registrationSuccessEdit({required ConfirmCodeType codeType}) {
    Navigation.toRegistrationCode(codeType: codeType);
  }
}
