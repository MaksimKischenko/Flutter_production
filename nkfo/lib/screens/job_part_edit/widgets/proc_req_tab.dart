import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// ignore: must_be_immutable
class ProcReqTab extends StatefulWidget {

  final JobPartUpdateRequest request;
  final JobPart? jobPart;
  final List<PeriodType>? periodTypes;
  PeriodType? selectedPeriodType;
  final TextEditingController jobPartSqlTextController;
  final TextEditingController jobPartNumOfPrevPeriodController;
  final TextEditingController jobPartIdFieldNameController;
  final TextEditingController jobPartSumFieldNameController;

  ProcReqTab({
    required this.request,
    required this.jobPart,
    required this.periodTypes,
    required this.selectedPeriodType,
    required this.jobPartSqlTextController,
    required this.jobPartNumOfPrevPeriodController,
    required this.jobPartIdFieldNameController,
    required this.jobPartSumFieldNameController
  });

  
  @override
  _ProcReqTabState createState() => _ProcReqTabState();
}

class _ProcReqTabState extends State<ProcReqTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  bool isUseDate = false; //формировать за период
  bool isForCurePeriod = false; //за текущий период  

  @override
  void initState() {
    super.initState();
    isForCurePeriod = widget.request.isForCurPeriod == '1';
    _formatter.updateMask(mask: '##########');
    if(widget.jobPart?.numOfPrevPeriod == null) { //
      widget.jobPartNumOfPrevPeriodController.text = '';
    }
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
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: AttrLogic(
              value: widget.request.isUseDate == '1',
              onChanged: (value) {
                setState(() {
                  isUseDate = !isUseDate;
                  if (value) {
                    widget.request.isUseDate = '1';
                  } else {
                    widget.request.isUseDate = '0';
                    widget.request.isForCurPeriod = '0';
                    widget.jobPartNumOfPrevPeriodController.text = '';
                    isForCurePeriod = false;
                    widget.selectedPeriodType = null;
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
              isReadOnly: widget.request.isUseDate != '1',
              formatter: _formatter,
              controller: widget.jobPartNumOfPrevPeriodController,
              labelText: 'Кол-во предыдущих периодов',
              maxLength: 10,
              onSaved: (value) {
              if ((widget.jobPart?.numOfPrevPeriod ?? '') != value) {
                widget.request.numOfPrevPeriod = int.tryParse(value) ?? 0;
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
            child: TextFieldDropdownSearch<PeriodType>(
              editable: widget.request.isUseDate == '1',
              title: 'Тип периода',
              showSearchBox: false,
              maxHeight: 290,
              items: widget.periodTypes ?? [],
              itemBuilder: (item) => item.name,
              selected: widget.selectedPeriodType,
              onTap: (item) {
                setState(() {
                  widget.selectedPeriodType = item;
                });
              },
              onSaved: (value) {
                widget.request.periodTypeName = value?.name;
                widget.request.periodType = value?.id;
                
                if(widget.selectedPeriodType == null) {
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
              editable: widget.request.isUseDate == '1',
              value: isForCurePeriod,   
              onChanged: (value) {
                setState(() {
                  isForCurePeriod = !isForCurePeriod;
                });
                if (value) {
                  widget.request.isForCurPeriod = '1';
                } else {
                  widget.request.isForCurPeriod = '0';
                }               
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
            controller: widget.jobPartIdFieldNameController,
            labelText: 'Наименование ID поля',
            maxLength: 128,
            onSaved: (value) {
                if ((widget.jobPart?.idFieldName ?? '') != value) {
                  widget.request.idFieldName = value;
                } else {
                  widget.request.idFieldName = null;
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
            controller: widget.jobPartSumFieldNameController,
            labelText: 'Наименование SUM-поля',
            maxLength: 10,
            onSaved: (value) {
              widget.request.sumFieldName = value; 
            },
          ),
        ),
      ),
    ]
  );
}