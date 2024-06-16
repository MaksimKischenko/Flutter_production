import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/utils/utils.dart';


class DatePicker extends StatefulWidget {

  final String? labelText;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? initialValue;
  final bool editable;
  final bool mandatory;
  final bool needValidation;
  final bool emptyDataValidation;
  /// Called when the user picks a day.
  final ValueChanged<DateTime?> onChange;
  final Function(String?)? onSaved;
  final String? Function()? validator;
  final TextStyle? style;
  final double width;
  /// The prefix of date form field
  final Widget? prefix;
  final String dateformat;

  
  const DatePicker({
    required this.onChange,
    this.labelText,
    this.hintText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.initialValue,
    this.editable = true,
    this.mandatory = false,
    this.needValidation = true,
    this.emptyDataValidation = true,
    this.onSaved,
    this.validator,
    this.style,
    this.width = 300,
    this.prefix,
    this.dateformat = 'dd.MM.yyyy',
  });


  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  final _formatter = MaskTextInputFormatter(mask: '', filter: { '#': RegExp('[0-9]') });

  TextEditingController? _datetimeController;
  
  final FocusNode _focusNode = FocusNode();

  late OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  

  late DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;

  bool _isEnterDateField = false;

  @override
  void initState() {
    super.initState();
     _formatter.updateMask(mask: '##.##.####');
     _datetimeController = TextEditingController(text: widget.initialValue);

    _selectedDate = widget.initialDate;
    _firstDate = widget.firstDate ?? DateTime(1900);
    _lastDate = widget.lastDate ?? DateTime(4100);

    if (_selectedDate != null) {
      _datetimeController?.text = _selectedDate?.parseToString(widget.dateformat) ?? '';
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        Future.delayed(
          const Duration(milliseconds: 100),
          () => _overlayEntry.remove(),
        );
      }
    });
  }

  void onChange(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    _datetimeController?.text = _selectedDate.parseToString(widget.dateformat);
    widget.onChange.call(_selectedDate);    
    _overlayEntry.remove();
    _focusNode.unfocus();
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox!.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
        height: 250,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5.0),
          child: Material(
            elevation: 2,
            child: CalendarDatePicker(
              firstDate: _firstDate,
              lastDate: _lastDate,
              initialDate: _selectedDate ?? DateTime.now(),
              onDateChanged: onChange,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isEnterDateField = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isEnterDateField = false;
          });
        },
        child: TextFormField(
          readOnly: !widget.editable,
          focusNode: widget.editable? _focusNode: null,
          controller: _datetimeController,
          maxLength: 10,
          minLines: 1,
          cursorWidth: 1,
          inputFormatters: [_formatter],
          cursorColor: AppStyles.colorDark,
          style: AppStyles.textStyleBlackTextFieldsContent,
          decoration: InputDecoration(
            contentPadding: AppStyles.contentPadding,
            alignLabelWithHint: true,
            filled: true,
            isDense: true,
            fillColor: widget.editable? AppStyles.colorGrey4 : Colors.grey.shade300,  
            suffixIcon: widget.editable ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildPrefixIcon(),
            ) : null,
            suffixIconConstraints: const BoxConstraints(maxHeight: 16),
            labelText: widget.mandatory ? '${widget.labelText} *' : widget.labelText,
            hintText: widget.mandatory? '${widget.labelText} *' : widget.labelText,
            helperText: widget.hintText,
            labelStyle: AppStyles.inputLabelStyle,
            hintStyle: AppStyles.textStyleHint,
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
          onChanged: (dateString) {
            final date = dateString.parseToDateTime(widget.dateformat);
            if (date.isBefore(_firstDate)) {
              _selectedDate = _firstDate;
            } else if (date.isAfter(_lastDate)) {
              _selectedDate = _lastDate;
            } else {
              _selectedDate = date;
            }
          },
          onSaved: (newValue) {
            widget.onChange.call(_selectedDate);    
          },
          onFieldSubmitted: (value) {
            widget.onChange.call(_selectedDate);    
            // Future.delayed(
            //   const Duration(milliseconds: 100),
            //   () => _overlayEntry.remove(),
            // );
            _focusNode.unfocus();
            setState(() {
              
            });
          },
          validator: (value) {
            if(widget.editable && widget.needValidation) {
              if(widget.emptyDataValidation) {
                if (value?.isEmpty ?? true ) return 'Некорректная дата';
              }
              return widget.validator?.call();
            }
            return null;
          },
        ),
      ),
    );

  Widget _buildPrefixIcon() {
    if (_datetimeController!.text.isNotEmpty && _isEnterDateField) {
      return GestureDetector(
        onTap: () {
          _datetimeController?.clear();
          _selectedDate = null;
        },
        child: const Icon(Icons.close, color:AppStyles.colorDark3, size: 16),
      );
    } else {
      return widget.prefix ?? const Icon(Icons.date_range, color:AppStyles.colorDark3, size: 16);
    }
  }
}
