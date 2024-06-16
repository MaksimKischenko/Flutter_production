import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/screens/mdom_account_add/widgets/widgets.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';

class MdomAccountAddScreenBody extends StatefulWidget {
  const MdomAccountAddScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  _MdomAccountAddScreenBodyState createState() =>
      _MdomAccountAddScreenBodyState();
}

class _MdomAccountAddScreenBodyState extends State<MdomAccountAddScreenBody> {
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
  Widget build(BuildContext context) => WebDialogWindow(
        body: BlocListener<MdomCreateAccountBloc, MdomCreateAccountState>(
          listener: (context, state) {
            if (state is MdomCreateAccountError) {
              RequestUtil.catchNetworkError(
                context: context,
                obj: state.error,
              );
            } else if (state is MdomCreateAccountErrorKomplat) {
              RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
            } else if (state is MdomCreateAccountCodeWordSent) {
              setState(() {
                showCodeWordField = !showCodeWordField;
              });
            } else if (state is MdomCreateAccountSuccess) {
              context
                  .read<MdomAccrualsBloc>()
                  .add(MdomAccrualsNewAccount(state.account));
              AutoRouter.of(context).pushAndPopUntil(const MdomAccrualsRoute(),
                  predicate: (route) => false);
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Multiplatform.showMessage(
                  context: context,
                  title: t.mobileScreens.mdomAccountAdd.successModal.title,
                  message: t.mobileScreens.mdomAccountAdd.successModal.text,
                  type: DialogType.success,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _paramsFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocListener<InfoSupplierBloc, InfoSupplierState>(
                    listener: (context, state) {
                      if (state is InfoSupplierErrorKomplat) {
                        final isTokenError = state.errorCode == 403;
                        if (isTokenError) {
                          Future.delayed(
                              const Duration(seconds: 2),
                              () => AutoRouter.of(context).pushAndPopUntil(
                                  AuthRoute(),
                                  predicate: (route) => false));
                        } else {
                          Multiplatform.showMessage(
                              context: context,
                              title: t.general.errorModal.title,
                              message: state.errorMessage,
                              type: DialogType.error);
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
                  Column(
                    children: [
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
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SupplierSearchBody(
                      selectCompany: selectCompany,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        useSpacer: true,
        title: context.t.mobileScreens.mdomAccountAdd.title,
        buttonTitle: context.t.mobileScreens.mdomAccountAdd.addButton,
        onPressed: _onAddTap,
        buttonActive: true,
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
  //     initialCompanyId: _supplierIdController.text.toIntOrNull(),
  //   );
  //   if (selectedCompany != null) {
  //     _supplierIdController.text = selectedCompany.supplierId.toString();
  //   }
  // }

  // ignore: avoid_void_async
  void _onSearchTap() async {
    context.read<InfoSupplierBloc>().add(
        InfoSupplierLoad(supplierName: _supplierSearchNameController.text));
  }
}
