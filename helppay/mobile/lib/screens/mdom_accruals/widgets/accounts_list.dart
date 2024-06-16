import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class AccountsList extends StatelessWidget {
  final List<CompaniesResponseCompany> companies;
  final Function(int supplierId, PropertyAccount account, ) onTap;
  final Function(int supplierId, int accountsCount,String supplierTitle) onPollTap;

  const AccountsList({
    required this.companies,
    required this.onTap,
    required this.onPollTap
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 64),
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        if (companies[index].propertyAccount?.isNotEmpty ?? false) {
          final company = companies[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CompanyName(company.name),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: company.propertyAccount?.length ?? 0,
                itemBuilder: (context, i) => AccountItem(
                  account: company.propertyAccount![i],
                  onTap: (account) => onTap(company.supplierId, account, ),
                )
              ),
              PollItem(
                onTap: () => onPollTap(company.supplierId, company.propertyAccount?.length ?? 0, company.name),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
      separatorBuilder: (context, _) => const SizedBox(height: 24),
    ),
  );
}