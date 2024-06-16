import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final String? organizationName;
  final List<Widget>? actions;
  final Color? statusColor;
  final String? statusName;

  const CommonAppBar({
    required this.title,
    this.organizationName,
    this.actions,
    this.statusColor,
    this.statusName,
  });
  
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
              if(Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                Navigation.toOrganizations();
              }
          },
           //Navigator.of(context).pop(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_left, size: 32),
              const SizedBox(width: 16),
              Text(
                title,
                style: AppStyles.headerTextStyle
              ),
            ],
          ),
        ),
        if (organizationName?.isNotEmpty ?? false)
        Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.only(left: 16),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: AppStyles.mainColor,
                width: 2
              )
            )
          ),
          child: Text(
            organizationName!,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ),
        if (statusColor != null)
        Padding(
          padding: const EdgeInsets.only(left:16),
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor
            ),
          ),
        ),
        if (statusName != null)
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            statusName!,
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: AppStyles.mainColorDark
            )
          ),
        ),
        const Spacer(),
        if (actions?.isNotEmpty ?? false)
        ...actions!.map((e) => SizedBox(
          height: 30,
          child: e
        )).toList(),
      ],
    ),
  );
}