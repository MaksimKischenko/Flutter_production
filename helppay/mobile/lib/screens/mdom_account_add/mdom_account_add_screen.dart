import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class MdomAccountAddScreen extends StatefulWidget {
  const MdomAccountAddScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MdomAccountAddScreenState createState() => _MdomAccountAddScreenState();
}

class _MdomAccountAddScreenState extends State<MdomAccountAddScreen> {
  final _paramsFormKey = GlobalKey<FormState>();
  final _supplierSearchNameController = TextEditingController();
  final _supplierNameFocus = FocusNode();
  final _accountFocus = FocusNode();
  InfoSupplierResponseCompany? _selectedCompany;

  bool showCodeWordField = false;

  int? unp;
  String? account;
  String? codeWord;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _supplierSearchNameController.dispose();
    _supplierNameFocus.dispose();
    _accountFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<MdomCreateAccountBloc, MdomCreateAccountState>(
        listener: (context, state) {
          if (state is MdomCreateAccountError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is MdomCreateAccountErrorKomplat) {
            RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage);
          } else if (state is MdomCreateAccountCodeWordSent) {
            setState(() {
              showCodeWordField = !showCodeWordField;
            });
          } else if (state is MdomCreateAccountSuccess) {
            setState(() {
              showCodeWordField = !showCodeWordField;
            });
            context
                .read<MdomAccrualsBloc>()
                .add(MdomAccrualsNewAccount(state.account));
            Navigator.of(context).pop();
            Multiplatform.showMessage(
                context: context,
                title: t.mobileScreens.mdomAccountAdd.successModal.title,
                message: t.mobileScreens.mdomAccountAdd.successModal.text,
                type: DialogType.success);
          }
        },
        child: CupertinoPageScaffold(
          navigationBar:
              DialogTitle(text: context.t.mobileScreens.mdomAccountAdd.title),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Form(
                    key: _paramsFormKey,
                    child: Column(
                      children: [
                        BlocListener<InfoSupplierBloc, InfoSupplierState>(
                          listener: (context, state) {
                            if (state is InfoSupplierErrorKomplat) {
                              final isTokenError = state.errorCode == 403;
                              if (isTokenError) {
                                Multiplatform.onExpiredTokenScreenLock(context);
                              } else {
                                Multiplatform.showMessage(
                                  context: context,
                                  title: t.general.errorModal.title,
                                  message: state.errorMessage,
                                  type: DialogType.error,
                                );
                              }
                            } else if (state is InfoSupplierError) {
                              RequestUtil.catchNetworkError(
                                  context: context, obj: state.error);
                            }
                          },
                          child: SupplierNameField(
                            focusNode: _supplierNameFocus,
                            controller: _supplierSearchNameController,
                            onSearchTap: _onSearchTap,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AccountNumberField(
                          focusNode: _accountFocus,
                          onSaved: (value) {
                            account = value;
                          },
                        ),
                        const SizedBox(height: 8),
                        if (showCodeWordField)
                          CodeWordField(
                            onSaved: (value) {
                              codeWord = value;
                            },
                          )
                        else
                          const SizedBox.shrink(),
                        const SizedBox(height: 8),
                        SupplierSearchBody(
                          selectCompany: selectCompany,
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: SafeArea(
                    child: AddButton(
                      active: true,
                      onPressed: _onAddTap,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  void _onAddTap() {
    if (_paramsFormKey.currentState?.validate() ?? false) {
      _paramsFormKey.currentState?.save();
      context.read<MdomCreateAccountBloc>().add(
            MdomCreateAccountInit(
              supplierId: unp!,
              account: account!,
              codeWord: showCodeWordField ? codeWord! : null,
            ),
          );
    }
  }

  void selectCompany(InfoSupplierResponseCompany? company) {
    setState(() {
      _selectedCompany = company;
      if (_selectedCompany != null) {
        _supplierSearchNameController.text = _selectedCompany
                ?.objectParam?.params
                ?.firstOrNullWhere((param) => param.alias == 'SUPPLIERNAME')
                ?.evalue ??
            '';
        unp = _selectedCompany?.supplierId;
        _supplierNameFocus.unfocus();
        FocusScope.of(context).requestFocus(_accountFocus);
        context.read<InfoSupplierBloc>().add(InfoSupplierSelected());
      }
    });
  }

  // ignore: avoid_void_async
  // void _onChooseUnnTap({
  //   required List<CompaniesResponseCompany> companies,
  // }) async {
  //   final selectedCompany = await Navigation.toMdomCompanyChoise(
  //     context: context,
  //     companies: companies,
  //     initialCompanyId: _supplierSearchNameController.text.toIntOrNull(),
  //   );
  //   if (selectedCompany != null) {
  //     _supplierSearchNameController.text = selectedCompany.supplierId.toString();
  //   }
  // }

  Future<void> _onSearchTap() async {
    context.read<InfoSupplierBloc>().add(
        InfoSupplierLoad(supplierName: _supplierSearchNameController.text));
  }
}
