import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ExOfflineMesAbonTab extends StatefulWidget {

  final JobPartUpdateRequest request;
  final JobPart? jobPart;
  final TextEditingController jobPartSqlTextController;

  const ExOfflineMesAbonTab({
    required this.request,
    required this.jobPartSqlTextController,
    this.jobPart,
    Key? key,
  }) : super(key: key);

 
  @override
  _ExOfflineMesAbonTabState createState() => _ExOfflineMesAbonTabState();
}

class _ExOfflineMesAbonTabState extends State<ExOfflineMesAbonTab> {

  bool useElSign = false;
  bool passiveFtp = false;
  
  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
      Div(
        colL: 12,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrTextField(
            controller: widget.jobPartSqlTextController,
            labelText: 'SQL-запрос',
            maxLength: 10000,
            maxLines: 100,
            onSaved: (value) {
              if ((widget.jobPart?.sql ?? '') != value) {
                widget.request.sql = value;
              } else {
                widget.request.sql = null;
              }
            },
          ),
        ),
      ),
      Div(
        colL: 12,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: AttrLogic(
            value: widget.request.useEsign ==1,
            onChanged: (value) {
              setState(() {
                useElSign = !useElSign;
              });
            },
            text: 'Использовать электронную подпись',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      Div(
        colL: 12,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrLogic(
            value: widget.request.ftpIspassiveMode =='1',
            onChanged: (value) {
              setState(() {
                passiveFtp = !passiveFtp;
                if(value) {
                  widget.request.ftpIspassiveMode = '1';
                } else {
                  widget.request.ftpIspassiveMode = '0';
                }
              });
            },
            text: 'Пассивный режим при работе с FTP',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    ],
  );
}