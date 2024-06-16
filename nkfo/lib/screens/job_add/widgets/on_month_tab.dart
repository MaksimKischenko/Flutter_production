
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';


import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class OMonthTab extends StatefulWidget {

  final JobInsertRequest? request;
  
  const OMonthTab({
    required this.request,
  });
  @override
  _OnMonthTabState createState() => _OnMonthTabState();
}

class _OnMonthTabState extends State<OMonthTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  final Map<int, bool> _days = DaysOfWeekGenerator().days;
  final Map<int, int> _daysToCheked = DaysOfWeekGenerator().daysToChecked;

  final Map<String, bool> _daysOfWeek = DaysOfWeekGenerator().daysOfWeek;
  final Map<String, int> _daysOfWeekToCheked = DaysOfWeekGenerator().daysOfWeekToChecked;
  final Map<String, bool> _daysOfWeekToBytesBool = DaysOfWeekGenerator().daysOfWeekToBytesBool;
  final Map<String, int> _daysOfWeekToBytesNum = DaysOfWeekGenerator().daysOfWeekToBytesNum;

  final Map<String, int> _daysOfWeekToValidation = DaysOfWeekGenerator.daysOfWeekToValidation;
  final Map<int, int> _daysToValidation = DaysOfWeekGenerator.daysToValidation;

  String? inputString;
  List<int> sum = [];
  List<int> sum2 = [];


  bool isLastMonthDay = false;
  bool onWorkDays = false;

  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '####');
  }

  @override
  void dispose() {
    DaysOfWeekGenerator.daysValueForValidation.clear();
    DaysOfWeekGenerator.daysofWeekValueForValidation.clear();
    DaysOfWeekGenerator.orderDaysForValidation.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Responsive(
    runSpacing: 0,
    children: [
      Div(
        colL: 4,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrTextField(
            formatter: _formatter,
            labelText: 'Каждые N мес ',
            maxLength: 4,
            onSaved: (value) {
              widget.request?.isNvalue = int.tryParse(value) ?? 0;
            },
          ),
        ),
      ),
      Div(
        colL: 12,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrLogic(
            value: DaysOfWeekGenerator.isDayMonth,
            onChanged: (value) {
              if (DaysOfWeekGenerator.isDayMonth) {
               
              }
              setState(() {
                DaysOfWeekGenerator.isDayMonth = !DaysOfWeekGenerator.isDayMonth;
                DaysOfWeekGenerator.isDayWeek = !DaysOfWeekGenerator.isDayWeek;
              });
            },
            text: 'По дням месяца',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      Div(
        colL: 12,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: AttrLogic(
            value: DaysOfWeekGenerator.isDayWeek,
            onChanged: (value) {
              if (DaysOfWeekGenerator.isDayWeek) {
               
              }
              setState(() {
                DaysOfWeekGenerator.isDayWeek = !DaysOfWeekGenerator.isDayWeek;
                DaysOfWeekGenerator.isDayMonth = !DaysOfWeekGenerator.isDayMonth;
              });
            },
            text: 'По дням недели',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      Div(
        colL: 12,
        colM: 12,
        child: Container(),
      ),
      if(DaysOfWeekGenerator.isDayMonth) 
      ..._days.map((key, value) => MapEntry<int, Widget>(key, Div(
        colL:3,
        colM:3,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AttrLogic(
            value: value,
            onChanged: (newValue) => setState(() {
              _days[key] = newValue;
              if(newValue) {
                _daysToCheked[key] = 1;
                //ADD
                final day = _daysToValidation[key];
                if(!DaysOfWeekGenerator.daysValueForValidation.contains(day)) {
                  DaysOfWeekGenerator.daysValueForValidation.add(day ?? -1);
                }
                inputString = _daysToCheked.values.join();
              } else {
                _daysToCheked[key] = 0;
                //CLEAR
                DaysOfWeekGenerator.daysValueForValidation.removeWhere((element) 
                => element == _daysToValidation[key]);
                _days.update(key, (value) => false);
                _daysToCheked.update(key, (value) => 0);

                inputString = _daysToCheked.values.join();
              }
              widget.request?.someDay = inputString;
            }),
            text: key.toString(),
            padding: EdgeInsets.zero,
          ),
        ),
      ))).values.toList(),
      ..._dayWeekTap(DaysOfWeekGenerator.isDayWeek),
      const Divider(),
      Div(
        colL: 12,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: AttrLogic(
            value: isLastMonthDay,
            onChanged: (value) {
              setState(() {
              isLastMonthDay = !isLastMonthDay;
              if (value) {
               widget.request?.isLastMonthDay = '1';
              } else {
                widget.request?.isLastMonthDay = '0';
              }
             });
            },
            text: 'Последний день месяца',
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
            value: onWorkDays,
            onChanged: (value) {
              setState(() {
               onWorkDays = !onWorkDays;
               if (value) {
                widget.request?.isWorkDay = '1';
              } else {
                widget.request?.isWorkDay = '0';
              }
              });
            },
            text: 'По рабочим дням',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    ],
  );

  List<Widget> _dayWeekTap (bool isDayWeek) {
    if(DaysOfWeekGenerator.isDayWeek) {
      return [
        ..._daysOfWeekToBytesBool.map((key, value) => MapEntry<String, Widget>(key, Div(
        colL: 2,
        colM: 3,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: AttrLogic(
            value: value,
            onChanged: (newValue) => setState(() {
              _daysOfWeekToBytesBool[key] = newValue;
              if(newValue) {
                DaysOfWeekGenerator.orderDaysForValidation.add(_daysOfWeekToBytesNum[key]!+1);
                var eveyNWeek = 0;
                sum.add(1<<_daysOfWeekToBytesNum[key]!);
                for (final element in sum) {
                 eveyNWeek = eveyNWeek + element;
                }
               widget.request?.isEveryNWeek = eveyNWeek;
              } 
              else {
                DaysOfWeekGenerator.orderDaysForValidation.remove(_daysOfWeekToBytesNum[key]!+1);
                var eveyNWeek = 0;
                sum.remove(1<<_daysOfWeekToBytesNum[key]!);
                for (final element in sum) {
                  eveyNWeek = eveyNWeek + element;
                }
                widget.request?.isEveryNWeek = eveyNWeek;
                if(sum.isEmpty) {
                  widget.request?.isEveryNWeek = 0;
                }
              }
            }),
            text: key.toString(),
            padding: EdgeInsets.zero,
          ),
        ),
      ))).values.toList(),
      const Divider(),
        ..._daysOfWeek.map((key, value) => MapEntry<String, Widget>(key, Div(
        colL: 3,
        colM: 3,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AttrLogic(
            value: value,
            onChanged: (newValue) => setState(() {
              _daysOfWeek[key] = newValue;
              if(newValue) {
                _daysOfWeekToCheked[key] = 1;
                //ADD
                final day = _daysOfWeekToValidation[key] ?? -1;
                if(!DaysOfWeekGenerator.daysofWeekValueForValidation.contains(day)) {
                  DaysOfWeekGenerator.daysofWeekValueForValidation.add(day);
                } 

                inputString = _daysOfWeekToCheked.values.join();
                //print(DaysOfWeekGenerator.daysofWeekValueForValidation);
              } else {
                _daysOfWeekToCheked[key] = 0;
                //CLEAR
                DaysOfWeekGenerator.daysofWeekValueForValidation.removeWhere((element) 
                => element ==_daysOfWeekToValidation[key]);
                _daysOfWeek.update(key, (value) => false);
                _daysOfWeekToCheked.update(key, (value) => 0);
                inputString = _daysOfWeekToCheked.values.join();
                
                inputString = _daysOfWeekToCheked.values.join();
              }
              widget.request?.someDay = inputString;
            }),
            text: key.toString(),
            padding: EdgeInsets.zero,
          ),
        ),
      ))).values.toList()
      ];
    } else {
      return [];
    }
  }
}