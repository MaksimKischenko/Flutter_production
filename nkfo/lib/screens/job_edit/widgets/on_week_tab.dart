import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class OnWeekTab extends StatefulWidget {

  final JobUpdateRequest? request;
  final TextEditingController everyNweekController;

  
  const OnWeekTab({
    required this.request,
    required this.everyNweekController,
  });

  @override
  _OnWeekTabState createState() => _OnWeekTabState();
}

class _OnWeekTabState extends State<OnWeekTab> {
  
  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

   final Map<String, bool> _daysOfWeek = DaysOfWeekGenerator().daysOfWeek;
   final Map<String, int> _daysOfWeekToCheked = DaysOfWeekGenerator().daysOfWeekToChecked;

  
  final Map<String, int> _daysOfWeekToValidation = DaysOfWeekGenerator.daysOfWeekToValidation;
  String? inputString;
  int selectedDay = -1;
  List<String> days = [];
  List<String> incomeForValidation = [];
  List<bool> parsedData = [];

  @override
  void initState() {
    super.initState();

    incomeForValidation = widget.request?.someDay?.characters.toList() ?? []; 

    for (var i = 0; i < incomeForValidation.length; i++) {
      if (incomeForValidation[i] == '1') {
        DaysOfWeekGenerator.daysofWeekValueForValidation.add(i+1);
        _daysOfWeekToCheked.update(DaysOfWeekGenerator.daysOfWeekInList[i], (value) => 1);
      }
    } 
    parsedData = widget.request?.someDay?.split('').map((it) => it == '1').toList() ?? [];
  
    final _dayIndexes = _daysOfWeek.keys.toList().asMap();
  
    for (var i = 0; i < parsedData.length; i++) {
      _daysOfWeek.update(_dayIndexes[i] ?? '', (_) => parsedData[i], ifAbsent: () => false);
    }
  
    _formatter.updateMask(mask: '####');
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
            controller: widget.everyNweekController,
            labelText: 'Каждые N (нед.)',
            maxLength: 10,
            onSaved: (value) {
              widget.request?.isEveryNWeek = int.tryParse(value) ?? 0;
              widget.request?.isNvalue = int.tryParse(value) ?? 0;
            },
          ),
        ),
      ),
      Div(
        colL: 6,
        colM: 12,
        child: Container(),
      ),
      ..._daysOfWeek.
      map((key, value) => MapEntry<String, Widget>(key, Div(
        colL: 3,
        colM: 6,
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
                selectedDay = _daysOfWeekToValidation[key] ?? -1;
                if(!DaysOfWeekGenerator.daysofWeekValueForValidation.contains(selectedDay)) {
                  DaysOfWeekGenerator.daysofWeekValueForValidation.add(selectedDay);
                } 
                inputString = _daysOfWeekToCheked.values.join();
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
            text: key,
            padding: EdgeInsets.zero,
          ),
        ),
      ))).values.toList(),
    ],
  );
}
