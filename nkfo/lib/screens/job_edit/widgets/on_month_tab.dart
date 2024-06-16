import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';


import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class OMonthTab extends StatefulWidget {

  final JobUpdateRequest? request;
  final TextEditingController everyNController;
  final TextEditingController everyNweekController;
  
  const OMonthTab({
    required this.request,
    required this.everyNController,
    required this.everyNweekController,
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
   final Map<String, int> _daysOfWeekToValidation = DaysOfWeekGenerator.daysOfWeekToValidation;
   final Map<int, int> _daysToValidation = DaysOfWeekGenerator.daysToValidation;
   final Map<String, bool> _daysOfWeekToBytesBool = DaysOfWeekGenerator().daysOfWeekToBytesBool;
   final Map<String, int> _daysOfWeekToBytesNum = DaysOfWeekGenerator().daysOfWeekToBytesNum;

  String? inputString;
  String? fromByteString;
  List<int> sum = [];
  List<bool> parsedDataIsDayWeek = []; 
  List<String> incomeForValidationIsDayWeek = [];
  List<String> incomeForValidationIsDayMonth = [];
  List<bool> parsedDataIsDayMonth = []; 
  
  bool isLastMonthDay = false;
  bool onWorkDays = false;

  @override
  void initState() {
    super.initState(); 
    _formatter.updateMask(mask: '####');
    DaysOfWeekGenerator.isDayWeek = widget.request?.someDay?.length == 7;
    //For validation with String of format like 0000111
    if(DaysOfWeekGenerator.isDayWeek) {

      incomeForValidationIsDayWeek = widget.request?.someDay?.characters.toList() ?? []; 
      for (var i = 0; i < incomeForValidationIsDayWeek.length; i++) {
        if (incomeForValidationIsDayWeek[i] == '1') {
          DaysOfWeekGenerator.daysofWeekValueForValidation.add(i+1);
          _daysOfWeekToCheked.update(DaysOfWeekGenerator.daysOfWeekInList[i], (value) => 1);
        }
      }   
      parsedDataIsDayWeek = widget.request?.someDay?.split('').map((it) => it == '1').toList() ?? [];
  
      final _dayIndexes = _daysOfWeek.keys.toList().asMap();
  
      for (var i = 0; i < parsedDataIsDayWeek.length; i++) {
        _daysOfWeek.update(_dayIndexes[i] ?? '', (_) => parsedDataIsDayWeek[i], ifAbsent: () => false);
      }
    }
    //FOR validation with bytes operations 
    //(check while our Num contains last byte. If No return 0 
    //if Yes return Num of pow)
    final nWeek = int.tryParse(widget.everyNweekController.text) ?? 0;	
    for (var i = 0; i <= 4; i++) {
      final temp =  nWeek & pow(2,i).toInt();
      if(temp != 0 ) {
        parsedDataIsDayWeek.insert(i, true);
        DaysOfWeekGenerator.orderDaysForValidation.add(i+1);
        sum.add(pow(2,i).toInt()); 
      } else {
        parsedDataIsDayWeek.insert(i, false);
      }
     _daysOfWeekToBytesBool.update(_daysOfWeekToBytesBool.keys.toList()[i],(_)=>parsedDataIsDayWeek[i]);
    }

    DaysOfWeekGenerator.isDayMonth = widget.request?.someDay?.length != 7;

    if(DaysOfWeekGenerator.isDayMonth) {
      incomeForValidationIsDayMonth = widget.request?.someDay?.characters.toList() ?? []; 
      for (var i = 0; i < incomeForValidationIsDayMonth.length; i++) {
        if (incomeForValidationIsDayMonth[i] == '1') {
          DaysOfWeekGenerator.daysValueForValidation.add(i+1);
          _daysToCheked.update(i+1, (value) => 1);
        }
      }  
      parsedDataIsDayMonth = widget.request?.someDay?.split('').map((it) => it == '1').toList() ?? [];
    
      final _dayIndexes = _days.keys.toList().asMap();
    
      for (var i = 0; i < parsedDataIsDayMonth.length; i++) {
        _days.update(_dayIndexes[i]!, (_) => parsedDataIsDayMonth[i], ifAbsent: () => false);
      }
    }
    isLastMonthDay = widget.request?.isLastMonthDay == '1';
    onWorkDays = widget.request?.isWorkDay == '1';
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
            controller: widget.everyNController,
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
      ..._days.
      map((key, value) => MapEntry<int, Widget>(key, Div(
        colL: 3,
        colM: 3,
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
                //print(DaysOfWeekGenerator.daysValueForValidation);
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
      ..._dayWeekTap(),
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

List<Widget> _dayWeekTap () {
    if(DaysOfWeekGenerator.isDayWeek) {
      return [
      ..._daysOfWeekToBytesBool.
      map((key, value) => MapEntry<String, Widget>(key, Div(
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

                if(!sum.contains(1<<_daysOfWeekToBytesNum[key]!)) {
                  sum.add(1<<_daysOfWeekToBytesNum[key]!);
                }

                for (final element in sum) {
                  eveyNWeek = eveyNWeek + element;
                }
               widget.request?.isEveryNWeek = eveyNWeek; 
               //print(DaysOfWeekGenerator.orderDaysForValidation);
              } else {
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
      ..._daysOfWeek.
        map((key, value) => MapEntry<String, Widget>(key, Div(
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
      ))).values.toList(),
      ];
    } else {
      return [];
    }
  }
}