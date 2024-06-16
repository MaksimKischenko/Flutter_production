import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ComFileTab extends StatefulWidget {

  final JobPartInsertRequest request;

  const ComFileTab({
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  _ComFileTabState createState() => _ComFileTabState();
}

class _ComFileTabState extends State<ComFileTab> {
  
  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Командный файл',
              maxLength: 128,
              onSaved: (value) {
                widget.request.comFile = value;
              },
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Параметры командного файла',
              maxLength: 128,
              onSaved: (value) {
                widget.request.paramComFile = value;
              },
            ),
          ),
        ),
    ],
  );
}