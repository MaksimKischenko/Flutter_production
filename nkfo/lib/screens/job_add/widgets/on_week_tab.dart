import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';


import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class OnWeekTab extends StatefulWidget {

  final JobInsertRequest? request;
  
  const OnWeekTab({
    required this.request,
  });

  @override
  _OnWeekTabState createState() => _OnWeekTabState();
}


class _OnWeekTabState extends State<OnWeekTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });
  final Map<String, bool> _daysOfWeek = DaysOfWeekGenerator().daysOfWeek;
  final Map<String, int> _daysOfWeekToCheked = DaysOfWeekGenerator().daysOfWeekToChecked;
  
  //Static!!
  final Map<String, int> _daysOfWeekToValidation = DaysOfWeekGenerator.daysOfWeekToValidation;
  String? inputString;
  int selectedDay= -1;


  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '####');
  }

  @override
  void dispose() {
    DaysOfWeekGenerator.daysofWeekValueForValidation.clear();
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
            labelText: 'Каждые N (нед.)',
            formatter: _formatter,
            maxLength: 4,
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
      ..._daysOfWeek.map((key, value) => MapEntry<String, Widget>(key, Div(
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
                //print(DaysOfWeekGenerator.daysofWeekValueForValidation);
              } else {
                _daysOfWeekToCheked[key] = 0;
                //CLEAR
                DaysOfWeekGenerator.daysofWeekValueForValidation.removeWhere((element) 
                => element ==_daysOfWeekToValidation[key]);
                _daysOfWeek.update(key, (value) => false);
                _daysOfWeekToCheked.update(key, (value) => 0);
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