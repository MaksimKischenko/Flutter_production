import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'ftp_from.dart';

class ExpOfflineMesTab extends StatefulWidget {

  final JobPartInsertRequest request;
  final List<PeriodType> periodTypes;

  const ExpOfflineMesTab({
    required this.request,
    required this.periodTypes,   
    Key? key,
  }) : super(key: key);

  @override
  _ExpOfflineMesTabState createState() => _ExpOfflineMesTabState();
}

class _ExpOfflineMesTabState extends State<ExpOfflineMesTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  bool isUseDate = false; 
  bool isForCurePeriod = false;  
  bool isFtpFrom = false;  
  bool useElSign = false;
  TextEditingController numOfPrevPeriodController  = TextEditingController();

  PeriodType? _selectedPeriodType;
  
  String localDirection = 'file://';
  String ftpDirection = 'ftp://';


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
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: AttrLogic(
              value: isUseDate,
              onChanged: (value) {
                setState(() {
                  isUseDate = !isUseDate;
                  if (value) {
                    widget.request.isUseDate = '1';          
                  } else {
                    widget.request.isUseDate = '0';
                    widget.request.isForCurPeriod = '0';
                    numOfPrevPeriodController.text = '';
                    isForCurePeriod = false;
                    _selectedPeriodType = null;
                  }
                });
              },
              text: 'Формировать за период',
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              isReadOnly: !isUseDate,
              controller: numOfPrevPeriodController,
              formatter: _formatter,
              labelText: 'Кол-во предыдущих периодов',
              maxLength: 10,
              onSaved: (value) {
                widget.request.numOfPrevPeriod = int.tryParse(value) ?? 0; 
              },
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFieldDropdownSearch<PeriodType>(
              editable: isUseDate,
              title: 'Тип периода',
              showSearchBox: false,
              maxHeight: 290,
              items: widget.periodTypes,
              itemBuilder: (item) => item.name,
              selected: _selectedPeriodType,
              onTap: (item) {
                setState(() {
                  _selectedPeriodType = item;
                });
              },
              onSaved: (value) {
                widget.request.periodTypeName = value?.name;
                widget.request.periodType = value?.id;

                if(_selectedPeriodType == null) {
                  widget.request.periodType = 0;
                }
              },
            ),
          ),
        ), 
        Div(
          colL: 12,
          colM: 12,
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: AttrLogic(
              editable: isUseDate,
              value: isForCurePeriod,
              onChanged: (value) {
                setState(() {
                 isForCurePeriod = !isForCurePeriod;
                 if (isForCurePeriod) {
                  widget.request.isForCurPeriod = '1';
                } else {
                  widget.request.isForCurPeriod = '0';
                }
                });
              },
              text: 'Формировать за тек. период',
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        Div(
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: AttrLogic(
              value: isFtpFrom,
              onChanged: (value) {
                setState(() {
                  isFtpFrom = !isFtpFrom;
                  if(value) {
                    widget.request.isFtp = '1';
                  } else {
                    widget.request.isFtp = '0';
                  }
                });
              },
              text: 'Работа с FTP сервером',
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        if(isFtpFrom)
        FtpFrom(
          request: widget.request,
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
          colL: 6,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Директория экспорта',
              maxLength: 128,
              onSaved: (value) {
                if(isFtpFrom) {
                  widget.request.expDir = ftpDirection + value;
                } else {
                  widget.request.expDir = localDirection + value;
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
              labelText: 'Директория экспорта копии',
              maxLength: 128,
              onSaved: (value) {
                if(isFtpFrom) {
                  widget.request.copyExpDir = ftpDirection + value;
                } else {
                  widget.request.copyExpDir = localDirection + value;
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