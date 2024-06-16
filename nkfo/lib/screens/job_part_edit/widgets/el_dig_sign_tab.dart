import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ElDigSignTab extends StatefulWidget {

 final JobPartUpdateRequest request;
 final JobPart? jobPart;
 final TextEditingController jobPartImportDirController;
 final TextEditingController jobPartExportDirController;
 final TextEditingController jobPartTempFileNameController;

const ElDigSignTab({
    required this.request,
    required this.jobPartImportDirController,
    required this.jobPartExportDirController,
    required this.jobPartTempFileNameController,
    Key? key,
    this.jobPart,
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
      const SizedBox(height: 10),
      Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              controller: widget.jobPartImportDirController,
              labelText: 'Директория импорта',
              maxLength: 128,
              onSaved: (value) {
                if ((widget.jobPart?.impDir ?? '') != value) {
                  widget.request.impDir = value;
                } else {
                  widget.request.impDir = null;
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
              controller: widget.jobPartExportDirController,
              labelText: 'Директория экспорта',
              maxLength: 128,
              onSaved: (value) {
                if ((widget.jobPart?.expDir ?? '') != value) {
                  widget.request.expDir = value;
                } else {
                  widget.request.expDir = null;
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
              controller: widget.jobPartTempFileNameController,
              labelText: 'Файл-шаблон',
              maxLength: 128,
              onSaved: (value) {
                if ((widget.jobPart?.tmpFileName ?? '') != value) {
                  widget.request.tmpFileName = value;
                } else {
                  widget.request.tmpFileName = null;
                }
              },
            ),
          ),
      ),
    ],
     
  );
}