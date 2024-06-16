import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/screens/mdom_company_choice/widgets/select_button.dart';
import 'package:helppay/screens/mdom_company_search/widgets/search_screen_body.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class MdomCompanySearchScreen extends StatefulWidget {
  const MdomCompanySearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MdomCompanySearchScreenState createState() =>
      _MdomCompanySearchScreenState();
}

class _MdomCompanySearchScreenState extends State<MdomCompanySearchScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _unpSearchController;
  late TextEditingController _nameSearchController;
  InfoSupplierResponseCompany? _selectedCompany;
  bool get buttonActive => _selectedCompany != null;

  void selectCompany(InfoSupplierResponseCompany? company) {
    setState(() {
      _selectedCompany = company;
    });
  }

  @override
  void initState() {
    super.initState();
    _unpSearchController = TextEditingController();
    _nameSearchController = TextEditingController();
  }

  @override
  void dispose() {
    _unpSearchController.dispose();
    _nameSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: DialogTitle(
          text: context.t.mobileScreens.mdomCompanySearch.title,
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                SearcScreenInputField(
                  controller: _nameSearchController,
                  fieldTitle:
                      context.t.mobileScreens.mdomCompanySearch.nameField.title,
                  inputType: TextInputType.name,
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState?.validate() ?? false) {
                      context
                          .read<InfoSupplierBloc>()
                          .add(InfoSupplierLoad(supplierName: value));
                    }
                  },
                  validator: (value) {
                    if (_unpSearchController.text.isEmpty) {
                      if (value.length < 3) {
                        return context.t.mobileScreens.mdomCompanySearch
                            .nameField.errors.length;
                      }
                      return null;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                SearcScreenInputField(
                  controller: _unpSearchController,
                  maxLength: 9,
                  fieldTitle:
                      context.t.mobileScreens.mdomCompanySearch.unpField.title,
                  inputType: TextInputType.number,
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState?.validate() ?? false) {
                      context
                          .read<InfoSupplierBloc>()
                          .add(InfoSupplierLoad(supplierUNN: int.parse(value)));
                    }
                  },
                  validator: (value) {
                    if (_nameSearchController.text.isEmpty) {
                      if (value.length < 9) {
                        return context.t.mobileScreens.mdomCompanySearch
                            .unpField.errors.length;
                      }
                      return null;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                SearchScreenBody(
                  selectCompany: selectCompany,
                  unpSearchController: _unpSearchController,
                  nameSearchController: _nameSearchController,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 8,
                  ),
                  child: SafeArea(
                    child: SelectButton(
                      active: _selectedCompany != null,
                      onPressed: _onSelectTap,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  void _onSelectTap() {
    if (_selectedCompany != null) {
      Navigator.of(context).pop<InfoSupplierResponseCompany>(_selectedCompany);
    }
  }
}
