import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'profile_edit_screen');

class ProfileEditScreen extends StatefulWidget {
  static const pageRoute = '/profile/edit';

  final List<MdomResponseParam> userParams;
  final MdomLookup? lookups;

  const ProfileEditScreen({Key? key, required this.userParams, this.lookups})
      : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late ScrollController _hideBottomNavController;

  final paramsFormKey = GlobalKey<FormState>();
  final contactSourceFormKey = GlobalKey<FormState>();
  final contactSourcePickerFormKey = GlobalKey<FormState>();
  final contactSourcePickerKey = GlobalKey<FormState>();

  String? _selectedContactOption;

  final _titleKey = GlobalKey();

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _hideBottomNavController.hasClients &&
      _hideBottomNavController.offset - titleSize > 0;

  late List<MdomResponseParam> params;
  late List<MdomRequestParam> paramsEdited;

  @override
  void initState() {
    super.initState();

    params = List.unmodifiable(widget.userParams.where(_filter).toList());
    paramsEdited = params
        .map((e) => MdomRequestParam(
              evalue: e.evalue,
              name: e.name,
              id: e.id,
              idParent: e.idParent,
              alias: e.alias,
            ))
        .toList();

    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
      },
    );
    _selectedContactOption = params
        .singleWhere((element) => element.alias == 'SOURCECOMMUNICATION')
        .evalue;
  }

  @override
  void dispose() {
    super.dispose();
    _hideBottomNavController.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is ProfileErrorKomplat) {
            final isTokenError = state.errorCode == 403;

            if (!isTokenError) {
              RequestUtil.catchKomplatError(
                  context: context,
                  errorCode: state.errorCode,
                  errorText: state.errorMessage);
            }
            if (isTokenError) {
              // Future<void>.delayed(const Duration(seconds: 1),
              //     () => Navigation.navigatorKey.currentState?.pop());
              Multiplatform.onExpiredTokenScreenLock(context);
            }
          }
          if (state is ProfileSuccessEdit) {
            _profileSuccessEdit();
          }
        },
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: ArrowBack(),
            title: _showTitle
                ? Text(
                    context.t.mobileScreens.profileEdit.title,
                    style: const TextStyle(color: AppStyles.mainColorDark),
                  )
                : null,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            actions: [
              SaveButton(
                onTap: _onSaveTap,
              )
            ],
          ),
          body: FullScreen(
            bottomSafe: false,
            controller: _hideBottomNavController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  child: PageTitle(
                    key: _titleKey,
                    text: context.t.mobileScreens.profileEdit.title,
                  ),
                ),
                Form(
                  key: paramsFormKey,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    itemCount: params.length,
                    itemBuilder: (context, index) => _buildItem(index),
                  ),
                ),
                Form(
                  key: contactSourceFormKey,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    itemCount: params.length,
                    itemBuilder: (context, index) =>
                        _buildContactSourceItem(index),
                  ),
                ),
                _buildContactSourcePickerItem(
                    params.singleWhere(
                        (element) => element.alias == 'SOURCECOMMUNICATION'),
                    widget.lookups),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      );

  /// filter visible elements
  bool _filter(MdomResponseParam param) {
    if ((param.view ?? 0) == 0) return false;
    if ((param.edit ?? 0) == 0) return false;
    return true;
  }

  Widget _buildItem(int index) {
    final param = params[index];

    final mandatory = (param.mandatory ?? 0) == 1;
    final minLength = param.minLength ?? 0;
    final maxLength = param.maxLength ?? 99;
    final type = ParamType.values[param.type];
    final keyboardType = type.keyboardType;
    final inputFormatters = type.inputFormatters;
    final validator = type.validator;

    Widget? returnedWidget;
    if ((type == ParamType.str ||
            type == ParamType.integ ||
            type == ParamType.doubl ||
            type == ParamType.composite) &&
        (params[index].alias != 'PHONE' &&
            params[index].alias != 'EMAIL' &&
            params[index].alias != 'SOURCECOMMUNICATION')) {
      returnedWidget = ParamField(
        isMobileInputField: false,
        labelText: mandatory ? '${param.name}*' : param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        maxLength: maxLength,
        editable: true,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (mandatory && value.isEmpty) {
            return context.t.mobileScreens.profileEdit.paramField.errors.empty;
          }
          if (!mandatory && value.isEmpty) return null;
          if (value.length < minLength) {
            return context.t.mobileScreens.profileEdit.paramField.errors
                .minLength(minLength: minLength);
          }

          return validator.call(value);
        },
        onSaved: (value) {
          paramsEdited[index].evalue = value;
        },
      );
    } else if (type == ParamType.date) {
      returnedWidget = ParamDate(
        labelText: param.name,
        hintText: param.hint,
        initialValue: param.evalue,
        editable: true,
        onSaved: (value) {
          paramsEdited[index].evalue = value;
        },
      );
    } else if (type == ParamType.logic) {
      returnedWidget = ParamLogic(
        text: param.name,
        value: _stringToBool(paramsEdited[index].evalue),
        editable: true,
        onChanged: (value) {
          setState(() {
            paramsEdited[index].evalue = _boolToString(value);
          });
        },
      );
    }

    return returnedWidget != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: returnedWidget,
          )
        : const SizedBox.shrink();
  }

  Widget _buildContactSourceItem(int index) {
    final param = params[index];

    final mandatory = (param.mandatory ?? 0) == 1;
    final minLength = param.minLength ?? 0;
    final maxLength = param.maxLength ?? 99;
    final type = ParamType.values[param.type];
    final keyboardType =
        param.alias == 'PHONE' ? TextInputType.number : type.keyboardType;
    final inputFormatters = type.inputFormatters;
    final validator = param.alias == 'EMAIL' ? validateEmail : type.validator;

    final editable = (param.edit ?? 0) == 1;

    Widget? returnedWidget;
    if (type == ParamType.str && param.alias == 'PHONE' ||
        param.alias == 'EMAIL') {
      returnedWidget = ParamField(
        isMobileInputField: param.alias == 'PHONE',
        labelText: mandatory ? '${param.name}*' : param.name,
        hintText: param.alias == 'PHONE' ? '## ###-##-##' : param.hint,
        initialValue: (param.evalue?.startsWith('375') ?? false)
            ? param.evalue!.replaceRange(0, 3, '')
            : param.evalue!,
        maxLength: maxLength,
        editable: editable,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (_selectedContactOption == 'PHONE' &&
              param.alias == 'PHONE' &&
              value.isEmpty) {
            return 'Заполните данные для выбранного способа оповещения';
            // return context
            // .t.mobileScreens.registrationParams.paramField.errors.empty;
          }
          if (_selectedContactOption == 'EMAIL' &&
              param.alias == 'EMAIL' &&
              value.isEmpty) {
            return 'Заполните данные для выбранного способа оповещения';
            // return context
            // .t.mobileScreens.registrationParams.paramField.errors.empty;
          }
          // if (!mandatory && value.isEmpty) return null;
          if (_selectedContactOption == 'EMAIL' &&
              param.alias == 'EMAIL' &&
              value.length < minLength) {
            return 'Минимальная длина не подходит';
            // return context.t.mobileScreens.registrationParams.paramField.errors
            //     .minLength(minLength: minLength);
          }
          if (_selectedContactOption == 'PHONE' &&
              param.alias == 'PHONE' &&
              value.length < minLength) {
            return 'Минимальная длина телефона не подходит';
            // return context.t.mobileScreens.registrationParams.paramField.errors
            //     .minLength(minLength: minLength);
          }

          // if (_selectedContactOption == 'EMAIL') {} else{

          // };
          return param.alias == 'EMAIL'
              ? validator.call(value, _selectedContactOption)
              : validator.call(value);
        },
        onSaved: (value) {
          paramsEdited[index].evalue =
              param.alias == 'PHONE' ? '375$value' : value;
        },
      );
    }

    return returnedWidget != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: returnedWidget,
          )
        : const SizedBox.shrink();
  }

  Widget _buildContactSourcePickerItem(
      MdomResponseParam param, MdomLookup? lookups) {
    // final param = paramsCopy[index];
    // final type = ParamType.values[param.type];
    //Widget? returnedWidget;
    _log('lokups- $lookups');
    _log('lokups data - ${lookups?.items?[0]}');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${param.name}:',
            ),
          ),
          Form(
            key: contactSourcePickerKey,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              itemCount: lookups?.items?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(lookups?.items?[index].name ?? ''),
                leading: Radio<String?>(
                  value: lookups?.items?[index].evalue,
                  groupValue: _selectedContactOption,
                  onChanged: (String? value) {
                    paramsEdited
                        .where(
                            (element) => element.alias == 'SOURCECOMMUNICATION')
                        .single
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
      ),
    );

    // returnedWidget ??= const SizedBox.shrink();
    // return returnedWidget;
  }

  String? validateEmail(String? value, String selectedContactOption) {
    if (selectedContactOption == 'PHONE') {
      return null;
    } else {
      if (value == null || value.isEmpty) {
        return t.mobileScreens.profileEdit.emailValidator.emptyEmail;
      }
      final emailRegex = RegExp(
          r'^[a-zA-Z0-9/!#$%&*+-=?^_{}|"]+(\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
      if (!emailRegex.hasMatch(value)) {
        return t.mobileScreens.profileEdit.emailValidator.invalidEmail;
      }

      if (value.length > 320) {
        return t.mobileScreens.profileEdit.emailValidator.invalidLength;
      }

      final parts = value.split('@');
      if (parts.length != 2 || parts[0].isEmpty || parts[1].isEmpty) {
        return t.mobileScreens.profileEdit.emailValidator.invalidEmail;
      }

      final hostParts = parts[1].split('.');
      for (final part in hostParts) {
        if (part.isEmpty ||
            part.length > 63 ||
            part.startsWith('-') ||
            part.endsWith('-')) {
          return t.mobileScreens.profileEdit.emailValidator.invalidEmail;
        }
      }

      final tld = hostParts.last;
      final validTlds = [
        'by',
        'com',
        'ru',
        'americanexpress'
      ]; // Ваши допустимые домены первого уровня
      if (!validTlds.contains(tld)) {
        return t.mobileScreens.profileEdit.emailValidator.invalidEmail;
      }

      return null;
    }
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
    // _log(
    //     '1 form validation - ${_paramsFormKey.currentState?.validate() ?? false}');
    // _log(
    //     '2 form validation - ${_contactSourceFormKey.currentState?.validate() ?? false}');
    if ((paramsFormKey.currentState?.validate() ?? false) &&
        (contactSourceFormKey.currentState?.validate() ?? false)) {
      // _log('params copy - ${params}');

      paramsFormKey.currentState?.save();
      contactSourceFormKey.currentState?.save();

      final changedParams = _filterChangedParams();
      if (changedParams.isEmpty) {
        Navigation.navigatorKey.currentState?.pop();
      } else {
        // _log('changedParams 1 - ${changedParams[0].evalue}');
        // _log('changedParams 2 - ${changedParams[1].evalue}');
        // _log('changedParams 3 - ${changedParams[2].evalue}');

        context
            .read<ProfileBloc>()
            .add(ProfileParamsChanged(params: changedParams));
      }
    }
  }

  List<MdomRequestParam> _filterChangedParams() {
    final _editedMap = <int, MdomRequestParam>{...paramsEdited.asMap()}
      // _log(
      //     'parm #$index with value - ${e.evalue}, does changed -${e.evalue == params[index].evalue}');
      ..removeWhere((index, e) => e.evalue == params[index].evalue);
    return _editedMap.values.toList();
  }

  void _profileSuccessEdit() {
    Navigation.navigatorKey.currentState?.pop();
    Multiplatform.showMessage(
        context: context,
        title: t.mobileScreens.profileEdit.modal.success.title,
        message: t.mobileScreens.profileEdit.modal.success.message,
        type: DialogType.success);
  }
}
