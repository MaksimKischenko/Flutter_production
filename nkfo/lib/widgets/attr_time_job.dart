import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';

class AttrTimeJob extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final String initialValue;
  final bool editable;
  final bool mandatory;
  final bool needValidation;
  final String? Function()? validator;
  final Function(DateTime value)? onChangeDate;

  const AttrTimeJob({
    required this.labelText,
    this.hintText,
    this.initialValue = '',
    this.editable = true,
    this.mandatory = false,
    this.needValidation = true,
    this.validator,
    this.onChangeDate,
  });

  @override
  _AttrTimeJobState createState() => _AttrTimeJobState();
}

class _AttrTimeJobState extends State<AttrTimeJob> {


  TextEditingController? _timeController;
  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });
  
  @override
  void initState() {
    super.initState();
    _formatter.updateMask(mask: '##:##');
    _timeController = TextEditingController(text: widget.initialValue);
    
  }

  @override
  Widget build(BuildContext context) => TextFormField(
    readOnly: true,
    controller: _timeController,
    inputFormatters: [_formatter],
    onTap: () {
      if (widget.editable) _showTimePicker();
    },
    style: TextStyle(
      color: widget.editable
        ? AppStyles.mainTextColor
        : AppStyles.mainTextColor.withOpacity(0.55),
        // fontSize: 14
    ),
    decoration: InputDecoration(
      alignLabelWithHint: true,
      filled: true,
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppStyles.mainColor, width: 1),
        borderRadius: BorderRadius.circular(5)
      ),
      fillColor: !widget.editable ? Colors.grey.shade300 : AppStyles.mainColor.withOpacity(0.03),
      labelText: widget.mandatory ? '${widget.labelText} *' : widget.labelText,
      suffixIcon: IconButton(
        splashRadius: 1,
        onPressed: _showTimePicker,
        icon: const Icon(Icons.watch_later_rounded, color: AppStyles.mainColor)),
      labelStyle: AppStyles.labelTextFieldStyle,
      helperText: widget.hintText,
      hintStyle: const TextStyle(
        color: AppStyles.mainTextColor,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5)
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderSide:  BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 1),
      //   borderRadius: BorderRadius.circular(5)
      // )
    ),
    validator: (value) {
      if(widget.editable && widget.needValidation) {
        if ((value?.isEmpty ?? true) && widget.mandatory && (value?.length ?? 0) == 5) return 'Некорректное время';

        final list = value!.split(':');

        final hours = int.parse(list.first);
        final minutes = int.parse(list.last);

        if (hours > 24 || minutes > 59) {
          _timeController?.clear();
          return 'Неккоректное \nвремя';
        }
        return widget.validator?.call();
        }
      return null;
    },
  );


  Future<void> _showTimePicker() async{
    TimeOfDay? pickedTime;

    pickedTime = await Multiplatform.showOnlyTimePicker(
      context: context, 
      initialDate: _timeController?.text.toDateFormattedOnlyTime() ?? DateTime.now(),
    );

    if (pickedTime != null) {
      final year = DateTime.now().year;
      final _date = DateTime(year, 0, 0, pickedTime.hour, pickedTime.minute);
      _timeController?.text = _date.toStringFormattedHoursOnly();
      widget.onChangeDate?.call(_date);
    }
  }
}