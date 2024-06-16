import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';

import 'widgets/widgets.dart';

class MdomCompanyChoiceScreen extends StatefulWidget {
  final List<CompaniesResponseCompany> companies;
  final int? initialCompanyId;

  const MdomCompanyChoiceScreen({
    Key? key,
    required this.companies,
    required this.initialCompanyId,
  }) : super(key: key);

  @override
  _MdomCompanyChoiceScreenState createState() =>
      _MdomCompanyChoiceScreenState();
}

class _MdomCompanyChoiceScreenState extends State<MdomCompanyChoiceScreen> {
  final _searchController = TextEditingController();

  List<CompaniesResponseCompany> visibleCompanies = [];

  CompaniesResponseCompany? _selectedCompany;

  bool get buttonActive => _selectedCompany != null;

  @override
  void initState() {
    super.initState();

    visibleCompanies = widget.companies;
    _searchController.addListener(() {
      final search = _searchController.text;

      setState(() {
        visibleCompanies = widget.companies
            .where((company) =>
                company.name.toLowerCase().contains(search.toLowerCase()))
            .toList();
        if (!visibleCompanies.contains(_selectedCompany)) {
          _selectedCompany = null;
        }
      });
    });

    if (widget.initialCompanyId != null) {
      final index = widget.companies.indexWhere(
          (company) => company.supplierId == widget.initialCompanyId);
      if (index > -1) _selectedCompany = widget.companies[index];
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
        title: context.t.mobileScreens.mdomCompanyChoise.title,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              SearchTextField(
                controller: _searchController,
              ),
              if (visibleCompanies.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    separatorBuilder: (context, _) => Divider(
                      color: AppStyles.mainColorDark.withOpacity(0.1),
                    ),
                    shrinkWrap: true,
                    itemCount: visibleCompanies.length,
                    itemBuilder: (context, index) => CompanyItem(
                      company: visibleCompanies[index],
                      selected: _selectedCompany == visibleCompanies[index],
                      onTap: () {
                        setState(() {
                          _selectedCompany = visibleCompanies[index];
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
        useSpacer: true,
        buttonTitle: context.t.mobileScreens.mdomCompanyChoise.selectButton,
        onPressed: _onSelectTap,
        buttonActive: buttonActive,
      );

  void _onSelectTap() {
    if (_selectedCompany != null) {
      Navigator.of(context).pop<CompaniesResponseCompany>(_selectedCompany);
    }
  }
}
