import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ExOfflineMesAbonTab extends StatefulWidget {

  final JobPartInsertRequest request;

  const ExOfflineMesAbonTab({
    required this.request,
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
            labelText: 'SQL-запрос',
            maxLength: 10000,
            maxLines: 100,
            onSaved: (value) {
              widget.request.sql = value;
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
            value: useElSign,
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
            value: passiveFtp,
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