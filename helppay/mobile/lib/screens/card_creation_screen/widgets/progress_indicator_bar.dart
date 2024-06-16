// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'widgets.dart';

class ProgressIndicatorBar extends StatelessWidget {

  final int currentPage;

  const ProgressIndicatorBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 4,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ProgressIndicatorElement(
        currentPage: currentPage,
        index: index,
      ), 
      separatorBuilder: (context, index) => const SizedBox(width: 2), 
      itemCount: 5
    ),
  );
}
