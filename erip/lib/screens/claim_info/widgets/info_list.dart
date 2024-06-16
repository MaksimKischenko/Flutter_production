import 'package:flutter/material.dart';

import 'info_item.dart';

class InfoList extends StatelessWidget {
  final Map<String, dynamic> list;

  const InfoList(this.list);

  @override
  Widget build(BuildContext context) => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int i) {
        final key = list.keys.elementAt(i);
        return InfoItem(
          title: key,
          subtitle: list[key],
        );
      },
    );
}