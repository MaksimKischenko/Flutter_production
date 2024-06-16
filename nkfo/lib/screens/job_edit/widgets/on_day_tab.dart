import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// ignore: must_be_immutable
class OnDayTab extends StatefulWidget {

  final JobUpdateRequest? request;
  final TextEditingController everyNController;
  final TextEditingController everyNminController;
  DateTime? fromTime;
  DateTime? toTime;

   OnDayTab({
    required this.everyNController,
    required this.everyNminController,
    Key? key,
    this.request,
    this.fromTime,
    this.toTime,
  }) : super(key: key);
  
  @override
  _OnDayTabState createState() => _OnDayTabState();
}

class _OnDayTabState extends State<OnDayTab> {
  
  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  bool fromToTime = false;
  bool onWorkDays = false;


  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '####');
    fromToTime = widget.request?.isFromToTime == '1';
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
            labelText: 'Каждые N (дн.)',
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: AttrLogic(
            value: widget.request?.isFromToTime =='1',
            onChanged: (value) {
              setState(() {
              fromToTime = !fromToTime;
              if (value) {
                widget.request?.isFromToTime = '1';
              } else {
                widget
                ..request?.isFromToTime = '0'
                ..fromTime = null
                ..toTime = null
                ..request?.fromTime = null;
               }
              });
            },
            text: 'Только с* и по * время',
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      ...isTimeTap(),
      Div(
        colL: 12,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: AttrLogic(
            value: widget.request?.isWorkDay =='1',
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
      if(onWorkDays)
      Div(
        colL: 4,
        colM: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AttrTextField(
            formatter: _formatter,
            controller: widget.everyNminController,
            labelText: 'Каждые N (мин)',
            maxLength: 4,
            onSaved: (value) {
              widget.request?.everyNMin = int.tryParse(value) ?? 0; //Not needs validation 
              widget.request?.isNvalue = int.tryParse(value) ?? 0;
            },
          ),
        ),
      ),
    ],
  );

  List<Widget> isTimeTap () {
    if (fromToTime){
      return [
        Div(
          colL: 2,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTimeJob(
              labelText: 'C времени',
              initialValue: widget.fromTime?.toStringFormattedHoursOnly() ?? '',
              onChangeDate: (value) {
                widget.fromTime = value;
                widget.request?.fromTime = widget.fromTime;
              },
              validator: () {
                if (widget.fromTime!.isAfter(widget.toTime ?? DateTime.now())) {
                  return 'Время начала должно \nбыть меньше времени \nокончания';
                }
                return null;
              },
            ),
          ),
        ),
        Div(
          colL: 2,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTimeJob(
              labelText: 'По время',
              initialValue: widget.toTime?.toStringFormattedHoursOnly() ?? '',
              onChangeDate: (value) {
                widget.toTime = value;
                widget.request?.toTime = widget.toTime;
              },
              validator: () {
                if (widget.toTime!.isBefore(widget.fromTime!)) {
                  return 'Время окончания \nдолжно быть больше \nвремени начала';
                }
                return null;
              },
            ),
          ),
        )
      ];
    } else {
      return [];
    }
  }
}