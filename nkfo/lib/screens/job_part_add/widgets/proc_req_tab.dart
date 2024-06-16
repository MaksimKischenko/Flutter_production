import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ProcReqTab extends StatefulWidget {

  final JobPartInsertRequest request;
  final List<PeriodType> periodTypes;

  const ProcReqTab({
    required this.request,
    required this.periodTypes,
    Key? key,
  }) : super(key: key);

  
  @override
  _ProcReqTabState createState() => _ProcReqTabState();
}

class _ProcReqTabState extends State<ProcReqTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  bool isUseDate = false; //формировать за период
  bool isForCurePeriod = false; //за текущий период     
  PeriodType? _selectedPeriodType;
  TextEditingController numOfPrevPeriodController  = TextEditingController();

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
              maxLines: 6,
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
                 if (value) {
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTextField(
              labelText: 'Наименование ID-поля',
              maxLength: 10,
              onSaved: (value) {
                widget.request.idFieldName = value; 
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
              labelText: 'Наименование SUM-поля',
              maxLength: 10,
              onSaved: (value) {
                widget.request.sumFieldName = value; 
              },
            ),
          ),
        ),
    ],
  );
}