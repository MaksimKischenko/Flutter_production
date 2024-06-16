import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';

import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class OnMinuteTab extends StatefulWidget {

  final JobInsertRequest? request;
  
  const OnMinuteTab({
    required this.request,
  });

  @override
  _OnMinuteTabState createState() => _OnMinuteTabState();
}

class _OnMinuteTabState extends State<OnMinuteTab> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  bool fromToTime = false;
  bool onWorkDays = false;
  DateTime? fromTime;
  DateTime? toTime;

  @override
  void initState() {
    super.initState();
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
            labelText: 'Каждые N (мин.)',//minutNum
            maxLength: 4,
            onSaved: (value) {
              widget.request?.everyNMin = int.tryParse(value) ?? 0; 
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
            value: fromToTime,
            onChanged: (value) {
              setState(() {
                fromToTime = !fromToTime;
                if (fromToTime) {
                  widget.request?.isFromToTime = '1';
                } else {
                    widget.request?.isFromToTime = '0';
                    fromTime = null;
                    toTime = null;
                    widget.request?.fromTime = null;
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

  List<Widget> isTimeTap() {
    if (fromToTime){
      return [
        Div(
          colL: 2,
          colM: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttrTimeJob(
              labelText: 'C времени',
              initialValue: fromTime?.toStringFormattedHoursOnly() ?? '',
              onChangeDate: (value) {
                fromTime = value;
                widget.request?.fromTime = value;
              },
              validator: () {
                if (fromTime!.isAfter(toTime ?? DateTime.now())) {
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
              initialValue: toTime?.toStringFormattedHoursOnly() ?? '',
              onChangeDate: (value) {
                toTime = value;
                widget.request?.toTime = value;
              },
              validator: () {
                if (toTime!.isBefore(fromTime!)) {
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