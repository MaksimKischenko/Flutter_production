import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ElDigSignTab extends StatefulWidget {

 final JobPartInsertRequest request;

 const ElDigSignTab({
    required this.request,
    Key? key,
 }) : super(key: key);

  @override
  _ElDigSignTabState createState() => _ElDigSignTabState();
}

class _ElDigSignTabState extends State<ElDigSignTab> {

  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
      Div(
        colL: 12,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text('ДИРЕКТОРИИ', style: AppStyles.headerTextStyle)
        ),
      ),
      Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Директория импорта',
              maxLength: 128,
              onSaved: (value) {
                widget.request.impDir = value;
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
              labelText: 'Директория экспорта',
              maxLength: 128,
              onSaved: (value) {
                widget.request.expDir = value;
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
              labelText: 'Файл-шаблон',
              maxLength: 128,
              onSaved: (value) {
                widget.request.tmpFileName = value;
              },
            ),
          ),
      ),
    ],
  );
}