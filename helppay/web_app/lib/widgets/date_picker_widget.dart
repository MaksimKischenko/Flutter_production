import 'package:flutter/material.dart';
import 'package:helppay_core/utils/utils.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/date_helper.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'date_picker_widget');

class WebDatePicker extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? initialValue;
  final bool editable;
  final bool mandatory;
  final bool needValidation;

  /// Called when the user picks a day.
  final ValueChanged<DateTime?> onChange;
  final Function(String?)? onSaved;
  final String? Function()? validator;
  final TextStyle? style;
  final double width;

  /// The prefix of date form field
  final Widget? prefix;
  final String dateformat;

  const WebDatePicker({
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
    this.onSaved,
    this.validator,
    this.style,
    this.width = 200,
    this.prefix,
    this.dateformat = 'dd.MM.yyyy',
  });

  @override
  _WebDatePickerState createState() => _WebDatePickerState();
}

class _WebDatePickerState extends State<WebDatePicker> {
  final _formatter =
      MaskTextInputFormatter(mask: '', filter: {'#': RegExp('[0-9]')});

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
      _datetimeController?.text =
          _selectedDate?.parseToString(widget.dateformat) ?? '';
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        Future.delayed(
          const Duration(milliseconds: 300),
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
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5.0),
          child: Material(
            elevation: 5,
            child: SizedBox(
              height: 250,
              child: CalendarDatePicker(
                firstDate: _firstDate,
                lastDate: _lastDate,
                initialDate: _selectedDate ?? DateTime.now(),
                onDateChanged: onChange,
              ),
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
          child: SizedBox(
            width: widget.width,
            child: TextFormField(
              readOnly: !widget.editable,
              focusNode: widget.editable ? _focusNode : null,
              controller: _datetimeController,
              inputFormatters: [_formatter],
              cursorColor: AppStyles.mainColor,
              style: TextStyle(
                  color: widget.editable
                      ? AppStyles.mainTextColor
                      : AppStyles.mainTextColor.withOpacity(0.55),
                  fontSize: 15),
              decoration: InputDecoration(
                alignLabelWithHint: true,
                filled: true,
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppStyles.mainColor, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                fillColor: !widget.editable
                    ? Colors.grey.shade300
                    : AppStyles.mainColor.withOpacity(0.03),
                suffixIcon: widget.editable ? _buildPrefixIcon() : null,
                labelText: widget.mandatory
                    ? '${widget.labelText} *'
                    : widget.labelText,
                // labelStyle: AppStyles.labelTextFieldStyle,
                helperText: widget.hintText,
                hintStyle: const TextStyle(color: AppStyles.mainTextColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1)),
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 1),
                //   borderRadius: BorderRadius.circular(5)
                // )
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
              validator: (value) {
                if (widget.editable && widget.needValidation) {
                  if (value?.isEmpty ?? true) return 'Некорректная дата';
                  return widget.validator?.call();
                }
                return null;
              },
            ),
          ),
        ),
      );

  Widget _buildPrefixIcon() {
    if (_datetimeController!.text.isNotEmpty && _isEnterDateField) {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _datetimeController?.clear();
          _selectedDate = null;
        },
        splashRadius: 16,
        color: AppStyles.mainColor,
      );
    } else {
      return widget.prefix ??
          const Icon(Icons.date_range, color: AppStyles.mainColor);
    }
  }
}
