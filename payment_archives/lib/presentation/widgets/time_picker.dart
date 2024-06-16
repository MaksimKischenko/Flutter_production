import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';


class TimePicker extends StatefulWidget {
  final String? labelText;
  final String? initialValue;
  final bool needValidation;
  final Function(DateTime value)? onSaved;
  final Function(DateTime value)? onChanged;
  final String? Function(String?)? validator;
  final bool editable;

  const TimePicker({
    this.labelText,
    this.initialValue,
    this.needValidation = true,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.editable = true
  });

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  late TextEditingController _timeController;
  final _formatter = MaskTextInputFormatter(mask: '##:##', filter: {'#': RegExp('[0-9]')});

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController(text: widget.initialValue);
  }
 
@override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 120,
    child: TextFormField(
      readOnly: !widget.editable,
      controller: _timeController,
      inputFormatters: [_formatter],
      cursorColor: AppStyles.colorDark,
      style: AppStyles.textStyleBlackTextFieldsContent,
      minLines: 1,
      cursorWidth: 1,
      maxLength: 5,
      decoration: InputDecoration(
          alignLabelWithHint: true,
          contentPadding: AppStyles.contentPadding,
          suffixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child:  Icon(Icons.timer_outlined, color: AppStyles.colorDark3),
          ),
          suffixIconConstraints: const BoxConstraints(maxHeight: 12),
          filled: true,
          isDense: true,
          fillColor: AppStyles.colorGrey4,
          hintText: '${widget.labelText} *',
          labelText: '${widget.labelText} *',
          hintStyle: AppStyles.textStyleHint,
          labelStyle: AppStyles.inputLabelStyle,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(),
            borderSide: BorderSide(color: AppStyles.colorBlue2, width: 1),
          ),       
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(),
            borderSide: BorderSide(color: AppStyles.colorGrey4, width: 1),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(),
            borderSide: BorderSide(color: AppStyles.errorColor, width: 1),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(),
            borderSide: BorderSide(color: AppStyles.errorColor, width: 1),
          ),             
        ),
        validator: (value) {
          if(widget.needValidation) {
            if (value?.isEmpty ?? true ) {
              return 'Неккоректное \nвремя';
            }
            final list = (value ?? '').split(':');
            final hours = int.parse(list.first);
            final minutes = int.parse(list.last);
            if (hours > 24 || minutes > 59) {
              _timeController.clear();
              return 'Неккоректное \nвремя';
            }
            return widget.validator?.call(value);
          }
          return null;
        },
        onChanged: (value) => widget.onChanged?.call(value.toDateFormattedOnlyTime() ?? DateTime.now()),
        onSaved: (value) => widget.onSaved
            ?.call(value?.toDateFormattedOnlyTime() ?? DateTime.now())),
  );
}
