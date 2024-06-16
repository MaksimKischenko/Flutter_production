import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class TextFieldDropdownSearch<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T item) itemBuilder;
  final T? selected;
  final Function(T item)? onTap;
  final double width;
  final bool editable;
  final Function(T? item)? onSaved;
  final String? Function()? validator;
  final bool showSearchBox;
  final String emptyMessage;
  final double maxHeight;

  const TextFieldDropdownSearch({
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.selected,
    this.onTap,
    this.width = 350,
    this.editable = true,
    this.onSaved,
    this.validator,
    this.showSearchBox = true,
    this.emptyMessage = 'Не выбрано',
    this.maxHeight = 220,
    Key? key,
  }) : super(key: key);

  

  @override
  _TextFieldDropdownSearchState<T> createState() => _TextFieldDropdownSearchState<T>();
}

class _TextFieldDropdownSearchState<T> extends State<TextFieldDropdownSearch<T>> {

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
      popupProps: PopupProps.menu(
        showSearchBox:widget.showSearchBox,
        constraints: BoxConstraints(
          maxHeight: widget.maxHeight
        )
      ),
      enabled: widget.editable,
      items: widget.items,
      selectedItem: widget.selected,
      itemAsString: (item) => widget.itemBuilder(item!),
      dropdownButtonProps: const DropdownButtonProps(
        splashRadius: 1
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
          alignLabelWithHint: true,
          filled: true,
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppStyles.mainColor, width: 1),
            borderRadius: BorderRadius.circular(5)
          ),
          fillColor: !widget.editable ? Colors.grey.shade300 : AppStyles.mainColor.withOpacity(0.03),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1)
          ),
          labelText: widget.title,
          labelStyle: AppStyles.labelTextFieldStyle,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5)
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: AppStyles.mainColor.withOpacity(0.4), width: 1),
          //   borderRadius: BorderRadius.circular(5)
          // ),
        ),        
      ),
      onSaved: (_) => widget.onSaved?.call(widget.selected),
      validator: (_) => widget.validator?.call(),
    ),
  );
}
