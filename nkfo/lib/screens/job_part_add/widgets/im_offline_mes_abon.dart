import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ImOfflineMesAbonTab extends StatefulWidget {

  final JobPartInsertRequest request;
  final List<MessageType>? messageTypes;

  const ImOfflineMesAbonTab({
    required this.request,
    this.messageTypes,
    Key? key,
  }) : super(key: key);

  
  @override
  _ImOfflineMesAbonTabState createState() => _ImOfflineMesAbonTabState();
}

class _ImOfflineMesAbonTabState extends State<ImOfflineMesAbonTab> {

  bool useElSign = false;
  bool passiveFtp = false;
  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  MessageType? _selectedMessageType;

  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '########');
  }
  
  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
      Div(
        colL: 6,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: TextFieldDropdownSearch<MessageType>(
            title: 'Тип сообщения',
            showSearchBox: false,
            maxHeight: 150,
            items: widget.messageTypes ?? [],
            itemBuilder: (item) => item.name ?? '',
            selected: _selectedMessageType,
            onTap: (item) {
              setState(() {
                _selectedMessageType = item;
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
      Div(
        colL: 6,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrTextField(
            formatter: _formatter,
            labelText: 'Максимальный размер файла (КБ)',
            maxLength: 10,
            onSaved: (value) {
              widget.request.maxFileSize = int.tryParse(value) ?? 0;
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

