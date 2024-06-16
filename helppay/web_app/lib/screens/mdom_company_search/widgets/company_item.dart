import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class CompanyItem extends StatelessWidget {
  final InfoSupplierResponseCompany company;
  final bool selected;
  final Function() onTap;

  const CompanyItem(
      {required this.company, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: Text(
                  company.objectParam!.params![2].evalue.toString(),
                  style: const TextStyle(
                      color: AppStyles.mainColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(width: 4),
              if (selected)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.check,
                    color: AppStyles.mainColor,
                    size: 24,
                  ),
                )
            ],
          ),
        ),
      );
}
