// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProgressIndicatorElement extends StatelessWidget {
  final int currentPage;
  final int index;

  const ProgressIndicatorElement({
    Key? key,
    required this.currentPage,
    required this.index,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width/5.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),    
        color: index <= currentPage ? Colors.green : Colors.grey.withOpacity(0.4), 
      ),
    );
}
