import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ComFileTab extends StatefulWidget {

  final JobPartUpdateRequest request;
  final JobPart? jobPart;
  final TextEditingController jobPartParamComandFileController;
  final TextEditingController jobPartComandFileController;

  const ComFileTab({
    required this.request,
    required this.jobPartParamComandFileController,
    required this.jobPartComandFileController,
    this.jobPart,
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
              controller: widget.jobPartComandFileController,
              labelText: 'Командный файл',
              maxLength: 128,
              onSaved: (value) {
              if ((widget.jobPart?.comFile ?? '') != value) {
                widget.request.comFile = value;
              } else {
                widget.request.comFile = null;
              }
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
              controller: widget.jobPartParamComandFileController,
              labelText: 'Параметры командного файла',
              maxLength: 128,
              onSaved: (value) {
              if ((widget.jobPart?.paramComFile ?? '') != value) {
                widget.request.paramComFile = value;
              } else {
                widget.request.paramComFile = null;
              }
              },
            ),
          ),
        ),
    ],
  );
}