import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/blocs.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';

import 'widgets/widgets.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'web_profile_edit_screen');

@RoutePage()
class ProfileEditScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/profile_edit');

  static const pageRoute = '/profile/edit';

  final List<MdomResponseParam>? params;
  final MdomLookup? lookups;

  const ProfileEditScreen({Key? key, this.params, this.lookups})
      : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final paramsFormKey = GlobalKey<FormState>();
  final contactSourceFormKey = GlobalKey<FormState>();
  final contactSourcePickerFormKey = GlobalKey<FormState>();
  final contactSourcePickerKey = GlobalKey<FormState>();

  String? _selectedContactOption;
  List<MdomResponseParam> params = [];
  List<MdomRequestParam> paramsEdited = [];

  @override
  void initState() {
    super.initState();
    if (widget.params == null) {
      AutoRouter.of(context).popAndPush(const ProfileRoute());
    } else {
      params = List.unmodifiable(widget.params!.where(_filter).toList());
      paramsEdited = params
          .map(
            (e) => MdomRequestParam(
              evalue: e.evalue,
              name: e.name,
              id: e.id,
              idParent: e.idParent,
              alias: e.alias,
            ),
          )
          .toList();
      _selectedContactOption = params
          .singleWhere((element) => element.alias == 'SOURCECOMMUNICATION')
          .evalue;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          }
          if (state is ProfileErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
            if (state.errorCode == 403) {
              Future.delayed(
                const Duration(seconds: 2),
                () => AutoRouter.of(context).push(
                  AuthRoute(),
                ),
              );
            }
          }
          if (state is ProfileSuccessEdit) {
            _profileSuccessEdit();
          }
        },
        child: WebDialogWindow(
          buttonTitle: context.t.mobileScreens.profileEdit.saveButton,
          onPressed: _onSaveTap,
          title: context.t.mobileScreens.profileEdit.title,
          buttonActive: true,
          useSpacer: false,
          body: ListView(children: [
            Form(
              key: paramsFormKey,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: params.length,
                itemBuilder: (context, index) =>
                    (params[index].alias != 'PHONE' &&
                            params[index].alias != 'EMAIL' &&
                            params[index].alias != 'SOURCECOMMUNICATION')
                        ? ProfileItem(
                            item: params[index],
                            index: index,
                            paramsEdited: paramsEdited,
                          )
                        : const SizedBox.shrink(),
              ),
            ),
            Form(
              key: contactSourceFormKey,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: params.length,
                itemBuilder: (context, index) =>
                    (params[index].alias == 'PHONE' ||
                            params[index].alias == 'EMAIL')
                        ? ProfileItem(
                            selectedContactOption:
                                _selectedContactOption ?? 'PHONE',
                            item: params[index],
                            index: index,
                            paramsEdited: paramsEdited,
                          )
                        : const SizedBox.shrink(),
              ),
            ),
            _buildContactSourcePickerItem(
                params.singleWhere(
                    (element) => element.alias == 'SOURCECOMMUNICATION'),
                widget.lookups),
          ]),
        ),
      );
  Widget _buildContactSourcePickerItem(
          // final param = paramsCopy[index];
          // final type = ParamType.values[param.type];
          //Widget? returnedWidget;
          // _log('lokups- ${lookups}');
          // _log('lokups data - ${lookups?.items?[0]}');
          MdomResponseParam param,
          MdomLookup? lookups) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
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
                          .where((element) =>
                              element.alias == 'SOURCECOMMUNICATION')
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

  /// filter visible elements
  bool _filter(MdomResponseParam param) {
    if ((param.view ?? 0) == 0) return false;
    if ((param.edit ?? 0) == 0) return false;
    return true;
  }

  void _onSaveTap() {
    if ((paramsFormKey.currentState?.validate() ?? false) &&
        (contactSourceFormKey.currentState?.validate() ?? false)) {
      // _log('params copy - ${params}');

      paramsFormKey.currentState?.save();
      contactSourceFormKey.currentState?.save();

      final changedParams = _filterChangedParams();
      if (changedParams.isEmpty) {
        AutoRouter.of(context).navigatorKey.currentState?.pop();
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
      ..removeWhere((index, e) => e.evalue == params[index].evalue);
    return _editedMap.values.toList();
  }

  void _profileSuccessEdit() {
    AutoRouter.of(context).navigatorKey.currentState?.pop();
    Multiplatform.showMessage(
      context: context,
      title: t.mobileScreens.profileEdit.modal.success.title,
      message: t.mobileScreens.profileEdit.modal.success.message,
      type: DialogType.success,
    );
  }
}
