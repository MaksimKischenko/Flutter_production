import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class DropDown<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T item) itemBuilder;
  final T? selected;
  final Function(T item)? onTap;
  final double width;
  final double height;
  final bool mandatory;
  final bool editable;
  final Function(T? item)? onSaved;
  final String? Function()? validator;
  final bool showSearchBox;
  final String emptyMessage;

  const DropDown({
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.selected,
    this.onTap,
    this.width = 350,
    this.height = 200,
    this.mandatory = false,
    this.editable = true,
    this.onSaved,
    this.validator,
    this.showSearchBox = false,
    this.emptyMessage = 'Не выбрано',
    Key? key,
  }) : super(key: key);

  

  @override
  _DropDownState<T> createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      _controller.text = widget.itemBuilder(widget.selected!);
    } else {
      _controller.text = widget.emptyMessage;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => SizedBox(
    width: widget.width,
    child: DropdownSearch<T>(
      onChanged: (value) => widget.onTap?.call(value!),
      enabled: widget.editable,
      items: widget.items,
      selectedItem: widget.selected,
      itemAsString: (item) => widget.itemBuilder(item!),
      popupProps: PopupProps.menu(
        constraints: BoxConstraints(
          maxHeight: widget.height
        )
      ),
      dropdownButtonProps: const DropdownButtonProps(
        splashRadius: 1
      ),      
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: AppStyles.inputLabelStyle,
          dropdownSearchDecoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
          alignLabelWithHint: true,
          filled: true,
          suffixIconConstraints: const BoxConstraints(maxHeight: 36),   
          isDense: true,
          labelStyle: AppStyles.inputLabelStyle,
          hintStyle: AppStyles.textStyleHint,
          fillColor: !widget.editable ? Colors.grey.shade300 : AppStyles.colorGrey4,
          labelText: widget.mandatory ? '${widget.title} *' : widget.title,
          hintText: widget.mandatory? '${widget.title} *' : widget.title,
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
      ),
      onSaved: (_) => widget.onSaved?.call(widget.selected),
      validator: (_) => widget.validator?.call(),
    ),
  );
}
