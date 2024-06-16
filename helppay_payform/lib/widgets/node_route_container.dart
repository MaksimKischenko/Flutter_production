// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/navigation.dart';

import 'package:helppay_payform_app/styles.dart';

class NodeRouteContainer extends StatelessWidget {
  final Service? prevNode;

  const NodeRouteContainer({
    Key? key,
    required this.prevNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => prevNode != null
      ? MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigation.toInitHelppayServices(
                node: prevNode,
                nodeId: prevNode!.id,
                nodeType: prevNode!.nodeType,
              );
            },
            child: Text(
              prevNode!.name,
              style: GoogleFonts.openSans(
                color: AppStyles.mainColorLight,
                fontSize: 12,
              ),
            ),
          ),
        )
      : SizedBox.shrink();
}
