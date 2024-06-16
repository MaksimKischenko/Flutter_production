import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// ignore: must_be_immutable
class ImOfflineMesAbonTab extends StatefulWidget {

   final JobPartUpdateRequest request;
   final JobPart? jobPart;
   final List<MessageType>? messageTypes;
   MessageType? selectedMessageType;
   final  TextEditingController jobPartSqlTextController;
   final TextEditingController jobPartTempFileNameController;
   final TextEditingController jobPartMaxFileSizeController;

   ImOfflineMesAbonTab({
    required this.request,
    required this.jobPart,
    required this.selectedMessageType,
    required this.messageTypes,
    required this.jobPartSqlTextController,
    required this.jobPartTempFileNameController,
    required this.jobPartMaxFileSizeController,
    
  }) ;

  @override
  _ImOfflineMesAbonTabState createState() => _ImOfflineMesAbonTabState();
}

class _ImOfflineMesAbonTabState extends State<ImOfflineMesAbonTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });
  bool useElSign = false;
  bool passiveFtp = false;

  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '##########');
  }
  
  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
      Div(
        colL:6,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: TextFieldDropdownSearch<MessageType>(
            title: 'Тип сообщений',
            showSearchBox: false,
            maxHeight: 150,
            items: widget.messageTypes ?? [],
            itemBuilder: (item) => item.name ?? '',
            selected: widget.selectedMessageType,
            onTap: (item) {
              setState(() {
                widget.selectedMessageType = item;
              });
            },
            onSaved: (value) {
              widget.request.periodTypeName = value?.name;
              widget.request.messageTypeId = value?.id;

            },
          ),
        ),
      ),
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
      Div(
        colL: 6,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrTextField(
            formatter: _formatter,
            controller: widget.jobPartMaxFileSizeController,
            labelText: 'Максимальный размер файла (КБ)',
            maxLength: 10,
            onSaved: (value) {
              if ((widget.jobPart?.maxFileSize ?? '') != value) {
                widget.request.maxFileSize = int.tryParse(value) ?? 0;
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
            value: widget.request.useEsign == 1,
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
            value: widget.request.ftpIspassiveModeN == '1',
            onChanged: (value) {
              setState(() {
                passiveFtp = !passiveFtp;
                if(value) {
                  widget.request.ftpIspassiveModeN = '1';
                } else {
                  widget.request.ftpIspassiveModeN = '0';
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